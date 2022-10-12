CM.make "chained_testing.cm";

val _ = ( ChainedTesting.test_chained()
        ; OS.Process.exit(OS.Process.success)
        )
