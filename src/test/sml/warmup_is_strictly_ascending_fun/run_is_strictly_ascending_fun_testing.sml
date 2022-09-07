(* Dennis Cosgrove *)
CM.make "is_strictly_ascending_fun_testing.cm";

val _ = ( IsStrictlyAscendingFunTesting.test_is_strictly_ascending()
        ; OS.Process.exit(OS.Process.success)
        )
