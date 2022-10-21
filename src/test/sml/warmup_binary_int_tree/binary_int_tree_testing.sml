(* Dennis Cosgrove *)

structure BinaryIntTreeTesting : sig
	val test_binary_int_tree : unit -> unit
end = struct
    open BinaryIntTree

    structure TreeToString = ToStringFn (struct
        type t = int_tree
        fun toString(EMPTY) = "EMPTY"
          | toString(NODE(left,element,right)) = "NODE(" ^ toString(left) ^ "," ^ Int.toString(element) ^ "," ^ toString(right) ^ ")" 
    end)

    fun assert_sum_non_accumulate(expected, root) = 
        IntTesting.assertEvalEqualsWithMessage(
            expected, 
            fn() => sum(root), 
            "sum(" ^ TreeToString.toString(root) ^ ")"
        )

    fun assert_sum_accumulate(expected, root) = 
        IntTesting.assertEvalEqualsWithMessage(
            expected, 
            fn() => sum_accumulate(0, root), 
            "sum_accumulate(0, " ^ TreeToString.toString(root) ^ ")"
        )

    fun assert_sum_via_fold_rnl(expected, root) = 
        IntTesting.assertEvalEqualsWithMessage(
            expected, 
            fn() => fold_rnl(op+, 0, root), 
            "fold_rnl(op+, 0, " ^ TreeToString.toString(root) ^ ")"
        )

    fun assert_to_list_via_fold_rnl(expected, root) = 
        IntTesting.assertListEvalEqualsWithMessage(
            expected, 
            fn() => fold_rnl(op::, [], root), 
            "fold_rnl(op::, [], " ^ TreeToString.toString(root) ^ ")"
        )

    fun test_sum(method_name, assert_sum) =
        ( UnitTesting.enter(method_name)
            ; assert_sum(0, EMPTY)
            ; assert_sum(1, NODE(EMPTY, 1, EMPTY))
            ; assert_sum(6, NODE(NODE(EMPTY, 1, EMPTY), 2, NODE(EMPTY, 3, EMPTY)))
            ; assert_sum(28, NODE(NODE(NODE(EMPTY, 1, EMPTY), 2, NODE(EMPTY, 3, EMPTY)), 4, NODE(NODE(EMPTY, 5, EMPTY), 6, NODE(EMPTY, 7, EMPTY))))
        ; UnitTesting.leave() )

    fun test_to_list_via_fold_rnl() =
        ( UnitTesting.enter("fold_rnl(op::, [], ...)")
            ; assert_to_list_via_fold_rnl([], EMPTY)
            ; assert_to_list_via_fold_rnl([1], NODE(EMPTY, 1, EMPTY))
            ; assert_to_list_via_fold_rnl([1,2,3], NODE(NODE(EMPTY, 1, EMPTY), 2, NODE(EMPTY, 3, EMPTY)))
            ; assert_to_list_via_fold_rnl([1,2,3,4,5,6,7], NODE(NODE(NODE(EMPTY, 1, EMPTY), 2, NODE(EMPTY, 3, EMPTY)), 4, NODE(NODE(EMPTY, 5, EMPTY), 6, NODE(EMPTY, 7, EMPTY))))
        ; UnitTesting.leave() )

    fun test_sum_non_accumulate() =
        test_sum("sum", assert_sum_non_accumulate)

    fun test_sum_accumulate() =
        test_sum("sum_accumulate", assert_sum_accumulate)

    fun test_sum_via_fold_rnl() =
        test_sum("fold_rnl(op+, 0, ...)", assert_sum_via_fold_rnl)

    fun test_binary_int_tree() =
        ( UnitTesting.enter("BinaryIntTree")
        ; test_sum_non_accumulate()
        ; test_sum_accumulate()
        ; test_sum_via_fold_rnl()
        ; test_to_list_via_fold_rnl()
        ; UnitTesting.leave() )
end
