CM.make "sum_distances_to_origin_testing.cm";

val _ = ( SumDistancesToOriginTesting.test_sum_distances_to_origin()
        ; OS.Process.exit(OS.Process.success)
        )
