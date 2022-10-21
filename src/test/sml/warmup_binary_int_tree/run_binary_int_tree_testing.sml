(* Dennis Cosgrove *)
CM.make "binary_int_tree_testing.cm";

val _ = ( BinaryIntTreeTesting.test_binary_int_tree()
        ; OS.Process.exit(OS.Process.success)
        )
