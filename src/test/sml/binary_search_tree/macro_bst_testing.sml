structure IntBstTesting = BstTestingFn(struct
	type entry = IntTesting.t
	type key = entry
	val compare_keys = Int.compare
	fun to_key(x) = x
	val to_string_from_key = IntTesting.toString
	val to_string_from_entry = IntTesting.toString
    fun debug_compare_text() = 
		"Int.compare"

    fun debug_to_s_text() = 
		"Int.toString"
end)

structure StringBstTesting = BstTestingFn(struct
	type entry = StringTesting.t
	type key = string
	val compare_keys = String.compare
	fun to_key(x) = x
	val to_string_from_key = StringTesting.toString
	val to_string_from_entry = StringTesting.toString
    fun debug_compare_text() = 
		"String.compare"

    fun debug_to_s_text() = 
		"fn(s)=>s"

end)

structure MacroBstTesting = struct
	val iteration_count = 8
	val rnd = Random.rand(425, 231)

	fun name_tree_test(is_remove_testing_desired) =
		let
			val _ = UnitTesting.enter("mimic_sorted_dictionary_test")
			val bst = StringBstTesting.assert_create_empty_completion()

			val _ = UnitTesting.enter("insert(\"Ted\")")
			val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Ted")
			val bst = StringBstTesting.assert_insert(NONE, "bst", bst, "Ted")
			val _ = StringBstTesting.assert_find(SOME "Ted", "bst", bst, "Ted")
			val _ = StringBstTesting.assert_bst_to_list(["Ted"], "bst", bst)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("insert(\"Jackie\")")
			val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Jackie")
			val bst = StringBstTesting.assert_insert(NONE, "bst", bst, "Jackie")
			val _ = StringBstTesting.assert_find(SOME "Jackie", "bst", bst, "Jackie")
			val _ = StringBstTesting.assert_bst_to_list(["Jackie", "Ted"], "bst", bst)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("insert(\"Bobby\")")
			val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Bobby")
			val bst = StringBstTesting.assert_insert(NONE, "bst", bst, "Bobby")
			val _ = StringBstTesting.assert_find(SOME "Bobby", "bst", bst, "Bobby")
			val _ = StringBstTesting.assert_bst_to_list(["Bobby", "Jackie", "Ted"], "bst", bst)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("insert(\"Bill\")")
			val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Bill")
			val bst = StringBstTesting.assert_insert(NONE, "bst", bst, "Bill")
			val _ = StringBstTesting.assert_find(SOME "Bill", "bst", bst, "Bill")
			val _ = StringBstTesting.assert_bst_to_list(["Bill", "Bobby", "Jackie", "Ted"], "bst", bst)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("insert(\"Michael\")")
			val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Michael")
			val bst = StringBstTesting.assert_insert(NONE, "bst", bst, "Michael")
			val _ = StringBstTesting.assert_find(SOME "Michael", "bst", bst, "Michael")
			val _ = StringBstTesting.assert_bst_to_list(["Bill", "Bobby", "Jackie", "Michael", "Ted"], "bst", bst)
			val _ = UnitTesting.leave()

			val (bst, expected_prev_for_michael) = 
				if is_remove_testing_desired
				then 
					let
						val _ = UnitTesting.enter("remove(\"Michael\")")
						val bst = StringBstTesting.assert_remove(SOME "Michael", "bst", bst, "Michael") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Michael")
						val _ = StringBstTesting.assert_bst_to_list(["Bill", "Bobby", "Jackie", "Ted"], "bst", bst)
						val _ = UnitTesting.leave()
			
						val _ = UnitTesting.enter("remove(\"Michael\")")
						val bst = StringBstTesting.assert_remove(NONE, "bst", bst, "Michael") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Michael")
						val _ = StringBstTesting.assert_bst_to_list(["Bill", "Bobby", "Jackie", "Ted"], "bst", bst)
						val _ = UnitTesting.leave()
					in
						(bst, NONE)
					end
				else (bst, SOME("Michael"))

			val _ = UnitTesting.enter("insert(\"Michael\")")
			val _ = StringBstTesting.assert_find(expected_prev_for_michael, "bst", bst, "Michael")
			val bst = StringBstTesting.assert_insert(expected_prev_for_michael, "bst", bst, "Michael")
			val _ = StringBstTesting.assert_find(SOME "Michael", "bst", bst, "Michael")
			val _ = StringBstTesting.assert_bst_to_list(["Bill", "Bobby", "Jackie", "Michael", "Ted"], "bst", bst)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("insert(\"Tom\")")
			val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Tom")
			val bst = StringBstTesting.assert_insert(NONE, "bst", bst, "Tom")
			val _ = StringBstTesting.assert_find(SOME "Tom", "bst", bst, "Tom")
			val _ = StringBstTesting.assert_bst_to_list(["Bill", "Bobby", "Jackie", "Michael", "Ted", "Tom"], "bst", bst)
			val _ = UnitTesting.leave()

			val _ = UnitTesting.enter("insert(\"Tom\")")
			val _ = StringBstTesting.assert_find(SOME "Tom", "bst", bst, "Tom")
			val bst = StringBstTesting.assert_insert(SOME "Tom", "bst", bst, "Tom")
			val _ = StringBstTesting.assert_find(SOME "Tom", "bst", bst, "Tom")
			val _ = StringBstTesting.assert_bst_to_list(["Bill", "Bobby", "Jackie", "Michael", "Ted", "Tom"], "bst", bst)
			val _ = UnitTesting.leave()

			val _ = 
				if is_remove_testing_desired
				then
					let
						val _ = UnitTesting.enter("remove(\"Bill\")")
						val bst = StringBstTesting.assert_remove(SOME "Bill", "bst", bst, "Bill") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Bill")
						val _ = StringBstTesting.assert_bst_to_list(["Bobby", "Jackie", "Michael", "Ted", "Tom"], "bst", bst)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Bobby\")")
						val bst = StringBstTesting.assert_remove(SOME "Bobby", "bst", bst, "Bobby") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Bobby")
						val _ = StringBstTesting.assert_bst_to_list(["Jackie", "Michael", "Ted", "Tom"], "bst", bst)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Jackie\")")
						val bst = StringBstTesting.assert_remove(SOME "Jackie", "bst", bst, "Jackie") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Jackie")
						val _ = StringBstTesting.assert_bst_to_list(["Michael", "Ted", "Tom"], "bst", bst)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Tom\")")
						val bst = StringBstTesting.assert_remove(SOME "Tom", "bst", bst, "Tom") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Tom")
						val _ = StringBstTesting.assert_bst_to_list(["Michael", "Ted"], "bst", bst)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Ted\")")
						val bst = StringBstTesting.assert_remove(SOME "Ted", "bst", bst, "Ted") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Ted")
						val _ = StringBstTesting.assert_bst_to_list(["Michael"], "bst", bst)
						val _ = UnitTesting.leave()

						val _ = UnitTesting.enter("remove(\"Michael\")")
						val bst = StringBstTesting.assert_remove(SOME "Michael", "bst", bst, "Michael") 
						val _ = StringBstTesting.assert_find(NONE, "bst", bst, "Michael")
						val _ = StringBstTesting.assert_bst_to_list([], "bst", bst)
						val _ = UnitTesting.leave()

					in
						()
					end
				else ()
		in
			UnitTesting.leave() 
		end

	fun test_bst(is_remove_testing_desired, ignore_potential_remove_problems_for_full_credit) = 
		( UnitTesting.enter("bst")

			; IntBstTesting.test_bare_minimum_implemented(425)
			; IntBstTesting.test_reasonable_minimum_implemented(425)
			; IntBstTesting.test_reasonable_minimum_correct(425, 231)

			; IntBstTesting.assertInsertAllInRandomOrderRepeatedly(iteration_count, [1, 2, 3, 4, 5, 6, 7, 8], rnd)
			; IntBstTesting.assertInsertAllInRandomOrderRepeatedly(iteration_count, [231, 425, 8, 6, 7, 5, 3, 0, 9, 777, 93, 11], rnd)
			; StringBstTesting.assertInsertAllInRandomOrderRepeatedly(iteration_count, ["F", "B", "A", "D", "C", "E", "G", "I", "H"], rnd)
			; StringBstTesting.assertInsertAllInRandomOrderRepeatedly(iteration_count, ["four","score","and","seven","years","ago"], rnd)

			; StringBstTesting.assertInsertAllInOrderFollowedByFinds( ["F","B","A","D","C","E","G","I","H"], ["J", "K", "L"])
			; IntBstTesting.assertInsertAllInRandomOrderFollowedByFindsEachInRandomOrderRepeatedly(iteration_count, [0,1,4,6,8,9], [2,3,5,7], rnd)
			; StringBstTesting.assertInsertAllInRandomOrderFollowedByFindsEachInRandomOrderRepeatedly(iteration_count, ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"], ["a", "e", "i", "o", "u"], rnd)

			; ( 
				if is_remove_testing_desired
				then 
					( StringBstTesting.set_ignore_potential_remove_problems_for_full_credit(ignore_potential_remove_problems_for_full_credit)
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "A")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "C")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "E")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "H")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "I")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "G")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "D")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "B")
					; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "F")
					; (	if ignore_potential_remove_problems_for_full_credit
						then ()
						else
							( StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["B"], "A")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["B"], "C")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["Ted","Jackie","Bobby","Bill"], "Michael")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "0_is_before_A_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "A_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "B_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "C_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "D_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "E_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "F_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "G_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "H_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "I_non_present")
							; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "J_non_present")
							)
					)

					; IntBstTesting.assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(iteration_count, [0,1,2,3,4,5,6,7,8,9], rnd)
					; StringBstTesting.assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(iteration_count, ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"], rnd)
					; 
					(	if ignore_potential_remove_problems_for_full_credit
						then ()
						else name_tree_test(is_remove_testing_desired)
					)
					)
				else ()
			)
		; UnitTesting.leave() )
end
