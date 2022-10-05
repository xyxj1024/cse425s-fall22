(* Dennis Cosgrove *)
CM.make "bst_testing.cm";

val iteration_count = 10
val _ = ( MacroBstTesting.test_bst()
        ; OS.Process.exit(OS.Process.success)
        )
