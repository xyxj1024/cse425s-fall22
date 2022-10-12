CM.make "single_chained_dictionary_testing.cm";

val _ = ( SingleChainedDictionaryTesting.test()
        ; OS.Process.exit(OS.Process.success)
        )
