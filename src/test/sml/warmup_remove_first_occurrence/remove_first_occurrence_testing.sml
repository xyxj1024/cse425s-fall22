structure RemoveFirstOccurrenceTesting :> sig
	val test_remove_first_occurrence : unit -> unit
end = struct
    fun test_remove_first_occurrence() =
        let
            open RemoveFirstOccurrence

            fun assert_remove_first_occurrence assert_func list_to_string_func to_string_func (expected, (xs, target)) = 
                assert_func(
                    expected, 
                    fn() => RemoveFirstOccurrence.remove_first_occurrence(xs, target), 
                    "remove_first_occurrence(" ^ list_to_string_func(xs) ^ ", " ^ to_string_func(target) ^ ")"
                )

            val assert_remove_first_occurrence_int = assert_remove_first_occurrence IntTesting.assertListEvalEqualsWithMessage IntTesting.toStringFromList IntTesting.toString
            val assert_remove_first_occurrence_string = assert_remove_first_occurrence StringTesting.assertListEvalEqualsWithMessage StringTesting.toStringFromList StringTesting.toString

        in
            ( UnitTesting.enter("remove_first_occurrence")

                ; assert_remove_first_occurrence_int([], ([], 425))
                ; assert_remove_first_occurrence_int([], ([425], 425))
                ; assert_remove_first_occurrence_int([425], ([425], 231))
                ; assert_remove_first_occurrence_int([425], ([231,425], 231))
                ; assert_remove_first_occurrence_int([231], ([231,425], 425))
                ; assert_remove_first_occurrence_int([231,425], ([231,425], 131))
                ; assert_remove_first_occurrence_int([2,3,4,5], ([1,2,3,4,5], 1))
                ; assert_remove_first_occurrence_int([1,3,4,5], ([1,2,3,4,5], 2))
                ; assert_remove_first_occurrence_int([1,2,4,5], ([1,2,3,4,5], 3))
                ; assert_remove_first_occurrence_int([1,2,3,5], ([1,2,3,4,5], 4))
                ; assert_remove_first_occurrence_int([1,2,3,4], ([1,2,3,4,5], 5))
                ; assert_remove_first_occurrence_int([1,2,3,4,5], ([1,2,3,4,5], 6))
                ; assert_remove_first_occurrence_string([], ([], "fred"))
                ; assert_remove_first_occurrence_string([], ([], "george"))
                ; assert_remove_first_occurrence_string([], (["fred"], "fred"))
                ; assert_remove_first_occurrence_string([], (["george"], "george"))
                ; assert_remove_first_occurrence_string(["fred"], (["fred"], "george"))
                ; assert_remove_first_occurrence_string(["george"], (["george"], "fred"))
                ; assert_remove_first_occurrence_string(["george"], (["fred", "george"], "fred"))
                ; assert_remove_first_occurrence_string(["fred"], (["fred", "george"], "george"))
                ; assert_remove_first_occurrence_string(["george", "ron"], (["fred", "george", "ron"], "fred"))
                ; assert_remove_first_occurrence_string(["fred", "ron"], (["fred", "george", "ron"], "george"))
                ; assert_remove_first_occurrence_string(["fred", "george"], (["fred", "george"], "ron"))
                ; assert_remove_first_occurrence_string(["fred", "george", "ron"], (["fred", "george", "ron"], "percy"))
            ; UnitTesting.leave() )
        end
end
