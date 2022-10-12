CM.make "sum_scan_no_identity_element_testing.cm";

val _ = ( SumScanNoIdentityElementTesting.test_sum_scan()
        ; OS.Process.exit(OS.Process.success)
        )
