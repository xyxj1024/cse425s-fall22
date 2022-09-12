CM.make "sum_distances_to_origin_pattern_testing.cm";

val _ = ( SumDistancesToOriginPatternTesting.test_sum_distances_to_origin()
        ; OS.Process.exit(OS.Process.success)
        )
