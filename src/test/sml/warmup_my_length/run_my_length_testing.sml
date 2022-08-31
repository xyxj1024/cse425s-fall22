(* Dennis Cosgrove *)
CM.make "my_length_testing.cm";

val _ = ( MyLengthTesting.test_my_length()
        ; OS.Process.exit(OS.Process.success)
        )
