functor StringToIntDictTestingFn(
	structure Dictionary : DICTIONARY
	val DictionaryName : string
	val strictness_level : ListStrictness.level
) = struct

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

	open StringIntDictTesting

    fun test_single_key_to_1_2_3_4_5(is_remove_desired : bool, (create_arg_text, create_arg), key) =
		let 

			val _ = UnitTesting.enter(DictionaryName ^ " single_key_to_1_2_3_4_5 " ^ KeyTesting_toString(key))
				val dict_empty = assert_create_completion(create_arg_text, create_arg)
				val _ = assert_get(NONE, "dict_empty", dict_empty, key)
				val dict_with_1 = assert_put(NONE, "dict_empty", dict_empty, key, 1)
				val _ = assert_get(SOME 1, "dict_with_1", dict_with_1, key)
				val dict_with_2 = assert_put(SOME 1, "dict_with_1", dict_with_1, key, 2)
				val _ = assert_get(SOME 2, "dict_with_2", dict_with_2, key)
				val dict_with_3 = 
					if is_remove_desired
					then 
						let
							val dict_post_remove_k2 = assert_remove(SOME 2, "dict_with_2", dict_with_2, key) 
							val _ = assert_get(NONE, "dict_post_remove_k2", dict_post_remove_k2, key)
						in 
							assert_put(NONE, "dict_post_remove_k2", dict_post_remove_k2, key, 3)
						end
					else assert_put(SOME 2, "dict_with_2", dict_with_2, key, 3)
				val _ = assert_get(SOME 3, "dict_with_3", dict_with_3, key)
				val dict_with_4 = assert_put(SOME 3, "dict_with_3", dict_with_3, key, 4)
				val _ = assert_get(SOME 4, "dict_with_4", dict_with_4, key)
				val dict_with_5 = assert_put(SOME 4, "dict_with_4", dict_with_4, key, 5)
				val _ = assert_get(SOME 5, "dict_with_5", dict_with_5, key)

				val _ = assert_entries_exact_match([], "dict_empty", dict_empty)
				val _ = assert_keys_exact_match([], "dict_empty", dict_empty)
				val _ = assert_values_exact_match([], "dict_empty", dict_empty)

				val _ = assert_entries_exact_match([(key,5)], "dict_with_5", dict_with_5)
				val _ = assert_keys_exact_match([key], "dict_with_5", dict_with_5)
				val _ = assert_values_exact_match([5], "dict_with_5", dict_with_5)

				val _ = 
					if is_remove_desired
					then 
						let
							val dict_post_remove_k5 = assert_remove(SOME 5, "dict_with_5", dict_with_5, key) 
							val _ = assert_get(NONE, "dict_post_remove_k5", dict_post_remove_k5, key)
						in 
							( assert_entries_exact_match([], "dict_post_remove_k5", dict_post_remove_k5)
							; assert_keys_exact_match([], "dict_post_remove_k5", dict_post_remove_k5)
							; assert_values_exact_match([], "dict_post_remove_k5", dict_post_remove_k5))
						end
					else ()
		in
			UnitTesting.leave()
		end


	(* TODO: check the order requirement to better support sorted dictionary *)
	fun test_entries_keys_and_values_strictness_level(expected_entries, dict) =
		( assert_entries_strictness_level(expected_entries, "dict", dict)
		; assert_keys_strictness_level(List.map #1 expected_entries, "dict", dict)
		; assert_values_strictness_level(List.map #2 expected_entries, "dict", dict) )

    fun test_names_to_uniform_numbers(is_remove_desired : bool, (create_arg_text, create_arg)) : unit =
		let
			val _ = UnitTesting.enter(DictionaryName ^ " test_names_to_uniform_numbers")
			val dict = assert_create_completion(create_arg_text, create_arg)

			val _ = UnitTesting.enter("put(\"Ted\", 9)")
			val _ = assert_get(NONE, "dict", dict, "Ted")
			val dict = assert_put(NONE, "dict", dict, "Ted", 9)
			val _ = assert_get(SOME 9, "dict", dict, "Ted")
			val _ = test_entries_keys_and_values_strictness_level([("Ted", 9)], dict)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("put(\"Jackie\", 42)")
			val _ = assert_get(NONE, "dict", dict, "Jackie")
			val dict = assert_put(NONE, "dict", dict, "Jackie", 42)
			val _ = assert_get(SOME 42, "dict", dict, "Jackie")
			val _ = test_entries_keys_and_values_strictness_level([("Jackie", 42), ("Ted", 9)], dict)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("put(\"Bobby\", 4)")
			val _ = assert_get(NONE, "dict", dict, "Bobby")
			val dict = assert_put(NONE, "dict", dict, "Bobby", 4)
			val _ = assert_get(SOME 4, "dict", dict, "Bobby")
			val _ = test_entries_keys_and_values_strictness_level([("Bobby", 4), ("Jackie", 42), ("Ted", 9)], dict)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("put(\"Bill\", 6)")
			val _ = assert_get(NONE, "dict", dict, "Bill")
			val dict = assert_put(NONE, "dict", dict, "Bill", 6)
			val _ = assert_get(SOME 6, "dict", dict, "Bill")
			val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Ted", 9)], dict)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("put(\"Michael\", 23) (* first time *)")
			val _ = assert_get(NONE, "dict", dict, "Michael")
			val dict = assert_put(NONE, "dict", dict, "Michael", 23)
			val _ = assert_get(SOME 23, "dict", dict, "Michael")
			val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Michael", 23), ("Ted", 9)], dict)
			val _ = UnitTesting.leave()

			val dict = 
				if is_remove_desired
				then 
					let
						val _ = UnitTesting.enter("remove(\"Michael\") (* first present time *)")
						val dict = assert_remove(SOME 23, "dict", dict, "Michael") 
						val _ = assert_get(NONE, "dict", dict, "Michael")
						val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Ted", 9)], dict)
						val _ = UnitTesting.leave()
			
						val _ = UnitTesting.enter("remove(\"Michael\") (* not present *)")
						val dict = assert_remove(NONE, "dict", dict, "Michael") 
						val _ = assert_get(NONE, "dict", dict, "Michael")
						val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Ted", 9)], dict)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("put(\"Michael\", 45)")
					in 
						assert_put(NONE, "dict", dict, "Michael", 45)
					end
				else 
					( UnitTesting.enter("put(\"Michael\", 45)")
					; assert_put(SOME 23, "dict", dict, "Michael", 45)
					)

			val _ = assert_get(SOME 45, "dict", dict, "Michael")
			val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Michael", 45), ("Ted", 9)], dict)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("put(\"Michael\", 23) (* second time *)")
			val dict = assert_put(SOME 45, "dict", dict, "Michael", 23)
			val _ = assert_get(SOME 23, "dict", dict, "Michael")
			val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Michael", 23), ("Ted", 9)], dict)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("put(\"Tom\", 10)")
			val _ = assert_get(NONE, "dict", dict, "Tom")
			val dict = assert_put(NONE, "dict", dict, "Tom", 10)
			val _ = assert_get(SOME 10, "dict", dict, "Tom")
			val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Michael", 23), ("Ted", 9), ("Tom", 10)], dict)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("put(\"Tom\", 12)")
			val dict = assert_put(SOME 10, "dict", dict, "Tom", 12)
			val _ = assert_get(SOME 12, "dict", dict, "Tom")
			val _ = test_entries_keys_and_values_strictness_level([("Bill", 6), ("Bobby", 4), ("Jackie", 42), ("Michael", 23), ("Ted", 9), ("Tom", 12)], dict)
			val _ = UnitTesting.leave()

			val _ = 
				if is_remove_desired
				then
					let
						val _ = UnitTesting.enter("remove(\"Bill\")")
						val dict = assert_remove(SOME 6, "dict", dict, "Bill") 
						val _ = assert_get(NONE, "dict", dict, "Bill")
						val _ = test_entries_keys_and_values_strictness_level([("Bobby", 4), ("Jackie", 42), ("Michael", 23), ("Ted", 9), ("Tom", 12)], dict)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Bobby\")")
						val dict = assert_remove(SOME 4, "dict", dict, "Bobby") 
						val _ = assert_get(NONE, "dict", dict, "Bobby")
						val _ = test_entries_keys_and_values_strictness_level([("Jackie", 42), ("Michael", 23), ("Ted", 9), ("Tom", 12)], dict)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Jackie\")")
						val dict = assert_remove(SOME 42, "dict", dict, "Jackie") 
						val _ = assert_get(NONE, "dict", dict, "Jackie")
						val _ = test_entries_keys_and_values_strictness_level([("Michael", 23), ("Ted", 9), ("Tom", 12)], dict)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Tom\")")
						val dict = assert_remove(SOME 12, "dict", dict, "Tom") 
						val _ = assert_get(NONE, "dict", dict, "Tom")
						val _ = test_entries_keys_and_values_strictness_level([("Michael", 23), ("Ted", 9)], dict)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Ted\")")
						val dict = assert_remove(SOME 9, "dict", dict, "Ted") 
						val _ = assert_get(NONE, "dict", dict, "Ted")
						val _ = test_entries_keys_and_values_strictness_level([("Michael", 23)], dict)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Michael\") (* second present time *)")
						val dict = assert_remove(SOME 23, "dict", dict, "Michael") 
						val _ = assert_get(NONE, "dict", dict, "Michael")
						val _ = test_entries_keys_and_values_strictness_level([], dict)
						val _ = UnitTesting.leave()

					in
						()
					end
				else ()
		in
			UnitTesting.leave() 
		end

	fun test_string_to_int_comprehensive(rnd : Random.rand, is_remove_desired : bool, (create_arg_text, create_arg)) : unit =
		let
			val _ = UnitTesting.enter(DictionaryName  ^ " comprehensive")
			val seeded_rand = Random.rand(425, 231)
			val nextInt = Random.randRange(0, 999) 

			val nextCharInt = Random.randRange(65, 90)

			fun nextChar() =
				Char.chr(nextCharInt(seeded_rand))

			fun generate_random_string() =
				String.implode([nextChar(), nextChar(), nextChar(), nextChar(), nextChar()])

			fun generate_random_entry() =
				(generate_random_string(), nextInt(seeded_rand))

			fun generate_random_entries(n) = 
				List.tabulate(n, fn(_)=>generate_random_entry())

			val random_entries = generate_random_entries(4)

			(* val test_entries = test_entries_of strictness dict *)

			fun to_possibly_sorted(entries) =
				if strictness_level = ListStrictness.EXACT_MATCH
				then ListMergeSort.sort (fn((ak,_),(bk,_)) => not (String.compare(ak,bk) = LESS)) entries
				else entries
			
			fun put_entry((key, value), (dict, acc)) =
				let
					val _ = UnitTesting.enter("put(" ^ KeyTesting_toString(key) ^ ", " ^ ValueTesting_toString(value) ^ ")")
					val _ = assert_get(NONE, "dict", dict, key)
					val dict' = assert_put(NONE, "dict", dict, key, value)
					val _ = assert_get(SOME(value), "dict'", dict', key)
					val _ = assert_get(NONE, "dict (* checking input not mutated *)", dict, key)

					val acc' = (key,value)::acc

					val expected_possibly_sorted = to_possibly_sorted(acc')
					val _ = test_entries_keys_and_values_strictness_level(expected_possibly_sorted, dict')
					val _ = UnitTesting.leave()
				in
					(dict', acc')
				end
			
			val dict_empty = assert_create_completion(create_arg_text, create_arg)
			val (dict_full, entries_full) = List.foldl put_entry (dict_empty, []) random_entries

			val _ = if is_remove_desired
					then
						let
							fun remove_entries(nil, dict) = dict
							  | remove_entries((key,value)::entries', dict) =
								let
									val _ = UnitTesting.enter("remove(" ^ KeyTesting_toString(key) ^ ")")
									val _ = assert_get(SOME value, "dict", dict, key)
									val dict' = assert_remove(SOME value, "dict", dict, key)
									val _ = assert_get(NONE, "dict'", dict', key)
									val _ = assert_get(SOME value, "dict (* checking input not mutated *)", dict, key)

									val expected_possibly_sorted = to_possibly_sorted(entries')
									val _ = test_entries_keys_and_values_strictness_level(expected_possibly_sorted, dict')
									val _ = UnitTesting.leave()
								in
									remove_entries(entries', dict')
								end
							val shuffled_entries = RandomUtils.shuffle(entries_full, rnd) 
						in
							remove_entries(shuffled_entries, dict_full)
						end
					else dict_full
		in
			UnitTesting.leave()
		end
end
