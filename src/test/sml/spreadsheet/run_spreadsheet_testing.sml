CM.make "spreadsheet_testing.cm";

(* Dennis Cosgrove *)
val _ = ( SpreadsheetTesting.test_spreadsheet()
        ; OS.Process.exit(OS.Process.success)
        )
