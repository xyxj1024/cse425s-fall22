(* Dennis Cosgrove *)

CM.make "sorted_dictionary_testing.cm";
CM.make "../../binary_search_tree/bst_testing.cm";
CM.make "../../command_line_args/command_line_args.cm";

val is_remove_testing_desired = CommandLineArgs.getBoolOrDefault("remove", true)
val is_remove_non_present_testing_desired = CommandLineArgs.getBoolOrDefault("remove_non_present", false)
val _ = ( MacroBstTesting.test_bst(is_remove_testing_desired, is_remove_non_present_testing_desired)
        ; SortedDictionaryTesting.test(is_remove_testing_desired)
        ; OS.Process.exit(OS.Process.success) )
