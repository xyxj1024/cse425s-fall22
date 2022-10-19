CM.make "../spreadsheet/spreadsheet_testing.cm";
CM.make "../dictionary/chained/single/single_chained_dictionary_testing.cm";
CM.make "spreadsheet_to_dictionaries_testing.cm";

(* Dennis Cosgrove *)
val _ = ( SpreadsheetTesting.test_spreadsheet()
        ; SingleChainedDictionaryTesting.test()
        ; SpreadsheetToDictionariesTesting.test_spreadsheet_to_dictionaries()
        ; OS.Process.exit(OS.Process.success)
        )
