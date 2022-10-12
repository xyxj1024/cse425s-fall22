CM.make "hashed_dictionary_testing.cm";

val _ = ( HashedDictionaryTesting.test()
        ; OS.Process.exit(OS.Process.success)
        )
