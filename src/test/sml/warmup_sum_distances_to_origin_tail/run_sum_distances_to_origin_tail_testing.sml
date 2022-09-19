CM.make "sum_distances_to_origin_tail_testing.cm";

val _ = ( SumDistancesToOriginTailTesting.test_sum_distances_to_origin()
        ; OS.Process.exit(OS.Process.success)
        )
