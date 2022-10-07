(* Dennis Cosgrove *)
CM.make "bst_testing.cm";
CM.make "../command_line_args/command_line_args.cm";

val _ = ( MacroBstTesting.test_bst(CommandLineArgs.getBoolOrDefault("remove", true))
        ; OS.Process.exit(OS.Process.success)
        )
