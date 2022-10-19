(* Dennis Cosgrove *)
structure SpreadsheetToDictionariesTesting :> sig
    val test_spreadsheet_to_dictionaries : unit -> unit
end = struct
	open Spreadsheet
	open SpreadsheetToDictionaries

    fun test_spreadsheet_to_dictionaries() =
        let
            val _ = UnitTesting.enter("spreadsheet_to_dictionaries_using_headers_as_keys")

			fun binding_to_spreadsheet(binding) =
				case binding of
				  "SpreadsheetTesting.nums_spreadsheet" => SpreadsheetTesting.nums_spreadsheet
				| "SpreadsheetTesting.grades_spreadsheet" => SpreadsheetTesting.grades_spreadsheet
				| "SpreadsheetTesting.hockey_spreadsheet" => SpreadsheetTesting.hockey_spreadsheet
				| _ => raise Fail binding

			fun spreadsheet_to_dictionaries_using_headers_as_keys_with_exception_handling(expected_binding, spreadsheet_binding) =
				spreadsheet_to_dictionaries_using_headers_as_keys(
					binding_to_spreadsheet(spreadsheet_binding)
				) handle e => 
					(UnitTesting.on_exception(
						SOME("spreadsheet_to_dictionaries_using_headers_as_keys(" ^ spreadsheet_binding ^ ")"), 
						expected_binding, 
						e)
						; raise e) 

            val nums_dicts = spreadsheet_to_dictionaries_using_headers_as_keys_with_exception_handling("nums_dicts", "SpreadsheetTesting.nums_spreadsheet")
            val grades_dicts = spreadsheet_to_dictionaries_using_headers_as_keys_with_exception_handling("grades_dicts", "SpreadsheetTesting.grades_spreadsheet")
            val hockey_dicts = spreadsheet_to_dictionaries_using_headers_as_keys_with_exception_handling("hockey_dicts", "SpreadsheetTesting.hockey_spreadsheet")

			fun binding_to_dicts(binding) =
				case binding of
				  "nums_dicts" => nums_dicts
				| "grades_dicts" => grades_dicts
				| "hockey_dicts" => hockey_dicts
				| _ => raise Fail binding

			fun assert_length(expected, binding) =
				IntTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => List.length(binding_to_dicts(binding)),
					"List.length(" ^ binding ^ ")"
				)

            val _ = assert_length(1, "nums_dicts")
            val nums_dict_a = List.nth(nums_dicts, 0)

            val _ = assert_length(5, "grades_dicts")
            val grades_dict_a = List.nth(grades_dicts, 0)
            val grades_dict_b = List.nth(grades_dicts, 1)
            val grades_dict_c = List.nth(grades_dicts, 2)
            val grades_dict_d = List.nth(grades_dicts, 3)
            val grades_dict_e = List.nth(grades_dicts, 4)

            val _ = assert_length(3, "hockey_dicts")
            val hockey_dict_a = List.nth(hockey_dicts, 0)
            val hockey_dict_b = List.nth(hockey_dicts, 1)
            val hockey_dict_c = List.nth(hockey_dicts, 2)

			fun binding_to_dict(binding) =
				case binding of
				  "nums_dict_a" => nums_dict_a
				| "grades_dict_a" => grades_dict_a
				| "grades_dict_b" => grades_dict_b
				| "grades_dict_c" => grades_dict_c
				| "grades_dict_d" => grades_dict_d
				| "grades_dict_e" => grades_dict_e
				| "hockey_dict_a" => hockey_dict_a
				| "hockey_dict_b" => hockey_dict_b
				| "hockey_dict_c" => hockey_dict_c
				| _ => raise Fail binding

			fun assert_get(expected, (binding, key)) =
				CellTesting.assertOptionEvalEqualsWithMessage(
					expected,
					fn() => SingleChainedDictionary.get(binding_to_dict(binding), key),
					"SingleChainedDictionary.get(" ^ binding ^ ", " ^ CellTesting.toString(key) ^ ")"
				)
        in
            	( assert_get(SOME(INTEGER(10)), ("nums_dict_a", INTEGER(1)))
				; assert_get(SOME(INTEGER(20)), ("nums_dict_a", INTEGER(2)))
				; assert_get(SOME(INTEGER(30)), ("nums_dict_a", INTEGER(3)))
				; assert_get(SOME(INTEGER(40)), ("nums_dict_a", INTEGER(4)))
				; assert_get(NONE, ("nums_dict_a", TEXT("NOT A HEADER")))

				; assert_get(SOME(TEXT("Max")), ("grades_dict_a", TEXT("Name")))
				; assert_get(SOME(INTEGER(100)), ("grades_dict_a", TEXT("Java List")))
				; assert_get(SOME(INTEGER(104)), ("grades_dict_a", TEXT("SML Calendar")))
				; assert_get(SOME(INTEGER(100)), ("grades_dict_a", TEXT("SML Hearts")))
				; assert_get(SOME(INTEGER(104)), ("grades_dict_a", TEXT("SML Card Game")))
				; assert_get(SOME(INTEGER(100)), ("grades_dict_a", TEXT("Java HOF")))
				; assert_get(SOME(INTEGER(100)), ("grades_dict_a", TEXT("SML Binary Tree")))
				; assert_get(SOME(INTEGER(105)), ("grades_dict_a", TEXT("SML Pattern Matching")))
				; assert_get(NONE, ("grades_dict_a", TEXT("NOT A HEADER")))

				; assert_get(SOME(TEXT("Joshua Bloch")), ("grades_dict_b", TEXT("Name")))
				; assert_get(SOME(INTEGER(100)), ("grades_dict_b", TEXT("Java List")))
				; assert_get(SOME(INTEGER(85)), ("grades_dict_b", TEXT("SML Calendar")))
				; assert_get(SOME(INTEGER(80)), ("grades_dict_b", TEXT("SML Hearts")))
				; assert_get(SOME(INTEGER(75)), ("grades_dict_b", TEXT("SML Card Game")))
				; assert_get(SOME(INTEGER(100)), ("grades_dict_b", TEXT("Java HOF")))
				; assert_get(SOME(INTEGER(70)), ("grades_dict_b", TEXT("SML Binary Tree")))
				; assert_get(SOME(INTEGER(65)), ("grades_dict_b", TEXT("SML Pattern Matching")))
				; assert_get(NONE, ("grades_dict_b", TEXT("NOT A HEADER")))

				; assert_get(SOME(TEXT("Shannon O'Ganns")), ("grades_dict_e", TEXT("Name")))
				; assert_get(SOME(INTEGER(70)), ("grades_dict_e", TEXT("Java List")))
				; assert_get(SOME(INTEGER(40)), ("grades_dict_e", TEXT("SML Calendar")))
				; assert_get(SOME(INTEGER(0)), ("grades_dict_e", TEXT("SML Hearts")))
				; assert_get(SOME(INTEGER(120)), ("grades_dict_e", TEXT("SML Card Game")))
				; assert_get(SOME(INTEGER(120)), ("grades_dict_e", TEXT("Java HOF")))
				; assert_get(SOME(INTEGER(130)), ("grades_dict_e", TEXT("SML Binary Tree")))
				; assert_get(SOME(INTEGER(140)), ("grades_dict_e", TEXT("SML Pattern Matching")))
				; assert_get(NONE, ("grades_dict_e", TEXT("NOT A HEADER")))

				; assert_get(SOME(TEXT("Bobby Orr")), ("hockey_dict_a", TEXT("Name")))
				; assert_get(SOME(INTEGER(4)), ("hockey_dict_a", TEXT("Uniform Number")))
				; assert_get(SOME(INTEGER(1948)), ("hockey_dict_a", TEXT("Birth Year")))
				; assert_get(SOME(INTEGER(657)), ("hockey_dict_a", TEXT("Games Played")))
				; assert_get(SOME(INTEGER(270)), ("hockey_dict_a", TEXT("Goals")))
				; assert_get(SOME(INTEGER(645)), ("hockey_dict_a", TEXT("Assists")))
				; assert_get(NONE, ("hockey_dict_a", TEXT("NOT A HEADER")))

				; assert_get(SOME(TEXT("Wayne Gretzky")), ("hockey_dict_b", TEXT("Name")))
				; assert_get(SOME(INTEGER(99)), ("hockey_dict_b", TEXT("Uniform Number")))
				; assert_get(SOME(INTEGER(1961)), ("hockey_dict_b", TEXT("Birth Year")))
				; assert_get(SOME(INTEGER(1487)), ("hockey_dict_b", TEXT("Games Played")))
				; assert_get(SOME(INTEGER(894)), ("hockey_dict_b", TEXT("Goals")))
				; assert_get(SOME(INTEGER(1963)), ("hockey_dict_b", TEXT("Assists")))
				; assert_get(NONE, ("hockey_dict_b", TEXT("NOT A HEADER")))

				; assert_get(SOME(TEXT("Mario Lemieux")), ("hockey_dict_c", TEXT("Name")))
				; assert_get(SOME(INTEGER(66)), ("hockey_dict_c", TEXT("Uniform Number")))
				; assert_get(SOME(INTEGER(1965)), ("hockey_dict_c", TEXT("Birth Year")))
				; assert_get(SOME(INTEGER(915)), ("hockey_dict_c", TEXT("Games Played")))
				; assert_get(SOME(INTEGER(690)), ("hockey_dict_c", TEXT("Goals")))
				; assert_get(SOME(INTEGER(1033)), ("hockey_dict_c", TEXT("Assists")))
				; assert_get(NONE, ("hockey_dict_c", TEXT("NOT A HEADER")))

            ; UnitTesting.leave()
            )
        end       

end
