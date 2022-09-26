(* Dennis Cosgrove *)
structure CellTesting = EqualityTestingFn (struct
	open Spreadsheet
	
	type t = cell
	val toString = fn(c)=> 
		case c of 
		       EMPTY => "EMPTY"
		|    TEXT(s) => "TEXT(\"" ^ s ^ "\")"
		| INTEGER(v) => "INTEGER(" ^ Int.toString(v) ^ ")"
	val compare = fn(a,b)=>raise Fail "unsupported"
end)
