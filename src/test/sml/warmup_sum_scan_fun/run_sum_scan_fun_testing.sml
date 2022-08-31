CM.make "sum_scan_fun_testing.cm";

val _ = ( SumScanFunTesting.test_sum_scan()
        ; OS.Process.exit(OS.Process.success)
        )
