CM.make "sum_distances_to_origin_using_hof_testing.cm";

val _ = ( SumDistancesToOriginUsingHigherOrderFunctionsTesting.test_sum_distances_to_origin()
        ; OS.Process.exit(OS.Process.success)
        )
