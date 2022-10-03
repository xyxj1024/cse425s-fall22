(* Dennis Cosgrove *)
CM.make "mutable_list_testing.cm";

val _ = 
    ( MutableListTesting.test_mutable_list()
    ; OS.Process.exit(OS.Process.success)
    )
