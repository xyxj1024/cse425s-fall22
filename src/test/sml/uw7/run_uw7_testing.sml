CM.make "../to_string/to_string.cm";
CM.make "../unit_testing/unit_testing.cm";
use "../../../main/sml/uw7/uw7.sml";

structure UW7Testing :> sig
    val test_complete : unit -> unit
end = struct
	structure GeometryExpressionToString = ToStringFn(struct
        type t = geom_exp
		fun toString(NoPoints) = "NoPoints"
		|   toString(Point(x,y)) = "Point(" ^ Real.toString(x) ^ ", " ^ Real.toString(y) ^ ")"
		|	toString(Line(m,b)) = "Line(" ^ Real.toString(m) ^ ", " ^ Real.toString(b) ^ ")"
		|	toString(VerticalLine(x)) = "VerticalLine(" ^ Real.toString(x) ^ ")"
		|	toString(LineSegment(x1,y1,x2,y2)) = "LineSegment(" ^ Real.toString(x1) ^ ", " ^ Real.toString(y1) ^ ", " ^ Real.toString(x2) ^ ", " ^ Real.toString(y2) ^ ")"
		|	toString(Var(s)) = "Var(" ^ StringTesting.toString(s) ^ ")"
		|	toString(Let(s,e1,e2)) = "Let(" ^ StringTesting.toString(s) ^ ", " ^ toString(e1) ^ ", " ^ toString(e2) ^ ")"		
		|	toString(Intersect(e1,e2)) = "Intersect(" ^ toString(e1) ^ ", " ^ toString(e2) ^ ")"
		|	toString(Shift(deltaX,deltaY,subexpression)) = "Shift(" ^ Real.toString(deltaX) ^ ", " ^ Real.toString(deltaY) ^ ", "  ^ toString(subexpression) ^ ")"
    end)

	structure IdentifierGeomertryValuePairToString = ToStringFn(struct
        type t = (string*geom_exp)
		fun toString(identifier, geom_value) =
			"(" ^ StringTesting.toString(identifier) ^ ", " ^ GeometryExpressionToString.toString(geom_value) ^ ")"
	end)

	structure GeometryExpressionTesting : sig include TO_STRING
		val assertEvalCompareEqualWithMessage : geom_exp * (unit -> geom_exp) * string -> unit
	end = struct
		open GeometryExpressionToString

		fun real_equal_via_compare(x,y) = 
			Real.compare(x,y) = EQUAL

		fun geom_exp_equal_via_compare(NoPoints, NoPoints) = true
		|	geom_exp_equal_via_compare(Point(a_x, a_y), Point(b_x, b_y)) = real_equal_via_compare(a_x, b_x) andalso real_equal_via_compare(a_y, b_y) 
		|	geom_exp_equal_via_compare(Line(a_m, a_b), Line(b_m, b_b)) = real_equal_via_compare(a_m, b_m) andalso real_equal_via_compare(a_b, b_b) 
		|	geom_exp_equal_via_compare(VerticalLine(a_x), VerticalLine(b_x)) = real_equal_via_compare(a_x, b_x)
		|	geom_exp_equal_via_compare(LineSegment(a_x1,a_y1,a_x2,a_y2), LineSegment(b_x1,b_y1,b_x2,b_y2)) = 
				real_equal_via_compare(a_x1, b_x1) andalso real_equal_via_compare(a_y1, b_y1) 
				andalso 
				real_equal_via_compare(a_x2, b_x2) andalso real_equal_via_compare(a_y2, b_y2)
		|	geom_exp_equal_via_compare(Var(a_s), Var(b_s)) = a_s = b_s
		|	geom_exp_equal_via_compare(Let(a_s, a_e1, a_e2), Let(b_s, b_e1, b_e2)) = a_s = b_s andalso geom_exp_equal_via_compare(a_e1, b_e1) andalso geom_exp_equal_via_compare(a_e2, b_e2)
		|	geom_exp_equal_via_compare(Intersect(a_e1, a_e2), Intersect(b_e1, b_e2)) = geom_exp_equal_via_compare(a_e1, b_e1) andalso geom_exp_equal_via_compare(a_e2, b_e2)
		|	geom_exp_equal_via_compare(Shift(a_deltaX, a_deltaY, a_subexpression), Shift(b_deltaX, b_deltaY, b_subexpression)) = 
				real_equal_via_compare(a_deltaX, b_deltaX) andalso real_equal_via_compare(a_deltaY, b_deltaY)
				andalso
				geom_exp_equal_via_compare(a_subexpression, b_subexpression)
		|	geom_exp_equal_via_compare(_) = false

		fun assert_eval_compare_equal( expected : geom_exp, thunk : unit -> geom_exp, message_option : string option) = 
			let
				val actual = (thunk()) handle e => (UnitTesting.on_exception(message_option, toString(expected), e); raise e)
			in
				if geom_exp_equal_via_compare(expected, actual)
				then UnitTesting.on_success( message_option, "as expected, compare evaluates to EQUAL: " ^ toString(expected))
				else UnitTesting.on_failure( message_option, toString(expected), toString(actual) )
			end

		fun assertEvalCompareEqualWithMessage( expected : geom_exp, thunk : unit -> geom_exp, message : string ) = 
			assert_eval_compare_equal(expected, thunk, SOME(message))

	end

	fun test_complete() = 
        let
            fun assert_preprocess_prog(expected, exp) = 
                GeometryExpressionTesting.assertEvalCompareEqualWithMessage(
                    expected, 
                    fn() => preprocess_prog(exp), 
                    "preprocess_prog(" ^ GeometryExpressionToString.toString(exp) ^ ")"
                )
            fun assert_eval_prog_preprocess_prog(expected, exp, env) = 
                GeometryExpressionTesting.assertEvalCompareEqualWithMessage(
                    expected, 
                    fn() => eval_prog(preprocess_prog(exp), env), 
                    "eval_prog(preprocess_prog(" ^ GeometryExpressionToString.toString(exp) ^ "), " ^ IdentifierGeomertryValuePairToString.toStringFromList(env) ^ ")"
                )

            fun assert_eval_prog(expected, exp, env) = 
                GeometryExpressionTesting.assertEvalCompareEqualWithMessage(
                    expected, 
                    fn() => eval_prog(exp, env), 
                    "eval_prog(" ^ GeometryExpressionToString.toString(exp) ^ "), " ^ IdentifierGeomertryValuePairToString.toStringFromList(env) ^ ")"
                )
        in
			( UnitTesting.enter("uw7")
				(* Preprocess tests *)
				; assert_preprocess_prog(Point(3.2,4.1), LineSegment(3.2,4.1,3.2,4.1))
				; assert_preprocess_prog(LineSegment(~3.2,~4.1,3.2,4.1), LineSegment(3.2,4.1,~3.2,~4.1))

				(* eval_prog tests with Shift*)
				; assert_eval_prog_preprocess_prog(Point(7.0,8.0), (Shift(3.0, 4.0, Point(4.0,4.0))), [])

				(* Using a Var *)
				; assert_eval_prog(Point(7.0,8.0), Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0))])
				
				(* With Variable Shadowing *)
				; assert_eval_prog(Point(7.0,8.0), Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0)),("a",Point(1.0,1.0))])

                (* add additional tests here *)
				
			; UnitTesting.leave() )
        end
end

val _ = ( UW7Testing.test_complete()
        ; OS.Process.exit(OS.Process.success)
        )
