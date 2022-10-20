functor BstTestingFn (
    BstTestingParam : sig 
        eqtype entry
        type key
        val compare_keys : key * key -> order
        val to_key : entry -> key
        val to_string_from_key : key -> string
        val to_string_from_entry : entry -> string
        val debug_compare_text : unit -> string
        val debug_to_s_text : unit -> string
    end
) : sig
    (* TODO: REMOVE *)
    val set_ignore_potential_remove_problems_for_full_credit : bool -> unit

    val test_bare_minimum_implemented : BstTestingParam.entry -> unit
    val test_reasonable_minimum_implemented : BstTestingParam.entry -> unit
    val test_reasonable_minimum_correct : (BstTestingParam.entry * BstTestingParam.entry) -> unit

    val assert_create_empty_completion : unit -> (BstTestingParam.entry, BstTestingParam.key) BinarySearchTree.tree
    val assert_insert : (BstTestingParam.entry option * string * (BstTestingParam.entry, BstTestingParam.key) BinarySearchTree.tree * BstTestingParam.entry ) ->  (BstTestingParam.entry, BstTestingParam.key) BinarySearchTree.tree
    val assert_remove : (BstTestingParam.entry option * string * (BstTestingParam.entry, BstTestingParam.key) BinarySearchTree.tree * BstTestingParam.key ) ->  (BstTestingParam.entry, BstTestingParam.key) BinarySearchTree.tree
    val assert_find : (BstTestingParam.entry option * string * (BstTestingParam.entry, BstTestingParam.key) BinarySearchTree.tree * BstTestingParam.key ) -> unit
    val assert_bst_to_list : (BstTestingParam.entry list * string * (BstTestingParam.entry, BstTestingParam.key) BinarySearchTree.tree) -> unit

    val assertInsertAll : BstTestingParam.entry list -> unit
    val assertInsertAllInRandomOrderRepeatedly : (int * BstTestingParam.entry list * Random.rand) -> unit
    val assertInsertAllInOrderFollowedByFinds : (BstTestingParam.entry list * BstTestingParam.entry list) -> unit
    val assertInsertAllInRandomOrderFollowedByFindsEachInRandomOrderRepeatedly : (int * BstTestingParam.entry list * BstTestingParam.entry list * Random.rand) -> unit
    val assertInsertAllInOrderFollowedByRemove : (BstTestingParam.entry list * BstTestingParam.entry) -> unit
    val assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly : (int * BstTestingParam.entry list * Random.rand) -> unit
end = struct

    open BstTestingParam

    fun compare_entries(a,b) =
        compare_keys(to_key(a), to_key(b))

    structure EntryTesting = EqualityTestingFn(
        struct 
            type t = entry
            val toString = to_string_from_entry
            val compare = compare_entries
        end
    )

    fun each_in_range(min, maxExclusive, f) =
        if min<maxExclusive
        then (f(min); each_in_range(min+1, maxExclusive, f))
        else ()

    fun repeat_n_times(n, f) = 
        each_in_range(0, n, fn(i) => 
            let
                val _ = print("\niteration "^ Int.toString(i+1) ^ " of " ^ Int.toString(n) ^ ":\n=================\n")
            in
                f(i)
            end
        )            

    fun contains_duplicate(nil) = false
      | contains_duplicate(x::xs') = (List.exists (fn(v)=>x=v) xs') orelse (contains_duplicate(xs'))

    fun to_debug(inserts, removes) = 
        let
            val create_text = "val bst = BinarySearchTree.create_empty(" ^ debug_compare_text() ^ ", fn(v)=>v)\n" 
            fun append_insert(x, acc) = 
                acc ^ "val (bst,_) = BinarySearchTree.insert(bst, " ^ EntryTesting.toString(x) ^ ")\n"
            val insert_text = List.foldl append_insert "" inserts
            fun append_remove(x, acc) = 
                acc ^ "val (bst,_) = BinarySearchTree.remove(bst, " ^ EntryTesting.toString(x) ^ ")\n"
            val remove_text = List.foldl append_remove "" removes
        in
            create_text ^ insert_text ^ remove_text
        end

    fun output_debug(xs) =
        print("\n\nv v v text for debug v v v \n\n" ^ to_debug(xs) ^ "val identity = " ^ debug_to_s_text() ^ "\n\n^ ^ ^ text for debug ^ ^ ^ \n\n\n")

    fun assert_create_empty_completion_with_exception_note(exception_note) =
        CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.create_empty(compare_keys, to_key) , "create_empty(compare_keys, to_key)", exception_note)

    fun assert_create_empty_completion() =
        assert_create_empty_completion_with_exception_note("")

    fun assert_find_completion(bst, entry, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.find(bst, to_key(entry)), "find(" ^ bst_binding ^ ", " ^ to_string_from_key(to_key(entry)) ^ ")", exception_note)

    fun assert_insert_completion(bst, entry, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.insert(bst, entry), "insert(" ^ bst_binding ^ ", " ^ to_string_from_key(to_key(entry)) ^ ")", exception_note)

    fun assert_fold_rnl_completion(bst, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.fold_rnl(op::, [], bst) , "fold_rnl(op::, [], " ^ bst_binding ^ ")", exception_note)

    fun assert_remove_completion(bst, key, bst_binding, exception_note) =
		CompletionTesting.assertEvalCompletionWithMessageAndExceptionNote(fn()=>BinarySearchTree.remove(bst, key), "remove(" ^ bst_binding ^ ", " ^ to_string_from_key(key) ^ ")", exception_note)

    fun assert_insert(expected_prev, bst_binding, bst, entry) =
        let
            val bst_prime_ref = ref bst
            val _ = EntryTesting.assertOptionEvalEqualsWithMessage(
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

    fun assert_find(expected, bst_binding, bst, key) =
        EntryTesting.assertOptionEvalEqualsWithMessage(
            expected, 
            fn() => BinarySearchTree.find(bst, key)
            , "find(" ^ bst_binding ^ ", " ^ to_string_from_key(key) ^ ")"
        )

    fun assert_remove(expected_prev, bst_binding, bst, key) =
        let
            val bst_prime_ref = ref bst
            val _ = EntryTesting.assertOptionEvalEqualsWithMessage(
                expected_prev, 
                fn() => 
                    let
                        val (bst', prev_entry_option) = BinarySearchTree.remove(bst, key)
                        val _ = bst_prime_ref := bst'
                    in
                        prev_entry_option
                    end
                , "remove(" ^ bst_binding ^ ", " ^ to_string_from_key(key) ^ ")"
            )
        in
            !bst_prime_ref
        end

    fun test_implemented(entry, exception_note) = 
        let
            val bst = assert_create_empty_completion_with_exception_note(exception_note) 
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

    fun test_reasonable_minimum_correct(a, b) = 
        let
            val _ = UnitTesting.enter("test_reasonable_minimum_correct")
            val bst = BinarySearchTree.create_empty(compare_keys, to_key) 
            val _ = assert_find(NONE, "bst", bst, to_key(a))
            val _ = assert_find(NONE, "bst", bst, to_key(b))
            val bst_prime = assert_insert(NONE, "bst", bst, a)
            val _ = assert_find(SOME a, "bst_prime", bst_prime, to_key(a))
            val _ = assert_find(NONE, "bst_prime", bst_prime, to_key(b))
            val _ = assert_find(NONE, "bst", bst, to_key(a))
            val _ = assert_find(NONE, "bst", bst, to_key(b))
        in
            UnitTesting.leave()
        end

    fun assert_bst_to_list(expected_not_sorted, bst_binding, bst) =
        EntryTesting.assertListEvalEqualsSortedExpectedWithMessage(expected_not_sorted, fn()=>(BinarySearchTree.fold_rnl(op::, [], bst)), "fold_rnl(op::, [], " ^ bst_binding ^ ")")

    fun insert_all_no_duplicates(xs) =
        let 
            val bst_empty = assert_create_empty_completion()
            val bst_binding = "updated_bst"
            fun f(x, (bst, xs)) =
                let 
                    val _ = UnitTesting.enter("insert " ^ to_string_from_entry(x))
                    val bst' = assert_insert(NONE, bst_binding, bst, x)
                    val inserted_list_for_debug = xs @ [x]
                    val _ = assert_find(SOME(x), bst_binding, bst', to_key(x)) handle e => (output_debug(inserted_list_for_debug, []); raise e)
                    val _ = assert_bst_to_list(inserted_list_for_debug, bst_binding, bst') handle e => (output_debug(inserted_list_for_debug, []); raise e)
                    val _ = UnitTesting.leave()
                in
                    (bst', inserted_list_for_debug)
                end
            
            val (bst_full, _) = List.foldl f (bst_empty,[]) xs
        in
            (* helper(xs, bst) *)
            bst_full
        end

    fun assert_insert_all(xs) =
        if contains_duplicate(xs)
        then raise Fail("contains_duplicate: " ^ EntryTesting.toStringFromList(xs))
        else insert_all_no_duplicates(xs)

    fun assertInsertAll(original_list : entry list) = 
        let
            val _ = UnitTesting.enter("assertInsertAll(" ^ EntryTesting.toStringFromList(original_list) ^ ")")
            val _ = assert_insert_all(original_list)
        in
            UnitTesting.leave()
        end

    fun assertInsertAllInRandomOrderRepeatedly(n : int, original_list: entry list, rnd : Random.rand) : unit = 
        let
            val _ = UnitTesting.enter("assertInsertAllInRandomOrderRepeatedly(" ^ Int.toString(n) ^ ", " ^ EntryTesting.toStringFromList(original_list) ^ ", rnd)")
            val _ = repeat_n_times(n, fn(i)=>
                assertInsertAll(RandomUtils.shuffle(original_list, rnd))
            )
        in
            UnitTesting.leave()
        end

    fun assertInsertAllInOrderFollowedByFinds(entries_to_insert: entry list, missing_entries_to_attempt_to_find : entry list) : unit = 
        let
            val _ = UnitTesting.enter("assertInsertAllInOrderFollowedByFinds(" ^ EntryTesting.toStringFromList(entries_to_insert) ^ ", " ^ EntryTesting.toStringFromList(missing_entries_to_attempt_to_find) ^ ")")
            val bst = assert_insert_all(entries_to_insert)

            fun assert_pressent(x) = 
                assert_find(SOME(x), "bst", bst, to_key(x))

            fun assert_missing(x) = 
                assert_find(NONE, "bst", bst, to_key(x))
        in
            ( UnitTesting.enter("find present")
            ; List.app assert_pressent entries_to_insert
            ; UnitTesting.leave()
            ; UnitTesting.enter("find missing")
            ; List.app assert_missing missing_entries_to_attempt_to_find )
            ; UnitTesting.leave()
            ; UnitTesting.leave()
        end

    fun assertInsertAllInRandomOrderFollowedByFindsEachInRandomOrderRepeatedly(n : int, original_list: entry list, missing_values_to_attempt_to_find : entry list, rnd : Random.rand) : unit = 
        let
            val _ = UnitTesting.enter("assertInsertAllInRandomOrderFollowedByFindsEachInRandomOrderRepeatedly(" ^ Int.toString(n) ^ ", " ^ EntryTesting.toStringFromList(original_list) ^ ", rnd)")
            val _ = repeat_n_times(n, fn(i)=>
                let
                    val shuffled_present_list = RandomUtils.shuffle(original_list, rnd)
                    val shuffled_missing_list = RandomUtils.shuffle(missing_values_to_attempt_to_find, rnd)
                    val _ = assertInsertAllInOrderFollowedByFinds(shuffled_present_list, shuffled_missing_list)
                in
                    ()
                end
            )
        in
            UnitTesting.leave()
        end

    val ignore_potential_remove_problems_for_full_credit_ref = ref true

    fun set_ignore_potential_remove_problems_for_full_credit(ignore_potential_remove_problems_for_full_credit) =
        ignore_potential_remove_problems_for_full_credit_ref := ignore_potential_remove_problems_for_full_credit

    fun assertInsertAllInOrderFollowedByRemove(entries: entry list, entry_to_remove : entry) : unit = 
        let
            fun f(entry) = 
                entry = entry_to_remove
            val expected_prev = List.find f entries
            val _ = UnitTesting.enter("assertInsertAllInOrderFollowedByRemove(" ^ EntryTesting.toStringFromList(entries) ^ ", " ^ EntryTesting.toString(entry_to_remove) ^ ")")
            val bst = assert_insert_all(entries)
            val _ = UnitTesting.enter("remove " ^ to_string_from_key(to_key(entry_to_remove)))
            val bst' = assert_remove(expected_prev, "bst", bst, to_key(entry_to_remove)) handle e => (output_debug(entries, [entry_to_remove]); raise e)
            val _ = assert_find(NONE, "bst_after_remove", bst', to_key(entry_to_remove)) handle e => (output_debug(entries, [entry_to_remove]); raise e)
            fun remove_entry(nil) = nil
              | remove_entry(x::xs') = if x=entry_to_remove then xs' else x::remove_entry(xs')
            val expected_entries_after_remove = remove_entry(entries)
            val _ = 
                if !ignore_potential_remove_problems_for_full_credit_ref
                then ()
                else assert_bst_to_list(expected_entries_after_remove, "bst_after_remove", bst') handle e => (output_debug(entries, [entry_to_remove]); raise e)
            fun f(entry) = 
                if entry = entry_to_remove
                then ()
                else assert_find(SOME(entry), "bst_after_remove", bst', to_key(entry)) handle e => (output_debug(entries, [entry_to_remove]); raise e)
            val _ = List.app f entries
            val _ = UnitTesting.leave()
        in
            UnitTesting.leave()
        end

    fun remove_all_present(bst, removes, inserts_for_debug) =
        let 
            val bst_binding = "updated_bst"

            fun helper(bst, [], previously_removed) = bst
              | helper(bst, to_remove::removes', previously_removed) =
                let 
                    val _ = UnitTesting.enter("remove " ^ to_string_from_key(to_key(to_remove)))
                    val bst' = assert_remove(SOME(to_remove), bst_binding, bst, to_key(to_remove))
                    val removed = previously_removed @ [to_remove]
                    val _ = assert_find(NONE, bst_binding, bst', to_key(to_remove)) handle e => (output_debug(inserts_for_debug, removed); raise e)
                    val _ = assert_bst_to_list(removes', bst_binding, bst') handle e => (output_debug(inserts_for_debug, removed); raise e)
                    val _ = UnitTesting.leave()
                in
                    helper(bst', removes', removed)
                end
            
        in
            helper(bst, removes, [])
        end

    fun assertInsertAllFollowedByRemoveAll(inserts: entry list, removes : entry list) : unit = 
        let
            val _ = UnitTesting.enter("assertInsertAllFollowedByRemoveEachInRandomOrder((* inserts= *)" ^ EntryTesting.toStringFromList(inserts) ^ ", (* removes= *)"  ^ EntryTesting.toStringFromList(removes) ^ ")")
            val bst = assert_insert_all(inserts)
            val _ = remove_all_present(bst, removes, inserts)
        in
            UnitTesting.leave()
        end

    fun assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(n : int, original_list: entry list, rnd : Random.rand) : unit = 
        let
            val _ = UnitTesting.enter("assertInsertAllInRandomOrderFollowedByRemoveEachInRandomOrderRepeatedly(" ^ Int.toString(n) ^ ", " ^ EntryTesting.toStringFromList(original_list) ^ ", rnd)")
            val _ = repeat_n_times(n, fn(i)=>
                assertInsertAllFollowedByRemoveAll(RandomUtils.shuffle(original_list, rnd), RandomUtils.shuffle(original_list, rnd))
            )
        in
            UnitTesting.leave()
        end

end
