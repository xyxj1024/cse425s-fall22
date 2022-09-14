(* Dennis Cosgrove *)
CM.make "hearts_testing.cm";

val _ = ( HeartsTesting.test_hearts()
        ; OS.Process.exit(OS.Process.success)
        )
