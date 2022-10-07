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
	fun test_bst(is_remove_testing_desired) = 
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

			; if is_remove_testing_desired
			  then 
			  	( StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "A")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "C")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "E")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "H")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "I")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "G")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "D")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "B")
				; StringBstTesting.assertInsertAllInOrderFollowedByRemove( ["F","B","A","D","C","E","G","I","H"], "F")
				; IntBstTesting.assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(iteration_count, [0,1,2,3,4,5,6,7,8,9], rnd)
				; StringBstTesting.assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(iteration_count, ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"], rnd)
				)
			  else ()

		; UnitTesting.leave() )
end
