functor EqualityTestingFn (EqualityTestingParam : sig
	eqtype t
	val toString : t -> string
	val compare : t * t -> order
end) : EQUALITY_TESTING = struct
    structure EqualityToString = ToStringEqFn(struct
        type t = EqualityTestingParam.t
        val toString = EqualityTestingParam.toString
    end)

	open EqualityToString
	open EqualityTestingParam

	fun assert_eval to_string (expected : ''a, thunk : unit -> ''a, message_option : string option) : unit = 
		let
			val actual = (thunk()) handle e => (UnitTesting.on_exception(message_option, to_string(expected), e); raise e)
		in
			if expected = actual
			then UnitTesting.on_success( message_option, "as expected, equals " ^ to_string(actual))
			else UnitTesting.on_failure( message_option, to_string(expected), to_string(actual) )
		end

	fun assert_equals to_string (expected : ''a, actual : ''a, message_option : string option) : unit =
		assert_eval to_string (expected, fn _ => actual, message_option)

	fun sort values =
		let
			fun order_to_bool(LESS) = false
			|	order_to_bool(EQUAL) = true
			|	order_to_bool(GREATER) = true

			fun compare_order_to_bool(a, b) =
				order_to_bool(compare(a,b))

		in
			ListMergeSort.sort compare_order_to_bool values
		end


   	fun assert_eval_strictness strictness to_list_string (expected : t list, thunk : unit -> t list, message_option : string option) : unit =
		let
			val actual = (thunk()) handle e => (UnitTesting.on_exception(message_option, to_list_string(expected), e); raise e)
			fun to_flexible_actual_string(to_string, actual) =
				if UnitTesting.isActualToStringDesiredForFlexibleTests()
				then to_string(actual)
				else "OMITTED ACTUAL LIST"

			val expected_sorted = sort expected
			val actual_possibly_sorted = if strictness=ListStrictness.ANY_ORDER then (sort actual) else actual
			val text = if strictness=ListStrictness.ANY_ORDER then "any order" else "sorted"
		in
			if expected_sorted = actual_possibly_sorted
			then 
			(*
			(
				print("\nactual:       " ^ to_string(actual))
				;
				print("\nexpected:     " ^ to_string(expected))
				;
				print("\ns_actual:     " ^ to_string((ListMergeSort.sort compare actual)))
				;
				print("\ns_expected:   " ^ to_string((ListMergeSort.sort compare expected)))
				;
				print("\n")
				;
				print("\n")
				;
			*)
				UnitTesting.on_success( message_option, "as expected, equals (" ^ text ^ "): " ^ to_flexible_actual_string(to_list_string, actual))
			(*
			)
			*)
			else UnitTesting.on_failure( message_option, "(in any order) " ^ to_list_string(expected_sorted), to_list_string(actual_possibly_sorted) )
		end

	fun assertEqualsWithMessage(expected : t, actual : t, message : string) : unit =
		assert_equals toString (expected, actual, SOME message)

	fun assertEquals(expected : t, actual : t) : unit =
		assert_equals toString (expected, actual, NONE)

	fun assertEvalEqualsWithMessage(expected : t, thunk : unit -> t, message : string) : unit =
		assert_eval toString (expected, thunk, SOME message)

	fun assertEvalEquals(expected : t, thunk : unit -> t) : unit =
		assert_eval toString (expected, thunk, NONE)

	fun assert_list_eval_passes_strictness_level(expected : t list, thunk : unit -> t list, strictness : ListStrictness.level, message_option : string option) : unit =
		case(strictness) of
		  ListStrictness.EXACT_MATCH => assert_eval toStringFromList (expected, thunk, message_option)
		| _ => assert_eval_strictness strictness toStringFromList (expected, thunk, message_option)

	fun assert_list_passes_strictness_level(expected : t list, actual : t list, strictness : ListStrictness.level, message_option : string option) : unit =
		assert_list_eval_passes_strictness_level(expected, fn _ => actual, strictness, message_option)

	fun assertListEvalPassesStrictnessLevel(expected : t list, thunk : unit -> t list, strictness : ListStrictness.level) : unit =
		assert_list_eval_passes_strictness_level(expected, thunk, strictness, NONE)

	fun assertListEvalPassesStrictnessLevelWithMessage(expected : t list, thunk : unit -> t list, strictness : ListStrictness.level, message : string) : unit =
		assert_list_eval_passes_strictness_level(expected, thunk, strictness, SOME message)

	fun assertListPassesStrictnessLevel(expected : t list, actual : t list, strictness : ListStrictness.level) : unit =
		assert_list_passes_strictness_level(expected, actual, strictness, NONE)

	fun assertListPassesStrictnessLevelWithMessage(expected : t list, actual : t list, strictness : ListStrictness.level, message : string) : unit =
		assert_list_passes_strictness_level(expected, actual, strictness, SOME message)

	fun assertListEvalEquals(expected : t list, thunk : unit -> t list) : unit =
		assert_list_eval_passes_strictness_level(expected, thunk, ListStrictness.EXACT_MATCH, NONE)

	fun assertListEvalEqualsWithMessage(expected : t list, thunk : unit -> t list, message : string) : unit =
		assert_list_eval_passes_strictness_level(expected, thunk, ListStrictness.EXACT_MATCH, SOME message)

	fun assertListEquals(expected : t list, actual : t list) : unit =
		assert_list_passes_strictness_level(expected, actual, ListStrictness.EXACT_MATCH, NONE)

	fun assertListEqualsWithMessage(expected : t list, actual : t list, message : string) : unit =
		assert_list_passes_strictness_level(expected, actual, ListStrictness.EXACT_MATCH, SOME message)


	fun assertListListEvalEqualsWithMessage(expected : t list list, thunk : unit -> t list list, message : string) : unit =
		assert_eval toStringFromListList (expected, thunk, SOME message)

	fun assertListListEvalEquals(expected : t list list, thunk : unit -> t list list) : unit =
		assert_eval toStringFromListList (expected, thunk, NONE)

	fun assertListListEqualsWithMessage(expected : t list list, actual : t list list, message : string) : unit =
		assert_equals toStringFromListList (expected, actual, SOME message)

	fun assertListListEquals(expected : t list list, actual : t list list) : unit =
		assert_equals toStringFromListList (expected, actual, NONE)


	fun assertOptionEvalEqualsWithMessage(expected : t option, thunk : unit -> t option, message : string) : unit =
		assert_eval toStringFromOption (expected, thunk, SOME message)

	fun assertOptionEvalEquals(expected : t option, thunk : unit -> t option) : unit =
		assert_eval toStringFromOption (expected, thunk, NONE)

	fun assertOptionEqualsWithMessage(expected : t option, actual : t option, message : string) : unit =
		assert_equals toStringFromOption (expected, actual, SOME message)

	fun assertOptionEquals(expected : t option, actual : t option) : unit =
		assert_equals toStringFromOption (expected, actual, NONE)

	(*
	fun assertNotEquals(expected : t, actual : t, message : string) : unit =
		raise Fail "TODO"

	fun assertAll(heading : string, subs : (unit -> unit) list) : unit =
		raise Fail "TODO"
	*)

	(*
    fun assertEquals (to_string : ''a -> string) ((expected : ''a), (actual : ''a)) =
        if expected = actual
        then success( "equals: " ^ to_string(actual))
        else failure( "expected: " ^ to_string(expected) ^ "; actual: " ^ to_string(actual) )
	*)

	(*
    fun assertEqualsOneOf (to_string : ''a->string) ((expecteds : ''a list), (actual : ''a)) : unit =
		let 
			fun equals_one_of(expecteds : ''a list) : bool =
			case expecteds of
				[] => false
				| expected::expecteds' => 
					if expected = actual
					then true
					else equals_one_of(expecteds')
			val list_to_string = (Repr.toString o (Repr.listToRepr (Repr.S o to_string)))
		in
			if equals_one_of(expecteds)
			then success( "equals one of: " ^ to_flexible_actual_string(to_string,actual))
			else failure( "expected one of: " ^ list_to_string(expecteds) ^ "; actual: " ^ to_string(actual) )
		end

    fun assertEqualsForwardOrReverse (to_string : ''a list -> string) ((expected : ''a list), (actual : ''a list)) =
        if (expected = actual) orelse (expected = rev(actual))
        then success( "equals (forward or reverse): " ^ to_flexible_actual_string(to_string, actual))
        else failure( "expected (forward or reverse): " ^ to_string(expected) ^ "; actual: " ^ to_string(actual) )

*)


 	fun assertListEvalEqualsAnyOrder(expected : t list, thunk : unit -> t list) =
	 	assert_list_eval_passes_strictness_level(expected, thunk, ListStrictness.ANY_ORDER, NONE)

 	fun assertListEvalEqualsAnyOrderWithMessage(expected : t list, thunk : unit -> t list, message : string) =
		assert_list_eval_passes_strictness_level(expected, thunk, ListStrictness.ANY_ORDER, SOME message)

 	fun assertListEqualsAnyOrder(expected : t list, actual : t list) =
	 	assert_list_passes_strictness_level(expected, actual, ListStrictness.ANY_ORDER, NONE)

 	fun assertListEqualsAnyOrderWithMessage(expected : t list, actual : t list, message : string) =
		assert_list_passes_strictness_level(expected, actual, ListStrictness.ANY_ORDER, SOME message)

 	fun assertListEvalEqualsSortedExpected(expected : t list, thunk : unit -> t list) =
	 	assert_list_eval_passes_strictness_level(expected, thunk,  ListStrictness.EXACT_MATCH_OF_SORTED_EXPECTED, NONE)

 	fun assertListEvalEqualsSortedExpectedWithMessage(expected : t list, thunk : unit -> t list, message : string) =
		assert_list_eval_passes_strictness_level(expected, thunk, ListStrictness.EXACT_MATCH_OF_SORTED_EXPECTED, SOME message)

 	fun assertListEqualsSortedExpected(expected : t list, actual : t list) =
	 	assert_list_passes_strictness_level(expected, actual,  ListStrictness.EXACT_MATCH_OF_SORTED_EXPECTED, NONE)

 	fun assertListEqualsSortedExpectedWithMessage(expected : t list, actual : t list, message : string) =
		assert_list_passes_strictness_level(expected, actual, ListStrictness.EXACT_MATCH_OF_SORTED_EXPECTED, SOME message)

	fun assert_list_option_eval_equals(expected : t list option, thunk : unit -> t list option, message_option : string option) = 
		let
			val expected_detail = toStringFromListOption(expected)
			val actual = (thunk()) handle e => (UnitTesting.on_exception(message_option, expected_detail, e); raise e)
			val actual_detail = toStringFromListOption(actual)
		in
			case (expected, actual) of
			  (NONE, NONE) => UnitTesting.on_success(message_option, "as expected, equals: " ^ expected_detail)
			| (SOME(_), NONE) => UnitTesting.on_failure(message_option, expected_detail, actual_detail)
			| (NONE, SOME(_)) => UnitTesting.on_failure(message_option, expected_detail, actual_detail ) 
			| (SOME(expected_list), SOME(actual_list)) =>			
				if expected_list = actual_list
				then UnitTesting.on_success(message_option, "as expected, equals: " ^ expected_detail)
				else UnitTesting.on_failure(message_option, expected_detail, actual_detail ) 
		end

	fun assert_list_option_equals(expected : t list option, actual : t list option, message_option : string option) = 
		assert_list_option_eval_equals(expected, fn()=>actual, message_option)

	fun assertListOptionEvalEquals(expected : t list option, thunk : unit -> t list option) =
		assert_list_option_eval_equals(expected, thunk, NONE)

	fun assertListOptionEvalEqualsWithMessage(expected : t list option, thunk : unit -> t list option, message : string) =
		assert_list_option_eval_equals(expected, thunk, SOME message)
	
	fun assertListOptionEquals(expected : t list option, actual : t list option) =
		assert_list_option_equals(expected, actual, NONE)

	fun assertListOptionEqualsWithMessage(expected : t list option, actual : t list option, message : string) =
		assert_list_option_equals(expected, actual, SOME message)

	fun assert_list_option_eval_equals_any_order(expected : t list option, thunk : unit -> t list option, message_option : string option) = 
		let
			val expected_detail = toStringFromListOption(expected)
			val actual = (thunk()) handle e => (UnitTesting.on_exception(message_option, expected_detail, e); raise e)
			val actual_detail = toStringFromListOption(actual)
		in
			case (expected, actual) of
			  (NONE, NONE) => UnitTesting.on_success(message_option, "as expected, equals (any order): " ^ expected_detail)
			| (SOME(_), NONE) => UnitTesting.on_failure(message_option, "(in any order): " ^ expected_detail, actual_detail)
			| (NONE, SOME(_)) => UnitTesting.on_failure(message_option, "(in any order): " ^ expected_detail, actual_detail ) 
			| (SOME(expected_list), SOME(actual_list)) =>			
				let
					val expected_sorted = sort expected_list
					val actual_sorted = sort actual_list
				in
					if expected_sorted = actual_sorted
					then UnitTesting.on_success(message_option, "as expected, equals (in any order): " ^ expected_detail)
					else UnitTesting.on_failure(message_option, "(in any order): " ^ expected_detail, actual_detail ) 
				end
		end

	fun assert_list_option_equals_any_order(expected : t list option, actual : t list option, message_option : string option) = 
		assert_list_option_eval_equals_any_order(expected, fn()=>actual, message_option)

	fun assertListOptionEvalEqualsAnyOrder(expected : t list option, thunk : unit -> t list option) =
		assert_list_option_eval_equals_any_order(expected, thunk, NONE)

	fun assertListOptionEvalEqualsAnyOrderWithMessage(expected : t list option, thunk : unit -> t list option, message : string) =
		assert_list_option_eval_equals_any_order(expected, thunk, SOME message)

	fun assertListOptionEqualsAnyOrder(expected : t list option, actual : t list option) =
		assert_list_option_equals_any_order(expected, actual, NONE)

	fun assertListOptionEqualsAnyOrderWithMessage(expected : t list option, actual : t list option, message : string) =
		assert_list_option_equals_any_order(expected, actual, SOME message)
end