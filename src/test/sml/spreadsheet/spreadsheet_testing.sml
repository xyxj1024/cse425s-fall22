(* Dennis Cosgrove *)
structure SpreadsheetTesting :> sig
	val nums_spreadsheet : Spreadsheet.cell list list
    val grades_spreadsheet : Spreadsheet.cell list list
    val hockey_spreadsheet : Spreadsheet.cell list list

    val test_spreadsheet : unit -> unit
end = struct
    open Csv
    open Spreadsheet

    val nums_csv = "1,2,3,4\n10,20,30,40"
    val nums_string_list_list = [["1", "2", "3", "4"], ["10", "20", "30", "40"]]
    val grades_csv = "Name,Java List,SML Calendar,SML Hearts,SML Card Game,Java HOF,SML Binary Tree,SML Pattern Matching\nMax,100,104,100,104,100,100,105\nJoshua Bloch,100,85,80,75,100,70,65\nHarry Q. Bovik,80,81,82,83,84,85,86\nDan Grossman,75,104,100,104,80,100,105\nShannon O'Ganns,70,40,0,120,120,130,140"
    val grades_string_list_list = [["Name", "Java List", "SML Calendar", "SML Hearts", "SML Card Game", "Java HOF", "SML Binary Tree", "SML Pattern Matching"], ["Max", "100", "104", "100", "104", "100", "100", "105"], ["Joshua Bloch", "100", "85", "80", "75", "100", "70", "65"], ["Harry Q. Bovik", "80", "81", "82", "83", "84", "85", "86"], ["Dan Grossman", "75", "104", "100", "104", "80", "100", "105"], ["Shannon O'Ganns", "70", "40", "0", "120", "120", "130", "140"]]
    val hockey_csv = "Name,Uniform Number,Birth Year,Games Played,Goals,Assists\nBobby Orr,4,1948,657,270,645\nWayne Gretzky,99,1961,1487,894,1963\nMario Lemieux,66,1965,915,690,1033"
    val hockey_string_list_list = [["Name", "Uniform Number", "Birth Year", "Games Played", "Goals", "Assists"], ["Bobby Orr", "4", "1948", "657", "270", "645"], ["Wayne Gretzky", "99", "1961", "1487", "894", "1963"], ["Mario Lemieux", "66", "1965", "915", "690", "1033"]]

    fun test_read_csv() =
        let
			fun assert_read_csv_with_argument_text(expected, csv_text, argument_text) =
				StringTesting.assertListListEvalEqualsWithMessage(
					expected, 
					fn() => read_csv(csv_text), 
					"read_csv(" ^ argument_text ^ ")"
				)

			fun assert_read_csv(expected, csv_text) =
				let
					fun to_quoted_newline_handling_string(text) =
						"\"" ^ (String.translate Char.toString text) ^ "\""
				in
					assert_read_csv_with_argument_text(expected, csv_text, "read_csv(" ^ to_quoted_newline_handling_string(csv_text) ^ ")")
				end

		    val name_rank_serial_csv = "name,rank,serial\nDwight David Eisenhower,General,5\nVasily Zaitsev,Sniper,225\nGrace Hopper,Rear Admiral,1952"
		    val name_rank_serial_string_list_list = [["name","rank","serial"],["Dwight David Eisenhower","General","5"],["Vasily Zaitsev","Sniper","225"], ["Grace Hopper", "Rear Admiral", "1952"]]
        in
			( UnitTesting.enter("read_csv") 
				(* 
				 * NOTE: very reasonable implementations of read_csv can come up with different results for "" so I have opted not to test it at all.
				 *)
				; assert_read_csv([["1"]], "1")
				; assert_read_csv([["1"],["2"]], "1\n2")
				; assert_read_csv([["",""]], ",")
				; assert_read_csv([["1","2","3","4"]], "1,2,3,4")
				; assert_read_csv_with_argument_text(nums_string_list_list, nums_csv, "nums_csv")
				; assert_read_csv_with_argument_text(grades_string_list_list, grades_csv, "grades_csv")
				; assert_read_csv_with_argument_text(hockey_string_list_list, hockey_csv, "hockey_csv")
				; assert_read_csv_with_argument_text(name_rank_serial_string_list_list, name_rank_serial_csv, "name_rank_serial_csv")
			; UnitTesting.leave()
			)
        end
    
    val nums_spreadsheet = [[INTEGER(1), INTEGER(2), INTEGER(3), INTEGER(4)], [INTEGER(10), INTEGER(20), INTEGER(30), INTEGER(40)]]
    val grades_spreadsheet = [[TEXT("Name"), TEXT("Java List"), TEXT("SML Calendar"), TEXT("SML Hearts"), TEXT("SML Card Game"), TEXT("Java HOF"), TEXT("SML Binary Tree"), TEXT("SML Pattern Matching")], [TEXT("Max"), INTEGER(100), INTEGER(104), INTEGER(100), INTEGER(104), INTEGER(100), INTEGER(100), INTEGER(105)], [TEXT("Joshua Bloch"), INTEGER(100), INTEGER(85), INTEGER(80), INTEGER(75), INTEGER(100), INTEGER(70), INTEGER(65)], [TEXT("Harry Q. Bovik"), INTEGER(80), INTEGER(81), INTEGER(82), INTEGER(83), INTEGER(84), INTEGER(85), INTEGER(86)], [TEXT("Dan Grossman"), INTEGER(75), INTEGER(104), INTEGER(100), INTEGER(104), INTEGER(80), INTEGER(100), INTEGER(105)], [TEXT("Shannon O'Ganns"), INTEGER(70), INTEGER(40), INTEGER(0), INTEGER(120), INTEGER(120), INTEGER(130), INTEGER(140)]]
    val hockey_spreadsheet = [[TEXT("Name"), TEXT("Uniform Number"), TEXT("Birth Year"), TEXT("Games Played"), TEXT("Goals"), TEXT("Assists")], [TEXT("Bobby Orr"), INTEGER(4), INTEGER(1948), INTEGER(657), INTEGER(270), INTEGER(645)], [TEXT("Wayne Gretzky"), INTEGER(99), INTEGER(1961), INTEGER(1487), INTEGER(894), INTEGER(1963)], [TEXT("Mario Lemieux"), INTEGER(66), INTEGER(1965), INTEGER(915), INTEGER(690), INTEGER(1033)]]

	fun binding_to_spreadsheet(binding) =
		case binding of
			"nums_spreadsheet" => nums_spreadsheet
		| "grades_spreadsheet" => grades_spreadsheet
		| "hockey_spreadsheet" => hockey_spreadsheet
		| _ => raise Fail binding

    fun test_create_sheet() =
		let
			fun assert_create_sheet_with_argument_text(expected, csv_list_list, argument_text) =
				CellTesting.assertListListEvalEqualsWithMessage(
					expected, 
					fn() => create_sheet(csv_list_list), 
					"create_sheet(" ^ argument_text ^ ")"
				)

			fun assert_create_sheet(expected, csv_list_list) =
				assert_create_sheet_with_argument_text(expected, csv_list_list, StringTesting.toStringFromListList(csv_list_list))

		in
			( UnitTesting.enter("create_sheet") 
				; assert_create_sheet([], [])
				; assert_create_sheet([[EMPTY]], [[""]])
				; assert_create_sheet([[INTEGER(1)]], [["1"]])
				; assert_create_sheet([[TEXT("fred")]], [["fred"]])
				; assert_create_sheet([[TEXT("fred"), TEXT("george")]],[["fred", "george"]])
				; assert_create_sheet_with_argument_text(nums_spreadsheet, nums_string_list_list, "nums_string_list_list")
				; assert_create_sheet_with_argument_text(grades_spreadsheet, grades_string_list_list, "grades_string_list_list")
				; assert_create_sheet_with_argument_text(hockey_spreadsheet, hockey_string_list_list, "hockey_string_list_list")
			; UnitTesting.leave()
			)
		end

    fun test_row_count() =
		let
			fun assert_row_count_with_argument_text(expected, sheet, argument_text) =
				IntTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => row_count(sheet), 
					"row_count(" ^ argument_text ^ ")"
				)

			fun assert_row_count(expected, sheet) =
				assert_row_count_with_argument_text(expected, sheet, CellTesting.toStringFromListList(sheet))
			
			fun assert_row_count_from_binding(expected, binding) =
				assert_row_count_with_argument_text(expected, binding_to_spreadsheet(binding), binding)
		in
			( UnitTesting.enter("row_count") 
				; assert_row_count(0, [])
				; assert_row_count_from_binding(2, "nums_spreadsheet")
				; assert_row_count_from_binding(6, "grades_spreadsheet")
				; assert_row_count_from_binding(4, "hockey_spreadsheet")
			; UnitTesting.leave()
			)
		end

    fun test_column_count() =
		let
			fun assert_column_count_with_argument_text(expected, sheet, argument_text) =
				IntTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => column_count(sheet), 
					"column_count(" ^ argument_text ^ ")"
				)

			fun assert_column_count(expected, sheet) =
				assert_column_count_with_argument_text(expected, sheet, CellTesting.toStringFromListList(sheet))

			fun assert_column_count_from_binding(expected, binding) =
				assert_column_count_with_argument_text(expected, binding_to_spreadsheet(binding), binding)
		in
			( UnitTesting.enter("column_count") 
				; assert_column_count(0, [])
				; assert_column_count_from_binding(4, "nums_spreadsheet")
				; assert_column_count_from_binding(8, "grades_spreadsheet")
				; assert_column_count_from_binding(6, "hockey_spreadsheet")
			; UnitTesting.leave()
			)
		end

    fun test_row_at() =
		let
			fun assert_row_at_from_binding(expected, (binding, row_index)) =
				CellTesting.assertListEvalEqualsWithMessage(
					expected, 
					fn() => row_at(binding_to_spreadsheet(binding), row_index), 
					"row_at(" ^ binding ^ ", " ^ Int.toString(row_index) ^ ")"
				)
		in
			( UnitTesting.enter("row_at") 
				; assert_row_at_from_binding([INTEGER(1), INTEGER(2), INTEGER(3), INTEGER(4)], ("nums_spreadsheet", 0))
				; assert_row_at_from_binding([INTEGER(10), INTEGER(20), INTEGER(30), INTEGER(40)], ("nums_spreadsheet", 1))

				; assert_row_at_from_binding([TEXT("Name"), TEXT("Java List"), TEXT("SML Calendar"), TEXT("SML Hearts"), TEXT("SML Card Game"), TEXT("Java HOF"), TEXT("SML Binary Tree"), TEXT("SML Pattern Matching")], ("grades_spreadsheet", 0))
				; assert_row_at_from_binding([TEXT("Max"), INTEGER(100), INTEGER(104), INTEGER(100), INTEGER(104), INTEGER(100), INTEGER(100), INTEGER(105)], ("grades_spreadsheet", 1))
				; assert_row_at_from_binding([TEXT("Joshua Bloch"), INTEGER(100), INTEGER(85), INTEGER(80), INTEGER(75), INTEGER(100), INTEGER(70), INTEGER(65)], ("grades_spreadsheet", 2))
				; assert_row_at_from_binding([TEXT("Harry Q. Bovik"), INTEGER(80), INTEGER(81), INTEGER(82), INTEGER(83), INTEGER(84), INTEGER(85), INTEGER(86)], ("grades_spreadsheet", 3))
				; assert_row_at_from_binding([TEXT("Dan Grossman"), INTEGER(75), INTEGER(104), INTEGER(100), INTEGER(104), INTEGER(80), INTEGER(100), INTEGER(105)], ("grades_spreadsheet", 4))
				; assert_row_at_from_binding([TEXT("Shannon O'Ganns"), INTEGER(70), INTEGER(40), INTEGER(0), INTEGER(120), INTEGER(120), INTEGER(130), INTEGER(140)], ("grades_spreadsheet", 5))

				; assert_row_at_from_binding([TEXT("Name"), TEXT("Uniform Number"), TEXT("Birth Year"), TEXT("Games Played"), TEXT("Goals"), TEXT("Assists")], ("hockey_spreadsheet", 0))
				; assert_row_at_from_binding([TEXT("Bobby Orr"), INTEGER(4), INTEGER(1948), INTEGER(657), INTEGER(270), INTEGER(645)], ("hockey_spreadsheet", 1))
				; assert_row_at_from_binding([TEXT("Wayne Gretzky"), INTEGER(99), INTEGER(1961), INTEGER(1487), INTEGER(894), INTEGER(1963)], ("hockey_spreadsheet", 2))
				; assert_row_at_from_binding([TEXT("Mario Lemieux"), INTEGER(66), INTEGER(1965), INTEGER(915), INTEGER(690), INTEGER(1033)], ("hockey_spreadsheet", 3))
			; UnitTesting.leave() )
		end

    fun test_cell_at() =
		let
			fun assert_cell_at_from_binding(expected, (binding, row_index, col_index)) =
				CellTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => cell_at(binding_to_spreadsheet(binding), row_index, col_index), 
					"cell_at(" ^ binding ^ ", " ^ Int.toString(row_index) ^ ", "  ^ Int.toString(col_index) ^ ")"
				)
		in
			( UnitTesting.enter("cell_at") 
				; assert_cell_at_from_binding(TEXT("Name"), ("hockey_spreadsheet", 0, 0))
				; assert_cell_at_from_binding(TEXT("Uniform Number"), ("hockey_spreadsheet", 0, 1))
				; assert_cell_at_from_binding(TEXT("Birth Year"), ("hockey_spreadsheet", 0, 2))
				; assert_cell_at_from_binding(TEXT("Games Played"), ("hockey_spreadsheet", 0, 3))
				; assert_cell_at_from_binding(TEXT("Goals"), ("hockey_spreadsheet", 0, 4))
				; assert_cell_at_from_binding(TEXT("Assists"), ("hockey_spreadsheet", 0, 5))

				; assert_cell_at_from_binding(TEXT("Bobby Orr"), ("hockey_spreadsheet", 1, 0))
				; assert_cell_at_from_binding(INTEGER(4), ("hockey_spreadsheet", 1, 1))
				; assert_cell_at_from_binding(INTEGER(1948), ("hockey_spreadsheet", 1, 2))
				; assert_cell_at_from_binding(INTEGER(657), ("hockey_spreadsheet", 1, 3))
				; assert_cell_at_from_binding(INTEGER(270), ("hockey_spreadsheet", 1, 4))
				; assert_cell_at_from_binding(INTEGER(645), ("hockey_spreadsheet", 1, 5))
			; UnitTesting.leave()
			)
		end

    fun test_column_at() =
		let
			fun assert_column_at_from_binding(expected, (binding, column_index)) =
				CellTesting.assertListEvalEqualsWithMessage(
					expected, 
					fn() => column_at(binding_to_spreadsheet(binding), column_index), 
					"column_at(" ^ binding ^ ", " ^ Int.toString(column_index) ^ ")"
				)
		in
			( UnitTesting.enter("column_at") 
				; assert_column_at_from_binding([INTEGER(1), INTEGER(10)], ("nums_spreadsheet", 0))
				; assert_column_at_from_binding([INTEGER(2), INTEGER(20)], ("nums_spreadsheet", 1))
				; assert_column_at_from_binding([INTEGER(3), INTEGER(30)], ("nums_spreadsheet", 2))
				; assert_column_at_from_binding([INTEGER(4), INTEGER(40)], ("nums_spreadsheet", 3))

				; assert_column_at_from_binding([TEXT("Name"), TEXT("Max"), TEXT("Joshua Bloch"), TEXT("Harry Q. Bovik"), TEXT("Dan Grossman"), TEXT("Shannon O'Ganns")], ("grades_spreadsheet", 0))
				; assert_column_at_from_binding([TEXT("Java List"), INTEGER(100), INTEGER(100), INTEGER(80), INTEGER(75), INTEGER(70)], ("grades_spreadsheet", 1))
				; assert_column_at_from_binding([TEXT("SML Calendar"), INTEGER(104), INTEGER(85), INTEGER(81), INTEGER(104), INTEGER(40)], ("grades_spreadsheet", 2))
				; assert_column_at_from_binding([TEXT("SML Hearts"), INTEGER(100), INTEGER(80), INTEGER(82), INTEGER(100), INTEGER(0)], ("grades_spreadsheet", 3))
				; assert_column_at_from_binding([TEXT("SML Card Game"), INTEGER(104), INTEGER(75), INTEGER(83), INTEGER(104), INTEGER(120)], ("grades_spreadsheet", 4))
				; assert_column_at_from_binding([TEXT("Java HOF"), INTEGER(100), INTEGER(100), INTEGER(84), INTEGER(80), INTEGER(120)], ("grades_spreadsheet", 5))
				; assert_column_at_from_binding([TEXT("SML Binary Tree"), INTEGER(100), INTEGER(70), INTEGER(85), INTEGER(100), INTEGER(130)], ("grades_spreadsheet", 6))
				; assert_column_at_from_binding([TEXT("SML Pattern Matching"), INTEGER(105), INTEGER(65), INTEGER(86), INTEGER(105), INTEGER(140)], ("grades_spreadsheet", 7))

				; assert_column_at_from_binding([TEXT("Name"), TEXT("Bobby Orr"), TEXT("Wayne Gretzky"), TEXT("Mario Lemieux")], ("hockey_spreadsheet", 0))
				; assert_column_at_from_binding([TEXT("Uniform Number"), INTEGER(4), INTEGER(99), INTEGER(66)], ("hockey_spreadsheet", 1))
				; assert_column_at_from_binding([TEXT("Birth Year"), INTEGER(1948), INTEGER(1961), INTEGER(1965)], ("hockey_spreadsheet", 2))
				; assert_column_at_from_binding([TEXT("Games Played"), INTEGER(657), INTEGER(1487), INTEGER(915)], ("hockey_spreadsheet", 3))
				; assert_column_at_from_binding([TEXT("Goals"), INTEGER(270), INTEGER(894), INTEGER(690)], ("hockey_spreadsheet", 4))
				; assert_column_at_from_binding([TEXT("Assists"), INTEGER(645), INTEGER(1963), INTEGER(1033)], ("hockey_spreadsheet", 5))
			; UnitTesting.leave() )
		end

    fun test_sum_in_row() =
		let
			fun assert_sum_in_row_with_argument_text(expected, sheet, row_index, argument_text) =
				IntTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => sum_in_row(sheet, row_index), 
					"sum_in_row(" ^ argument_text ^ ")"
				)

			fun assert_sum_in_row(expected, (sheet, row_index)) =
				assert_sum_in_row_with_argument_text(expected, sheet, row_index, CellTesting.toStringFromListList(sheet))
			
			fun assert_sum_in_row_from_binding(expected, (binding, row_index)) =
				assert_sum_in_row_with_argument_text(expected, binding_to_spreadsheet(binding), row_index, binding)
		in
			( UnitTesting.enter("sum_in_row") 
				; assert_sum_in_row(0, ([[EMPTY]], 0))
				; assert_sum_in_row(0, ([[TEXT("fred")]], 0))
				; assert_sum_in_row(425, ([[INTEGER(425)]], 0))
				; assert_sum_in_row(425, ([[EMPTY, INTEGER(425), TEXT("fred")]], 0))
				; assert_sum_in_row(656, ([[INTEGER(425), INTEGER(231)]], 0))

				; assert_sum_in_row_from_binding(10, ("nums_spreadsheet", 0))
				; assert_sum_in_row_from_binding(100, ("nums_spreadsheet", 1))

				; assert_sum_in_row_from_binding(0, ("grades_spreadsheet", 0))
				; assert_sum_in_row_from_binding(713, ("grades_spreadsheet", 1))
				; assert_sum_in_row_from_binding(575, ("grades_spreadsheet", 2))
				; assert_sum_in_row_from_binding(581, ("grades_spreadsheet", 3))
				; assert_sum_in_row_from_binding(668, ("grades_spreadsheet", 4))
				; assert_sum_in_row_from_binding(620, ("grades_spreadsheet", 5))

				; assert_sum_in_row_from_binding(0, ("hockey_spreadsheet", 0))
				; assert_sum_in_row_from_binding(3524, ("hockey_spreadsheet", 1))
				; assert_sum_in_row_from_binding(6404, ("hockey_spreadsheet", 2))
				; assert_sum_in_row_from_binding(4669, ("hockey_spreadsheet", 3))
			; UnitTesting.leave()
			)
		end

    fun test_sum_in_column() =
		let
			fun assert_sum_in_column_with_argument_text(expected, sheet, column_index, argument_text) =
				IntTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => sum_in_column(sheet, column_index), 
					"sum_in_column(" ^ argument_text ^ ")"
				)

			fun assert_sum_in_column(expected, (sheet, column_index)) =
				assert_sum_in_column_with_argument_text(expected, sheet, column_index, CellTesting.toStringFromListList(sheet))
			
			fun assert_sum_in_column_from_binding(expected, (binding, column_index)) =
				assert_sum_in_column_with_argument_text(expected, binding_to_spreadsheet(binding), column_index, binding)
		in
			( UnitTesting.enter("sum_in_column") 
				; assert_sum_in_column_from_binding(11, ("nums_spreadsheet", 0))
				; assert_sum_in_column_from_binding(22, ("nums_spreadsheet", 1))
				; assert_sum_in_column_from_binding(33, ("nums_spreadsheet", 2))
				; assert_sum_in_column_from_binding(44, ("nums_spreadsheet", 3))

				; assert_sum_in_column_from_binding(0, ("grades_spreadsheet", 0))
				; assert_sum_in_column_from_binding(425, ("grades_spreadsheet", 1))
				; assert_sum_in_column_from_binding(414, ("grades_spreadsheet", 2))
				; assert_sum_in_column_from_binding(362, ("grades_spreadsheet", 3))
				; assert_sum_in_column_from_binding(486, ("grades_spreadsheet", 4))
				; assert_sum_in_column_from_binding(484, ("grades_spreadsheet", 5))
				; assert_sum_in_column_from_binding(485, ("grades_spreadsheet", 6))
				; assert_sum_in_column_from_binding(501, ("grades_spreadsheet", 7))

				; assert_sum_in_column_from_binding(0, ("hockey_spreadsheet", 0))
				; assert_sum_in_column_from_binding(169, ("hockey_spreadsheet", 1))
				; assert_sum_in_column_from_binding(5874, ("hockey_spreadsheet", 2))
				; assert_sum_in_column_from_binding(3059, ("hockey_spreadsheet", 3))
			; UnitTesting.leave()
			)
		end

    fun test_max_in_row() =
		let
			fun assert_max_in_row_with_argument_text(expected, sheet, row_index, argument_text) =
				IntTesting.assertOptionEvalEqualsWithMessage(
					expected, 
					fn() => max_in_row(sheet, row_index), 
					"max_in_row(" ^ argument_text ^ ")"
				)

			fun assert_max_in_row(expected, (sheet, row_index)) =
				assert_max_in_row_with_argument_text(expected, sheet, row_index, CellTesting.toStringFromListList(sheet))
			
			fun assert_max_in_row_from_binding(expected, (binding, row_index)) =
				assert_max_in_row_with_argument_text(expected, binding_to_spreadsheet(binding), row_index, binding)
		in
			( UnitTesting.enter("max_in_row") 
				; assert_max_in_row(NONE, ([[EMPTY]], 0))
				; assert_max_in_row(NONE, ([[TEXT("fred")]], 0))
				; assert_max_in_row(SOME(425), ([[INTEGER(425)]], 0))
				; assert_max_in_row(SOME(425), ([[EMPTY, INTEGER(425), TEXT("fred")]], 0))
				; assert_max_in_row(SOME(425), ([[INTEGER(425), INTEGER(231)]], 0))
				; assert_max_in_row(SOME(425), ([[INTEGER(231), INTEGER(425)]], 0))

				; assert_max_in_row_from_binding(SOME(4), ("nums_spreadsheet", 0))
				; assert_max_in_row_from_binding(SOME(40), ("nums_spreadsheet", 1))

				; assert_max_in_row_from_binding(NONE, ("grades_spreadsheet", 0))
				; assert_max_in_row_from_binding(SOME(105), ("grades_spreadsheet", 1))
				; assert_max_in_row_from_binding(SOME(100), ("grades_spreadsheet", 2))
				; assert_max_in_row_from_binding(SOME(86), ("grades_spreadsheet", 3))
				; assert_max_in_row_from_binding(SOME(105), ("grades_spreadsheet", 4))
				; assert_max_in_row_from_binding(SOME(140), ("grades_spreadsheet", 5))

				; assert_max_in_row_from_binding(NONE, ("hockey_spreadsheet", 0))
				; assert_max_in_row_from_binding(SOME(1948), ("hockey_spreadsheet", 1))
				; assert_max_in_row_from_binding(SOME(1963), ("hockey_spreadsheet", 2))
				; assert_max_in_row_from_binding(SOME(1965), ("hockey_spreadsheet", 3))
			; UnitTesting.leave()
			)
		end

    fun test_max_in_column() =
		let
			fun assert_max_in_column_with_argument_text(expected, sheet, column_index, argument_text) =
				IntTesting.assertOptionEvalEqualsWithMessage(
					expected, 
					fn() => max_in_column(sheet, column_index), 
					"max_in_column(" ^ argument_text ^ ")"
				)

			fun assert_max_in_column(expected, (sheet, column_index)) =
				assert_max_in_column_with_argument_text(expected, sheet, column_index, CellTesting.toStringFromListList(sheet))
			
			fun assert_max_in_column_from_binding(expected, (binding, column_index)) =
				assert_max_in_column_with_argument_text(expected, binding_to_spreadsheet(binding), column_index, binding)
		in
			( UnitTesting.enter("max_in_column") 
				; assert_max_in_column_from_binding(SOME(10), ("nums_spreadsheet", 0))
				; assert_max_in_column_from_binding(SOME(20), ("nums_spreadsheet", 1))
				; assert_max_in_column_from_binding(SOME(30), ("nums_spreadsheet", 2))
				; assert_max_in_column_from_binding(SOME(40), ("nums_spreadsheet", 3))

				; assert_max_in_column_from_binding(NONE, ("grades_spreadsheet", 0))
				; assert_max_in_column_from_binding(SOME(100), ("grades_spreadsheet", 1))
				; assert_max_in_column_from_binding(SOME(104), ("grades_spreadsheet", 2))
				; assert_max_in_column_from_binding(SOME(100), ("grades_spreadsheet", 3))
				; assert_max_in_column_from_binding(SOME(120), ("grades_spreadsheet", 4))
				; assert_max_in_column_from_binding(SOME(120), ("grades_spreadsheet", 5))
				; assert_max_in_column_from_binding(SOME(130), ("grades_spreadsheet", 6))
				; assert_max_in_column_from_binding(SOME(140), ("grades_spreadsheet", 7))

				; assert_max_in_column_from_binding(NONE, ("hockey_spreadsheet", 0))
				; assert_max_in_column_from_binding(SOME(99), ("hockey_spreadsheet", 1))
				; assert_max_in_column_from_binding(SOME(1965), ("hockey_spreadsheet", 2))
				; assert_max_in_column_from_binding(SOME(1487), ("hockey_spreadsheet", 3))
				; assert_max_in_column_from_binding(SOME(894), ("hockey_spreadsheet", 4))
				; assert_max_in_column_from_binding(SOME(1963), ("hockey_spreadsheet", 5))
			; UnitTesting.leave()
	    	)
		end

    fun is_extra(cell) = 
        case cell of
            EMPTY => false
        |  TEXT(_) => false
        | INTEGER(v) => v > 100

    fun is_even(cell) = 
        case cell of
            EMPTY => false
        |  TEXT(_) => false
        | INTEGER(v) => (v mod 2) = 0

	fun is_greater_than_max(max) = 
		fn(cell) => 
			case cell of
				EMPTY => false
			|  TEXT(_) => false
			| INTEGER(v) => v > max

	fun maximum_score(column_index : int) : int = 
		case cell_at(grades_spreadsheet, 1, column_index) of
				   EMPTY => raise Fail("exprected INTEGER; actual EMPTY")
			|    TEXT(s) => raise Fail("exprected INTEGER; actual TEXT(\"" ^ s ^ "\")" )
			| INTEGER(v) => v

	fun binding_to_fcn(binding) =
		(* bug in string literal pattern matching on windows forced this if elseif *)
		if binding = "is_extra" then is_extra
		else if binding = "is_even" then is_even
		else if binding = "is_greater_than_max(maximum_score(1))" then is_greater_than_max(maximum_score(1))
		else if binding = "is_greater_than_max(maximum_score(2))" then is_greater_than_max(maximum_score(2))
		else if binding = "is_greater_than_max(maximum_score(3))" then is_greater_than_max(maximum_score(3))
		else if binding = "is_greater_than_max(maximum_score(4))" then is_greater_than_max(maximum_score(4))
		else if binding = "is_greater_than_max(maximum_score(5))" then is_greater_than_max(maximum_score(5))
		else if binding = "is_greater_than_max(maximum_score(6))" then is_greater_than_max(maximum_score(6))
		else if binding = "is_greater_than_max(maximum_score(7))" then is_greater_than_max(maximum_score(7))
		else raise Fail binding

    fun test_count_if_in_row() =
		let
			fun assert_count_if_in_row_with_argument_text(expected, sheet, row_index, fcn, argument_text) =
				IntTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => count_if_in_row(sheet, row_index, fcn), 
					"count_if_in_row(" ^ argument_text ^ ")"
				)

			fun assert_count_if_in_row(expected, (sheet, row_index, fcn)) =
				assert_count_if_in_row_with_argument_text(expected, sheet, row_index, fcn, CellTesting.toStringFromListList(sheet))
			
			fun assert_count_if_in_row_from_binding(expected, (sheet_binding, row_index, fcn_binding)) =
				assert_count_if_in_row_with_argument_text(expected, binding_to_spreadsheet(sheet_binding), row_index, binding_to_fcn(fcn_binding), sheet_binding ^ ", " ^ IntTesting.toString(row_index) ^ ", " ^ fcn_binding)
		in
			( UnitTesting.enter("count_if_in_row")
				; assert_count_if_in_row_from_binding(2, ("nums_spreadsheet", 0, "is_even"))
				; assert_count_if_in_row_from_binding(4, ("nums_spreadsheet", 1, "is_even"))

				; assert_count_if_in_row_from_binding(0, ("grades_spreadsheet", 0, "is_extra"))
				; assert_count_if_in_row_from_binding(3, ("grades_spreadsheet", 1, "is_extra"))
				; assert_count_if_in_row_from_binding(0, ("grades_spreadsheet", 2, "is_extra"))
				; assert_count_if_in_row_from_binding(0, ("grades_spreadsheet", 3, "is_extra"))
				; assert_count_if_in_row_from_binding(3, ("grades_spreadsheet", 4, "is_extra"))
				; assert_count_if_in_row_from_binding(4, ("grades_spreadsheet", 5, "is_extra"))

				; assert_count_if_in_row_from_binding(0, ("hockey_spreadsheet", 0, "is_even"))
				; assert_count_if_in_row_from_binding(3, ("hockey_spreadsheet", 1, "is_even"))
				; assert_count_if_in_row_from_binding(1, ("hockey_spreadsheet", 2, "is_even"))
				; assert_count_if_in_row_from_binding(2, ("hockey_spreadsheet", 3, "is_even"))
			; UnitTesting.leave()
			)
		end

    fun test_count_if_in_column() =
		let
			fun assert_count_if_in_column_with_argument_text(expected, sheet, column_index, fcn, argument_text) =
				IntTesting.assertEvalEqualsWithMessage(
					expected, 
					fn() => count_if_in_column(sheet, column_index, fcn), 
					"count_if_in_column(" ^ argument_text ^ ")"
				)

			fun assert_count_if_in_column(expected, (sheet, column_index, fcn)) =
				assert_count_if_in_column_with_argument_text(expected, sheet, column_index, fcn, CellTesting.toStringFromListList(sheet))
			
			fun assert_count_if_in_column_from_binding(expected, (sheet_binding, column_index, fcn_binding)) =
				assert_count_if_in_column_with_argument_text(expected, binding_to_spreadsheet(sheet_binding), column_index, binding_to_fcn(fcn_binding), sheet_binding ^ ", " ^ IntTesting.toString(column_index) ^ ", " ^ fcn_binding)
		in
			( UnitTesting.enter("count_if_in_column")
				; assert_count_if_in_column_from_binding(1, ("nums_spreadsheet", 0, "is_even"))
				; assert_count_if_in_column_from_binding(2, ("nums_spreadsheet", 1, "is_even"))
				; assert_count_if_in_column_from_binding(1, ("nums_spreadsheet", 2, "is_even"))
				; assert_count_if_in_column_from_binding(2, ("nums_spreadsheet", 3, "is_even"))

				; assert_count_if_in_column_from_binding(0, ("grades_spreadsheet", 0, "is_extra"))
				; assert_count_if_in_column_from_binding(0, ("grades_spreadsheet", 1, "is_extra"))
				; assert_count_if_in_column_from_binding(2, ("grades_spreadsheet", 2, "is_extra"))
				; assert_count_if_in_column_from_binding(0, ("grades_spreadsheet", 3, "is_extra"))
				; assert_count_if_in_column_from_binding(3, ("grades_spreadsheet", 4, "is_extra"))
				; assert_count_if_in_column_from_binding(1, ("grades_spreadsheet", 5, "is_extra"))
				; assert_count_if_in_column_from_binding(1, ("grades_spreadsheet", 6, "is_extra"))
				; assert_count_if_in_column_from_binding(3, ("grades_spreadsheet", 7, "is_extra"))

				; assert_count_if_in_column_from_binding(0, ("hockey_spreadsheet", 0, "is_even"))
				; assert_count_if_in_column_from_binding(2, ("hockey_spreadsheet", 1, "is_even"))
				; assert_count_if_in_column_from_binding(1, ("hockey_spreadsheet", 2, "is_even"))
				; assert_count_if_in_column_from_binding(0, ("hockey_spreadsheet", 3, "is_even"))
				; assert_count_if_in_column_from_binding(3, ("hockey_spreadsheet", 4, "is_even"))
				; assert_count_if_in_column_from_binding(0, ("hockey_spreadsheet", 5, "is_even"))

				; assert_count_if_in_column_from_binding(0, ("grades_spreadsheet", 1, "is_greater_than_max(maximum_score(1))"))
				; assert_count_if_in_column_from_binding(0, ("grades_spreadsheet", 2, "is_greater_than_max(maximum_score(2))"))
				; assert_count_if_in_column_from_binding(0, ("grades_spreadsheet", 3, "is_greater_than_max(maximum_score(3))"))
				; assert_count_if_in_column_from_binding(1, ("grades_spreadsheet", 4, "is_greater_than_max(maximum_score(4))"))
				; assert_count_if_in_column_from_binding(1, ("grades_spreadsheet", 5, "is_greater_than_max(maximum_score(5))"))
				; assert_count_if_in_column_from_binding(1, ("grades_spreadsheet", 6, "is_greater_than_max(maximum_score(6))"))
				; assert_count_if_in_column_from_binding(1, ("grades_spreadsheet", 7, "is_greater_than_max(maximum_score(7))"))
			; UnitTesting.leave()
			)
		end

    fun test_spreadsheet() =
        ( test_read_csv()
		; test_create_sheet()
        ; test_row_count()
        ; test_column_count()
        ; test_row_at()
        ; test_cell_at()
        ; test_column_at()
        ; test_sum_in_row()
        ; test_sum_in_column()
        ; test_max_in_row()
        ; test_max_in_column()
        ; test_count_if_in_row()
        ; test_count_if_in_column()
	    )

end
