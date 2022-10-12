functor DictionaryTestingFn(
	structure Dictionary : DICTIONARY
	val DictionaryName : string
	val strictness_level : ListStrictness.level
) = struct

	structure StringIntBaseDictTesting = StringToIntDictTestingFn(
		structure Dictionary = Dictionary
		val DictionaryName = DictionaryName
		val strictness_level = strictness_level
	)

	structure StringIntDictTesting = DictTestingFn(
		structure Dictionary = Dictionary 
		val DictionaryName = DictionaryName
		val strictness_level = strictness_level
		type key_type = string
		type value_type = int
		val KeyTesting_toString = StringTesting.toString
		val ValueTesting_toString = IntTesting.toString
		val ValueTesting_toStringFromList = IntTesting.toStringFromList
		val ValueTesting_assertOptionEvalEqualsWithMessage = IntTesting.assertOptionEvalEqualsWithMessage
		val KeyTesting_assertListEvalPassesStrictnessLevelWithMessage = StringTesting.assertListEvalPassesStrictnessLevelWithMessage
		val ValueTesting_assertListEvalPassesStrictnessLevelWithMessage = IntTesting.assertListEvalPassesStrictnessLevelWithMessage
		val EntryTesting_assertListEvalPassesStrictnessLevelWithMessage = StringIntEntryTesting.assertListEvalPassesStrictnessLevelWithMessage
	)

	structure IntStringDictTesting = DictTestingFn(
		structure Dictionary = Dictionary 
		val DictionaryName = DictionaryName
		val strictness_level = strictness_level
		type key_type = int
		type value_type = string
		val KeyTesting_toString = IntTesting.toString
		val ValueTesting_toString = StringTesting.toString
		val ValueTesting_toStringFromList = StringTesting.toStringFromList
		val ValueTesting_assertOptionEvalEqualsWithMessage = StringTesting.assertOptionEvalEqualsWithMessage
		val KeyTesting_assertListEvalPassesStrictnessLevelWithMessage = IntTesting.assertListEvalPassesStrictnessLevelWithMessage
		val ValueTesting_assertListEvalPassesStrictnessLevelWithMessage = StringTesting.assertListEvalPassesStrictnessLevelWithMessage
		val EntryTesting_assertListEvalPassesStrictnessLevelWithMessage = IntStringEntryTesting.assertListEvalPassesStrictnessLevelWithMessage
	)

	structure StringIntPutAllDictTestingFn = PutAllDictTestingFn(
		structure DictTesting = StringIntDictTesting
	)

	structure IntStringPutAllDictTestingFn = PutAllDictTestingFn(
		structure DictTesting = IntStringDictTesting
	)

	fun test_dictionary(rnd : Random.rand, is_remove_desired : bool, test_enter_detail : string, 
		(create_arg_text_for_string_key, create_arg_for_string_key), 
		(create_arg_text_for_int_key, create_arg_for_int_key)) : unit =
		( UnitTesting.enter(DictionaryName ^ " " ^ test_enter_detail)
		; StringIntBaseDictTesting.test_single_key_to_1_2_3_4_5(is_remove_desired, (create_arg_text_for_string_key, create_arg_for_string_key), "Fred")
		; StringIntPutAllDictTestingFn.test_put_all_no_duplicates("A", [10, 20, 30, 40], (create_arg_text_for_string_key, create_arg_for_string_key))
		; IntStringPutAllDictTestingFn.test_put_all_no_duplicates(42, ["A", "B", "C", "D"], (create_arg_text_for_int_key, create_arg_for_int_key))
		; StringIntBaseDictTesting.test_names_to_uniform_numbers(is_remove_desired, (create_arg_text_for_string_key, create_arg_for_string_key))
		; StringIntBaseDictTesting.test_string_to_int_comprehensive(rnd, is_remove_desired, (create_arg_text_for_string_key, create_arg_for_string_key)) 
		; UnitTesting.leave()
		)
end
