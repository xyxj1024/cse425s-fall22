(* Dennis Cosgrove *)
CM.make "eliminate_unsorted_testing.cm";

val _ = ( EliminateUnsortedTesting.test_eliminate_unsorted()
        ; OS.Process.exit(OS.Process.success)
        )
