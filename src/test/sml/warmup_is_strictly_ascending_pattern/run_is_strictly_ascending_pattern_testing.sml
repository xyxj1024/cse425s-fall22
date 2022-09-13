(* Dennis Cosgrove *)
CM.make "is_strictly_ascending_pattern_testing.cm";

val _ = ( IsStrictlyAscendingPatternTesting.test_is_strictly_ascending()
        ; OS.Process.exit(OS.Process.success)
        )
