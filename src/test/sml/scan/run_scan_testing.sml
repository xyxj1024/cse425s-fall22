CM.make "scan_testing.cm";

val _ = ( ScanTesting.test_scan()
        ; OS.Process.exit(OS.Process.success)
        )
