CM.make "sum_scan_pattern_testing.cm";

val _ = ( SumScanPatternTesting.test_sum_scan()
        ; OS.Process.exit(OS.Process.success)
        )
