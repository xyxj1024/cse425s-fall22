structure Spreadsheet = struct
    (* __STUDENT_NAME__ *)

    datatype cell = EMPTY | TEXT of string | INTEGER of int
    type sheet = cell list list

    fun create_sheet(word_lists : string list list) : sheet =
        raise Fail "NotYetImplemented"

    fun row_count(s : sheet) : int =
        raise Fail "NotYetImplemented"

    fun column_count(s : sheet) : int = 
        raise Fail "NotYetImplemented"

    fun row_at(s : sheet, row_index : int) : cell list = 
        raise Fail "NotYetImplemented"

    fun cell_in_row_at_column_index( r : cell list, col_index : int) : cell = 
        raise Fail "NotYetImplemented"

    fun cell_at(s : sheet, row_index : int, col_index : int) : cell = 
        cell_in_row_at_column_index(row_at(s, row_index), col_index)

    fun column_at(s : sheet, col_index : int) : cell list =
        raise Fail "NotYetImplemented"

    fun sum_in_cell_list(cells : cell list) : int =
        raise Fail "NotYetImplemented"

    fun sum_in_row(s : sheet, row_index : int) : int =
        sum_in_cell_list(row_at(s, row_index))

    fun sum_in_column(s : sheet, column_index : int) : int =
        sum_in_cell_list(column_at(s, column_index))

    fun max_in_cell_list(cells : cell list) : int option =
        raise Fail "NotYetImplemented"

    fun max_in_row(s : sheet, row_index : int) : int option =
        max_in_cell_list(row_at(s, row_index))

    fun max_in_column(s : sheet, column_index : int) : int option =
        max_in_cell_list(column_at(s, column_index))

    fun count_if_in_cell_list(cells : cell list, predicate : (cell -> bool)) : int = 
        raise Fail "NotYetImplemented"

    fun count_if_in_row(s : sheet, row_index : int, predicate : (cell -> bool)) : int = 
        count_if_in_cell_list(row_at(s, row_index), predicate)

    fun count_if_in_column(s : sheet, col_index : int, predicate : (cell -> bool)) : int = 
        count_if_in_cell_list(column_at(s, col_index), predicate)
end
