CM.make "sum_scan_using_hof_testing.cm";

val _ = ( SumScanUsingHofTesting.test_sum_scan()
        ; OS.Process.exit(OS.Process.success)
        )
