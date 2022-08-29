CM.make "../to_string/to_string.cm";
CM.make "../unit_testing/unit_testing.cm";
use "../../../main/sml/uw3/uw3.sml";

structure UW3Testing :> sig
    val test_base_credit : unit -> unit
    val test_extra_credit : unit -> unit
end = struct

    structure PatternToString = ToStringFn (struct
        type t = pattern
        fun toString(Wildcard) = "Wildcard"
          | toString(Variable(s)) = "Variable(" ^ StringTesting.toString(s) ^ ")" 
          | toString(UnitP) = "UnitP" 
          | toString(ConstP(n)) = "ConstP(" ^ Int.toString(n) ^ ")" 
          | toString(TupleP(list)) = 
		  	let
				fun helper nil = ""
				| helper (head::nil) = toString(head)
				| helper (head::neck::rest) = toString(head) ^ ", " ^ helper(neck::rest)
			in
				"TupleP(" ^ helper(list) ^ ")"
			end
          | toString(ConstructorP(s,p)) = "ConstructorP(" ^ StringTesting.toString(s) ^ "," ^ toString(p) ^ ")"
    end)

    structure ValuToString = ToStringFn (struct
        type t = valu
        fun toString(Const(n)) = "Const(" ^ Int.toString(n) ^ ")"
          | toString(Unit) = "Unit"
          | toString(Tuple(list)) = 
		  	let
				fun helper nil = ""
				| helper (head::nil) = toString(head)
				| helper (head::neck::rest) = toString(head) ^ ", " ^ helper(neck::rest)
			in
				"Tuple(" ^ helper(list) ^ ")"
			end
          | toString(Constructor(s,v)) = "Constructor(" ^ StringTesting.toString(s) ^ "," ^ toString(v) ^ ")"
    end)

    structure StringValuTesting = EqualityTestingFn (struct
        type t = string * valu
        fun toString(s, v) = s ^ ", " ^ ValuToString.toString(v)
        fun compare(a,b) = raise Fail "unsupported"
    end)

    structure TypTesting = EqualityTestingFn (struct
        type t = typ
        fun toString(Anything) = "Anything"
          | toString(UnitT) = "UnitT"
          | toString(IntT) = "IntT"
          | toString(TupleT(list)) = 
		  	let
				fun helper nil = ""
				| helper (head::nil) = toString(head)
				| helper (head::neck::rest) = toString(head) ^ ", " ^ helper(neck::rest)
			in
				"TupleT(" ^ helper(list) ^ ")"
			end
          | toString(Datatype(s)) = "Datatype(" ^ StringTesting.toString(s) ^ ")"
        fun compare(a,b) = raise Fail "unsupported"
    end)

    structure ConstructorInfoToString = ToStringFn (struct
        type t = string * string * typ
        fun toString(constructor_name, data_type_name, value_type) = "(" ^ constructor_name ^ "," ^ data_type_name ^ "," ^ TypTesting.toString(value_type) ^ ")"
    end)

	fun test_only_capitals() = 
        let
            fun assert_only_capitals(expected, strs) = 
                StringTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => only_capitals(strs), 
                    "only_capitals(" ^ StringTesting.toStringFromList(strs) ^ ")"
                )
        in
			( UnitTesting.enter("only_capitals")
				; assert_only_capitals(["A","B","C"], ["A","B","C"])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
        end


	fun test_longest_string1() = 
        let
            fun assert_longest_string1(expected, strs) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => longest_string1(strs), 
                    "longest_string1(" ^ StringTesting.toStringFromList(strs) ^ ")"
                )
        in
			( UnitTesting.enter("longest_string1")
				; assert_longest_string1("bc", ["A","bc","C"])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
        end

	fun test_longest_string2() = 
        let
            fun assert_longest_string2(expected, strs) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => longest_string2(strs), 
                    "longest_string2(" ^ StringTesting.toStringFromList(strs) ^ ")"
                )
        in
			( UnitTesting.enter("longest_string2")
				; assert_longest_string2("bc", ["A","bc","C"])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_longest_string3() = 
        let
            fun assert_longest_string3(expected, strs) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => longest_string3(strs), 
                    "longest_string3(" ^ StringTesting.toStringFromList(strs) ^ ")"
                )
        in
			( UnitTesting.enter("longest_string3")
				; assert_longest_string3("bc", ["A","bc","C"])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_longest_string4() = 
        let
            fun assert_longest_string4(expected, strs) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => longest_string4(strs), 
                    "longest_string4(" ^ StringTesting.toStringFromList(strs) ^ ")"
                )
        in
			( UnitTesting.enter("longest_string4")
				; assert_longest_string4("C", ["A","B","C"])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_longest_capitalized() = 
        let
            fun assert_longest_capitalized(expected, strs) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => longest_capitalized(strs), 
                    "longest_capitalized(" ^ StringTesting.toStringFromList(strs) ^ ")"
                )
        in
			( UnitTesting.enter("longest_capitalized")
				; assert_longest_capitalized("A", ["A","bc","C"])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_rev_string() = 
        let
            fun assert_rev_string(expected, str) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => rev_string(str), 
                    "rev_string(" ^ StringTesting.toString(str) ^ ")"
                )
        in
			( UnitTesting.enter("rev_string")
				; assert_rev_string("cba", "abc")
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_first_answer() = 
        let
            fun assert_first_answer to_string_from_list assert_eval_equals_with_message (expected, f, xs) = 
                assert_eval_equals_with_message(
                    expected, 
                    fn() => first_answer f xs, 
                    "first_answer (function) (" ^ to_string_from_list(xs) ^ ")"
                )

			val assert_first_answer_int_int = assert_first_answer (IntTesting.toStringFromList) (IntTesting.assertEvalEqualsWithMessage)
        in
			( UnitTesting.enter("first_answer")
				; assert_first_answer_int_int(4, fn x => if x > 3 then SOME x else NONE, [1,2,3,4,5])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	

	fun test_all_answers() = 
        let
            fun assert_all_answers to_string_from_list assert_list_option_eval_equals_any_order_with_message (expected, f, xs) = 
                assert_list_option_eval_equals_any_order_with_message(
                    expected, 
                    fn() => all_answers f xs, 
                    "all_answers (function) (" ^ to_string_from_list(xs) ^ ")"
                )

			val assert_all_answers_int_int = assert_all_answers (IntTesting.toStringFromList) (IntTesting.assertListOptionEvalEqualsAnyOrderWithMessage)
        in
			( UnitTesting.enter("all_answers")
				; assert_all_answers_int_int(NONE, fn x => if x = 1 then SOME [x] else NONE, [2,3,4,5,6,7])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_count_wildcards() = 
        let
            fun assert_count_wildcards(expected, p) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => count_wildcards(p), 
                    "count_wildcards(" ^ PatternToString.toString(p) ^ ")"
                )
        in
			( UnitTesting.enter("count_wildcards")
				; assert_count_wildcards(1, Wildcard)
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_count_wild_and_variable_lengths() = 
        let
            fun assert_count_wild_and_variable_lengths(expected, p) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => count_wild_and_variable_lengths(p), 
                    "count_wild_and_variable_lengths(" ^ PatternToString.toString(p) ^ ")"
                )
        in
			( UnitTesting.enter("count_wild_and_variable_lengths")
				; assert_count_wild_and_variable_lengths(1, Variable("a"))
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_count_some_var() = 
        let
            fun assert_count_some_var(expected, str, p) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => count_some_var(str, p), 
                    "count_some_var(" ^ StringTesting.toString(str) ^ ", " ^ PatternToString.toString(p) ^ ")"
                )
        in
			( UnitTesting.enter("count_some_var")
				; assert_count_some_var(1, "x", Variable("x"))
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_check_pat() = 
        let
            fun assert_check_pat_validity assert_eval_true_or_false_with_message (p) = 
                assert_eval_true_or_false_with_message(
                    fn() => check_pat(p), 
                    "check_pat(" ^ PatternToString.toString(p) ^ ")"
                )
            val assert_check_pat_valid = assert_check_pat_validity BoolTesting.assertEvalTrueWithMessage
            val assert_check_pat_not_valid = assert_check_pat_validity BoolTesting.assertEvalFalseWithMessage
        in
			( UnitTesting.enter("check_pat")
				; assert_check_pat_valid(Variable("x"))
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_match() = 
        let
            fun assert_match(expected, v, p) = 
                StringValuTesting.assertListOptionEvalEqualsWithMessage(
                    expected, 
                    fn() => match(v, p), 
                    "match(" ^ ValuToString.toString(v) ^ ", " ^ PatternToString.toString(p) ^ ")"
                )
        in
			( UnitTesting.enter("match")
				; assert_match(NONE, Const(1), UnitP)
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_first_match() = 
        let
            fun assert_first_match(expected, v, pats) = 
                StringValuTesting.assertListOptionEvalEqualsWithMessage(
                    expected, 
                    fn() => first_match v pats, 
                    "first_match (" ^ ValuToString.toString(v) ^ ") (" ^ PatternToString.toStringFromList(pats) ^ ")"
                )
        in
			( UnitTesting.enter("first_match")
				; assert_first_match(SOME [], Unit, [UnitP])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_typecheck_patterns() = 
        let
            fun assert_typecheck_patterns(expected, constructor_infos, pats) = 
                TypTesting.assertOptionEvalEqualsWithMessage(
                    expected, 
                    fn() => typecheck_patterns(constructor_infos, pats), 
                    "typecheck_patterns(" ^ ConstructorInfoToString.toStringFromList(constructor_infos) ^ ", " ^ PatternToString.toStringFromList(pats) ^ ")"
                )
        in
			( UnitTesting.enter("typecheck_patterns")
				; assert_typecheck_patterns(
					SOME(TupleT[Anything,Anything]), 
					[],[TupleP[Variable("x"),Variable("y")], TupleP[Wildcard,Wildcard]])
				; assert_typecheck_patterns(
					SOME(TupleT[Anything,TupleT[Anything,Anything]]), 
					[],[TupleP[Wildcard,Wildcard], TupleP[Wildcard,TupleP[Wildcard,Wildcard]]])
				

                (* add additional tests here *)

			; UnitTesting.leave() )
		end

	fun test_base_credit() = 
		( test_only_capitals() 
		; test_longest_string1() 
		; test_longest_string2() 
		; test_longest_string3() 
		; test_longest_string4() 
		; test_longest_capitalized() 
		; test_rev_string() 
		; test_first_answer() 
		; test_all_answers() 
		; test_count_wildcards() 
		; test_count_wild_and_variable_lengths() 
		; test_count_some_var() 
		; test_check_pat() 
		; test_match() 
		; test_first_match() )

	fun test_extra_credit() = 
		test_typecheck_patterns()
	
end

val _ = ( UW3Testing.test_base_credit()
        ; UW3Testing.test_extra_credit()
        ; OS.Process.exit(OS.Process.success)
        )
