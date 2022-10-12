functor PutAllDictTestingFn(
	structure DictTesting : DICT_TESTING
) = struct

	open DictTesting

    fun test_put_all_no_duplicates(key, values, (create_arg_text, create_arg)) =
		let 
			val _ = UnitTesting.enter(DictionaryName ^ " test_put_all_no_duplicates(" ^ KeyTesting_toString(key) ^ ", " ^ ValueTesting_toStringFromList(values))
			val dict = assert_create_completion(create_arg_text, create_arg)
			val _ = assert_get(NONE, "dict", dict, key)

			fun f(value, (prev_opt, dict)) = 
				let 
					val dict = assert_put(prev_opt, "dict", dict, key, value)
				in
					(SOME value, dict)
				end

			val _ = foldl f (NONE, dict) values
		in
			UnitTesting.leave()
		end

end
