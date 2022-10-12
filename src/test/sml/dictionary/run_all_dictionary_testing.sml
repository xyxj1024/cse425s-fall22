(* Dennis Cosgrove *)

CM.make "chained/chained_testing.cm";
CM.make "sorted/sorted_dictionary_testing.cm";
CM.make "../command_line_args/command_line_args.cm";

val _ = ( ChainedTesting.test_chained()
        ; SortedDictionaryTesting.test(CommandLineArgs.getBoolOrDefault("remove", true))
        ; OS.Process.exit(OS.Process.success) )
