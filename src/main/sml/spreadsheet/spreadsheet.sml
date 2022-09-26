structure Spreadsheet = struct
    (* Xingjian Xuanyuan *)

    datatype cell = EMPTY | TEXT of string | INTEGER of int
    type sheet = cell list list

    fun create_sheet(word_lists : string list list) : sheet =
        let 
            (* Check if a char is actually an int *)
            fun is_integer(c : char) : bool =
                c = #"0" orelse c = #"1" orelse c = #"2" orelse c = #"3" orelse c = #"4" orelse
                c = #"5" orelse c = #"6" orelse c = #"7" orelse c = #"8" orelse c = #"9"
            
            (* Convert each string in the string list to a cell *)
            fun create_line(word : string list) : cell list =
                case word of
                    [] => []
                | ""::rest => EMPTY::create_line(rest)
                | head::rest =>
                    (* Check each char in the char list *)
                    if List.all is_integer (String.explode head)
                    (* Convert a string into an int *)
                    then (INTEGER (valOf (Int.fromString head)))::create_line(rest)
                    else (TEXT head)::create_line(rest)

        (* Create a cell list list by mapping create_line to 
           each string list in word_lists *)
        in List.map create_line word_lists
        end

    fun row_count(s : sheet) : int =
        foldl (fn (x,acc) => acc + 1) 0 s

    fun column_count(s : sheet) : int =
        case s of 
            [] => 0
          | head::_ => foldl (fn (x,acc) => acc + 1) 0 head

    fun row_at(s : sheet, row_index : int) : cell list =
        List.nth(s, row_index)

    fun cell_in_row_at_column_index(r : cell list, col_index : int) : cell = 
        List.nth(r, col_index)

    fun cell_at(s : sheet, row_index : int, col_index : int) : cell = 
        cell_in_row_at_column_index(row_at(s, row_index), col_index)

    fun column_at(s : sheet, col_index : int) : cell list =
        case s of
            [] => []
          | head::rest => List.nth(head, col_index)::column_at(rest, col_index)

    fun sum_in_cell_list(cells : cell list) : int =
        case cells of
            [] => 0
          | head::rest => 
            case head of
                INTEGER(x) => x + sum_in_cell_list(rest)
              | _ => sum_in_cell_list(rest)

    fun sum_in_row(s : sheet, row_index : int) : int =
        sum_in_cell_list(row_at(s, row_index))

    fun sum_in_column(s : sheet, column_index : int) : int =
        sum_in_cell_list(column_at(s, column_index))

    fun max_in_cell_list(cells : cell list) : int option =
        let
            fun int_list(cells: cell list) : int list =
                case cells of
                    [] => []
                  | head::rest => 
                    case head of
                        INTEGER(x) => x::int_list(rest)
                      | _ => int_list(rest)
        in 
            case int_list(cells) of 
                [] => NONE
              | _ => SOME (foldl Int.max 0 (int_list(cells)))
        end

    fun max_in_row(s : sheet, row_index : int) : int option =
        max_in_cell_list(row_at(s, row_index))

    fun max_in_column(s : sheet, column_index : int) : int option =
        max_in_cell_list(column_at(s, column_index))

    fun count_if_in_cell_list(cells : cell list, predicate : (cell -> bool)) : int = 
        foldl (fn (c, acc) => if predicate(c) then acc + 1 else acc) 0 cells

    fun count_if_in_row(s : sheet, row_index : int, predicate : (cell -> bool)) : int = 
        count_if_in_cell_list(row_at(s, row_index), predicate)

    fun count_if_in_column(s : sheet, col_index : int, predicate : (cell -> bool)) : int = 
        count_if_in_cell_list(column_at(s, col_index), predicate)
end
