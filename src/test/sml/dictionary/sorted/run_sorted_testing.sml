(* Dennis Cosgrove *)

CM.make "sorted_dictionary_testing.cm";
CM.make "../../binary_search_tree/bst_testing.cm";
CM.make "../../command_line_args/command_line_args.cm";

val is_remove_testing_desired = CommandLineArgs.getBoolOrDefault("remove", true)
val ignore_potential_remove_problems_for_full_credit = CommandLineArgs.getBoolOrDefault("ignore_potential_remove_problems_for_full_credit", false)
val _ = ( MacroBstTesting.test_bst(is_remove_testing_desired, ignore_potential_remove_problems_for_full_credit)
        ; SortedDictionaryTesting.test(is_remove_testing_desired)
        ; OS.Process.exit(OS.Process.success) )
