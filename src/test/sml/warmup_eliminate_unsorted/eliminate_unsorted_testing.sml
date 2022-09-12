(* Dennis Cosgrove *)

structure EliminateUnsortedTesting : sig
	val test_eliminate_unsorted : unit -> unit
end = struct
    open EliminateUnsorted

    fun assert_eliminate_unsorted(expected, xys) = 
		IntTesting.assertListEvalEqualsWithMessage(
            expected, 
            fn() => eliminate_unsorted(xys), 
            "eliminate_unsorted(" ^ IntTesting.toStringFromList(xys) ^ ")")

    fun test_eliminate_unsorted() =
        ( UnitTesting.enter("eliminate_unsorted")
        ; assert_eliminate_unsorted([], [])
        ; assert_eliminate_unsorted([0], [0])
        ; assert_eliminate_unsorted([1], [1])
        ; assert_eliminate_unsorted([425], [425])
        ; assert_eliminate_unsorted([1, 1], [1, 1])
        ; assert_eliminate_unsorted([1, 1, 2, 3, 3, 4, 5, 5], [1, 1, 2, 3, 3, 4, 5, 5])
        ; assert_eliminate_unsorted([1, 1, 2, 3, 3, 4, 5, 5], [1, 1, 2, 3, 1, 3, 2, 4, 1, 3, 5, 1, 5])
        ; assert_eliminate_unsorted([1, 1, 2, 3, 3, 4, 5, 5], [1, 1, 2, 3, 1, 3, 2, 4, 1, 3, 5, 1, 5, 0])
        ; assert_eliminate_unsorted([231, 425], [231, 425])
        ; assert_eliminate_unsorted([425], [425, 231])
        ; assert_eliminate_unsorted([1, 2, 3], [1, 2, 3])
        ; assert_eliminate_unsorted([2, 3], [2, 3, 1])
        ; assert_eliminate_unsorted([2, 3], [2, 1, 3])
        ; assert_eliminate_unsorted([3], [3, 2, 1])
        ; assert_eliminate_unsorted([3], [3, 1, 2])
        ; assert_eliminate_unsorted([1, 2, 3, 4], [1, 2, 3, 4])
        ; assert_eliminate_unsorted([1, 4], [1, 4, 2, 3])
        ; assert_eliminate_unsorted([1, 4], [1, 4, 3, 2])
        ; assert_eliminate_unsorted([4], [4, 1, 2, 3])
        ; assert_eliminate_unsorted([4], [4, 3, 1, 2])
        ; assert_eliminate_unsorted([4], [4, 3, 2, 1])
        ; assert_eliminate_unsorted([3, 4, 5, 9], [3, 1, 4, 1, 5, 9])
        ; assert_eliminate_unsorted([2, 7, 8], [2, 7, 1, 8])
        ; assert_eliminate_unsorted([1, 6, 8, 9], [1, 6, 1, 8, 0, 3, 3, 9, 8, 8, 7])
        ; UnitTesting.leave() )
end
