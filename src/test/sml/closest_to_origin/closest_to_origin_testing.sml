structure ClosestToOriginTesting : sig
	val test_closest_to_origin : unit -> unit
end = struct
    open ClosestToOrigin

    structure RealRealPairToString = ToStringFn(struct
        type t = real * real
        fun toString(x,y) = 
			"(" ^ Real.toString(x) ^ ", " ^ Real.toString(y) ^ ")"
    end)

	structure RealRealPairOptionTesting = struct
		fun assertEvalCloseEnoughWithMessage(expected, thunk, message) = 
			let
				val expected_detail = RealRealPairToString.toStringFromOption(expected)
				val actual = (thunk()) handle e => (UnitTesting.on_exception(SOME message, expected_detail, e); raise e)
				val actual_detail = RealRealPairToString.toStringFromOption(actual)
				val delta = 0.0
			in
				case (expected, actual) of
				  (NONE, NONE) => UnitTesting.on_success(SOME(message), "as expected, NONE is NONE")
				| (SOME(expected_x, expected_y), NONE) => UnitTesting.on_failure(SOME(message), expected_detail, actual_detail)
				| (NONE, SOME(actual_x, actual_y)) => UnitTesting.on_failure(SOME(message), expected_detail, actual_detail)
				| (SOME(expected_x, expected_y), SOME(actual_x, actual_y)) => 
					if ((CloseEnough.withinDelta(expected_x, actual_x, delta)) andalso (CloseEnough.withinDelta(expected_y, actual_y, delta)))
					then UnitTesting.on_success(SOME(message), "as expected, close enough: " ^ expected_detail)
					else UnitTesting.on_failure(SOME(message), expected_detail, actual_detail)
			end
	end

    fun assert_closest_to_origin(expected, xys) = 
		  RealRealPairOptionTesting.assertEvalCloseEnoughWithMessage(expected, fn() => closest_to_origin(xys), "closest_to_origin(" ^ RealRealPairToString.toStringFromList(xys) ^ ")")

    fun test_closest_to_origin() =
        ( UnitTesting.enter("closest_to_origin")
            ; assert_closest_to_origin(NONE, [])
            ; assert_closest_to_origin(SOME(1.0, 1.0), [(1.0, 1.0)])
            ; assert_closest_to_origin(SOME(231.0, 425.0), [(231.0, 425.0)])
            ; assert_closest_to_origin(SOME(0.0, 0.0), [(0.0, 0.0)])
            ; assert_closest_to_origin(SOME(1.0, 0.0), [(0.9, 0.9), (1.0, 0.0)])
            ; assert_closest_to_origin(SOME(1.0, 0.0), [(1.0, 0.0), (0.9, 0.9)])
            ; assert_closest_to_origin(SOME(425.0, 0.0), [(424.9, 424.9), (425.0, 0.0)])
            ; assert_closest_to_origin(SOME(425.0, 0.0), [(425.0, 0.0), (424.9, 424.9)])
            ; assert_closest_to_origin(SOME(1.0, 2.0), [(1.0, 2.0), (231.0, 0.0), (425.0, 0.0)])
            ; assert_closest_to_origin(SOME(1.0, 2.0), [(1.0, 2.0), (425.0, 0.0), (231.0, 0.0)])
            ; assert_closest_to_origin(SOME(1.0, 2.0), [(231.0, 0.0), (1.0, 2.0), (425.0, 0.0)])
            ; assert_closest_to_origin(SOME(1.0, 2.0), [(425.0, 0.0), (1.0, 2.0), (231.0, 0.0)])
            ; assert_closest_to_origin(SOME(1.0, 2.0), [(231.0, 0.0), (425.0, 0.0), (1.0, 2.0)])
            ; assert_closest_to_origin(SOME(1.0, 2.0), [(425.0, 0.0), (231.0, 0.0), (1.0, 2.0)])
            ; assert_closest_to_origin(SOME(2.0, 3.0), [(2.0, 3.0), (4.0, 5.0), (6.0, 7.0), (8.0, 9.0)])
            ; assert_closest_to_origin(SOME(2.0, 3.0), [(4.0, 5.0), (2.0, 3.0), (6.0, 7.0), (8.0, 9.0)])
            ; assert_closest_to_origin(SOME(2.0, 3.0), [(4.0, 5.0), (6.0, 7.0), (2.0, 3.0), (8.0, 9.0)])
            ; assert_closest_to_origin(SOME(2.0, 3.0), [(4.0, 5.0), (6.0, 7.0), (8.0, 9.0), (2.0, 3.0)])
        ; UnitTesting.leave() )
end
