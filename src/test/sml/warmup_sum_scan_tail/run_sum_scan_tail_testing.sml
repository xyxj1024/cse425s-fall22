CM.make "sum_scan_tail_testing.cm";

val _ = ( SumScanTailTesting.test_sum_scan()
        ; OS.Process.exit(OS.Process.success)
        )
