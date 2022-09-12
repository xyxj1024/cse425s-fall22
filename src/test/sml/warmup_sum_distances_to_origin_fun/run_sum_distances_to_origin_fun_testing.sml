CM.make "sum_distances_to_origin_fun_testing.cm";

val _ = ( SumDistancesToOriginFunTesting.test_sum_distances_to_origin()
        ; OS.Process.exit(OS.Process.success)
        )
