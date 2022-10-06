functor BstTestingFn (
    BstTestingParam : sig 
        eqtype entry
        type key
        val assert_option_entry_eval_equals : (entry option * (unit -> entry option) * string) -> unit
        val compare_keys : key * key -> order
        val to_key : entry -> key
        val to_string_from_key : key -> string
        val to_string_from_entry : entry -> string
        val debug_compare_text : unit -> string
        val debug_to_s_text : unit -> string
    end
) : sig
    val test_bare_minimum_implemented : BstTestingParam.entry -> unit
    val test_reasonable_minimum_implemented : BstTestingParam.entry -> unit
    val test_reasonable_minimum_correct : (BstTestingParam.entry * BstTestingParam.entry) -> unit
    val assertInsertAll : BstTestingParam.entry list -> unit
    val assertInsertAllInRandomOrderRepeatedly : (int * BstTestingParam.entry list) -> unit
    val assertInsertAllInOrderFollowedByRemove : (BstTestingParam.entry list * BstTestingParam.entry) -> unit
    val assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly : (int * BstTestingParam.entry list) -> unit
    val assertInsertAllInOrderFollowedByFinds : (BstTestingParam.entry list * BstTestingParam.entry list) -> unit
    val assertInsertAllInRandomOrderFollowedByFindsEachInRandomOrderRepeatedly : (int * BstTestingParam.entry list * BstTestingParam.entry list) -> unit
end = struct

    open BstTestingParam

    fun assert_create_empty_completion(compare_keys, to_key, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.create_empty(compare_keys, to_key) , "create_empty(compare_keys, to_key)", exception_note)

    fun assert_find_completion(bst, entry, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.find(bst, to_key(entry)), "find(" ^ bst_binding ^ ", " ^ to_string_from_key(to_key(entry)) ^ ")", exception_note)

    fun assert_insert_completion(bst, entry, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.insert(bst, entry), "insert(" ^ bst_binding ^ ", " ^ to_string_from_key(to_key(entry)) ^ ")", exception_note)

    fun assert_fold_rnl_completion(bst, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.fold_rnl(op::, [], bst) , "fold_rnl(op::, [], " ^ bst_binding ^ ")", exception_note)

    fun assert_remove_completion(bst, key, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.remove(bst, key), "remove(" ^ bst_binding ^ ", " ^ to_string_from_key(key) ^ ")", exception_note)

    fun test_implemented(entry, exception_note) = 
        let
            val bst = assert_create_empty_completion(compare_keys, to_key, exception_note) 
            val _ = assert_find_completion(bst, entry, "bst", exception_note) 
            val (bst_prime, _) = assert_insert_completion(bst, entry, "bst", exception_note) 
        in
            bst_prime
        end

    fun test_bare_minimum_implemented(entry) = 
        let
            val _ = UnitTesting.enter("test_bare_minimum_implemented")
            val _ = test_implemented(entry, "at a bare minimum, to effectively test BinarySearchTree create_tree, insert, and find functions must be implemented.")
        in
            UnitTesting.leave()
        end

    fun test_reasonable_minimum_implemented(entry) =
        let
            val _ = UnitTesting.enter("test_reasonable_minimum_implemented")
            val exception_note = "to reasonably test BinarySearchTree, at least the create, insert, find, and fold_rnl functions must be implemented"
            val bst_prime = test_implemented(entry, exception_note)
            val _ = assert_fold_rnl_completion(bst_prime, "bst_prime", exception_note)
        in
            UnitTesting.leave()
        end

    fun test_insert(expected_prev, bst_binding, bst, entry) =
        let
            val bst_prime_ref = ref bst
            val _ = assert_option_entry_eval_equals(
                expected_prev, 
                fn() => 
                    let
                        val (bst', prev_entry_option) = BinarySearchTree.insert(bst, entry)
                        val _ = bst_prime_ref := bst'
                    in
                        prev_entry_option
                    end
                , "insert(" ^ bst_binding ^ ", " ^ to_string_from_entry(entry) ^ ")"
            )
        in
            !bst_prime_ref
        end

    fun test_find(expected, bst_binding, bst, key) =
        assert_option_entry_eval_equals(
            expected, 
            fn() => BinarySearchTree.find(bst, key)
            , "find(" ^ bst_binding ^ ", " ^ to_string_from_key(key) ^ ")"
        )

    fun test_reasonable_minimum_correct(a, b) = 
        let
            val _ = UnitTesting.enter("test_reasonable_minimum_correct")
            val bst = BinarySearchTree.create_empty(compare_keys, to_key) 
            val _ = test_find(NONE, "bst", bst, to_key(a))
            val _ = test_find(NONE, "bst", bst, to_key(b))
            val bst_prime = test_insert(NONE, "bst", bst, a)
            val _ = test_find(SOME a, "bst_prime", bst_prime, to_key(a))
            val _ = test_find(NONE, "bst_prime", bst_prime, to_key(b))
            val _ = test_find(NONE, "bst", bst, to_key(a))
            val _ = test_find(NONE, "bst", bst, to_key(b))
        in
            UnitTesting.leave()
        end

    fun compare_entries(a,b) =
        compare_keys(to_key(a), to_key(b))

    structure EqTesting = EqualityTestingFn(
        struct 
            type t = entry
            val toString = to_string_from_entry
            val compare = compare_entries
        end
    )

    fun bst_to_list(bst) : entry list =
        BinarySearchTree.fold_rnl(op::, [], bst)

    fun insertAll(xs) =
        let 
            val exception_note = ""
            val bst = assert_create_empty_completion(compare_keys, to_key, exception_note)
            fun helper(xs, acc) =
                case xs of
                        [] => acc
                | x :: xs' => let
                                val (acc,_) = assert_insert_completion(acc, x, "bst_from_previous_line", exception_note)
                              in
                                helper(xs', acc)
                              end
        in
            helper(xs, bst)
        end

    fun remove_random(xs : entry list, r : Random.rand) : (entry*(entry list)) = 
        let 
            val i = Random.randInt(r) mod List.length(xs)
            val x = List.nth(xs, i)
            val xs' = List.filter (fn v=> compare_entries(v,x) <> EQUAL) xs
        in
            (x, xs')
        end

    fun shuffle(original_list : entry list, r : Random.rand) : entry list =
        let
            val input = ref original_list
            val output = ref []
            val _ = 
                while List.length(!input) > 0 do
                    let
                        val (v, input') = remove_random(!input, r)
                        val _ = output := (v :: !output)
                        val _ = input := input'
                    in
                        ()
                    end
        in
            !output
        end
    
    fun to_debug(xs) = 
        let
            val init = "val bst = BinarySearchTree.create_empty(" ^ debug_compare_text() ^ ", fn(v)=>v)\n" 
            fun f(x, acc) = 
                acc ^ "val (bst,_) = BinarySearchTree.insert(bst, " ^ EqTesting.toString(x) ^ ")\n"
        in
            List.foldl f init xs
        end


    fun assertInsertAll(original_list : entry list) : unit = 
        let
            val _ = UnitTesting.enter("assertInsertAll(" ^ EqTesting.toStringFromList(original_list) ^ ")")
            val expected_list : entry list = (ListMergeSort.uniqueSort compare_entries original_list)
            val actual_tree = insertAll(original_list)
            val actual_list : entry list = bst_to_list(actual_tree)

            val test_case_detail = "bst_to_list(bst_from_previous_line)"
            val expected_detail = EqTesting.toStringFromList(expected_list)
            val _ = 
                if expected_list = actual_list
                then UnitTesting.on_success(SOME test_case_detail, "as expected, equals: " ^ expected_detail)
                else 
                    let
                        (* TODO: output code for BST debug *)
                        val actual_detail = EqTesting.toStringFromList(actual_list)
                    in
                        UnitTesting.on_failure(SOME test_case_detail, expected_detail, actual_detail ^ 
                        "\n!!!\n!!! v v v text for debug v v v \n\n\n" ^ to_debug(original_list) ^ "\n\nval identity = " ^ debug_to_s_text() ^ "\n\n!!!")
                    end
        in
            UnitTesting.leave()
        end

    fun assertInsertAllInRandomOrder(original_list: entry list, r : Random.rand) : unit = 
        let
            val shuffled = shuffle(original_list, r)
        in
            assertInsertAll shuffled
        end

    fun assertInsertAllInRandomOrderRepeatedly(n : int, original_list: entry list) : unit = 
        let
            val r = Random.rand(425, 231)
            val i = ref(0)
        in
            while !i < n do 
                let
                    val _ = print("\n    =========\n    iteration: "^ Int.toString(!i+1) ^ " of " ^ Int.toString(n) ^ "; assertInsertAllInRandomOrderRepeatedly(" ^ Int.toString(n) ^ ", " ^ EqTesting.toStringFromList(original_list) ^ ")\n    =========\n")
                    val _ = i := !i + 1
                in
                    assertInsertAllInRandomOrder(original_list, r)
                end
        end

    fun assertInsertAllInOrderFollowedByRemove(values: entry list, entry_to_remove : entry) : unit = 
        let
            val exception_note = ""
            val _ = UnitTesting.enter("assertInsertAllInOrderFollowedByRemove(" ^ EqTesting.toStringFromList(values) ^ ", " ^ EqTesting.toString(entry_to_remove) ^ ")")
            val original_tree = insertAll(values)
            val (actual_tree_post_remove,_) = assert_remove_completion(original_tree, to_key(entry_to_remove), "bst_from_previous_line", exception_note)
            val actual_values_post_remove = bst_to_list(actual_tree_post_remove)

            val values_post_remove = List.filter (fn v=> v<>entry_to_remove) values
            val expected_values_post_remove = (ListMergeSort.uniqueSort compare_entries values_post_remove)
            val test_case_detail = "bst_to_list(bst_from_previous_line)"
            val expected_detail = EqTesting.toStringFromList(expected_values_post_remove)
            val actual_detail = EqTesting.toStringFromList(actual_values_post_remove)
            val _ = 
                if expected_values_post_remove = actual_values_post_remove
                then UnitTesting.on_success(SOME test_case_detail, "equals: " ^ expected_detail)
                else 
                    (* let
                    val original_tree_string = BinarySearchTree.debug_message(item_to_string, original_tree)
                    val actual_tree_string = BinarySearchTree.debug_message(item_to_string, actual_tree_post_remove)
                    in
                    UnitTesting.on_failure(NONE, item_list_to_string(expected_values_post_remove), item_list_to_string(actual_values_post_remove) ^ "\n!!!                    assertInsertAllInOrderFollowedByRemove(" ^ item_list_to_string(values) ^ ", " ^ item_to_string(value_to_remove) ^ ")\n!!!                    original tree: " ^ original_tree_string ^ "\n!!!                    post remove tree: " ^ actual_tree_string)
                    end *)
                    UnitTesting.on_failure(SOME test_case_detail, expected_detail, actual_detail)

        in
            UnitTesting.leave()
        end

    fun assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrder(original_list: entry list, r : Random.rand) : unit = 
        let
            val shuffled_list = shuffle(original_list, r)
            val input = ref shuffled_list
            val output : entry list ref = ref []
        in
            while List.length(!input) > 0 do
                let
                    val xs = !input
                    val (v, input') = remove_random(!input, r)
                    val _ = output := (v :: !output)
                    val _ = input := input'
                in
                    assertInsertAllInOrderFollowedByRemove(xs, v)
                end 
        end

    fun assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(n : int, original_list: entry list) : unit = 
        let
            val r = Random.rand(425, 231)
            val i = ref(0)
        in
            while !i < n do 
                let
                    val _ = print("\n    =========\n    iteration: "^ Int.toString(!i) ^ "; assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(" ^ Int.toString(n) ^ ", " ^ EqTesting.toStringFromList(original_list) ^ ")\n    =========\n")
                    val _ = i := !i + 1
                in
                    assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrder(original_list, r)
                end
        end

    fun assertInsertAllInOrderFollowedByFinds(values_to_insert: entry list, missing_values_to_attempt_to_find : entry list) : unit = 
        let
            val tree = insertAll(values_to_insert)


            fun helper(entries) =
                case entries of
                  [] => ()
                | entry::entries' => 
                    let
                        val actual = BinarySearchTree.find(tree, to_key(entry))
                        val is_expected = List.find (fn(x)=>x=entry) values_to_insert
                        val expected = if isSome(is_expected) then SOME entry else NONE
                        val _ = EqTesting.assertOptionEquals(expected, actual)
                    in
                        helper(entries')
                    end
        in
            helper(values_to_insert @ missing_values_to_attempt_to_find)
        end

    fun assertInsertAllInRandomOrderFollowedByFindsEachInRandomOrderRepeatedly(n : int, original_list: entry list, missing_values_to_attempt_to_find : entry list) : unit = 
        let
            val r = Random.rand(425, 231)
            val i = ref(0)
        in
            while !i < n do 
                let
                    val _ = print("\n    =========\n    iteration: "^ Int.toString(!i) ^ "; assertInsertAllInOrderFollowedByFindsEachInRandomOrderRepeatedly(" ^ Int.toString(n) ^ ", " ^ EqTesting.toStringFromList(original_list) ^ ")\n    =========\n")
                    val _ = i := !i + 1
                    val shuffled_present_list = shuffle(original_list, r)
                    val shuffled_missing_list = shuffle(missing_values_to_attempt_to_find, r)
                in
                    assertInsertAllInOrderFollowedByFinds(shuffled_present_list, shuffled_missing_list)
                end
        end

end
