CM.make "remove_first_occurrence_testing.cm";

val _ = ( RemoveFirstOccurrenceTesting.test_remove_first_occurrence()
        ; OS.Process.exit(OS.Process.success)
        )
