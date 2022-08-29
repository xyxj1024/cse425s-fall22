signature TO_STRING = sig
	type t

	val toString : t -> string
	val toStringFromList : t list -> string
	val toStringFromListList : t list list -> string
	val toStringFromOption : t option -> string

	val toStringFromOptionList : t option list -> string
	val toStringFromListOption : t list option -> string

	val toStringFromTuple2 : t*t -> string
	val toStringFromTuple3 : t*t*t -> string
	val toStringFromTuple4 : t*t*t*t -> string
	val toStringFromTuple5 : t*t*t*t*t -> string

	val toStringFromListOfTuple2s : (t*t) list -> string
end

signature TO_STRING_EQ = sig
	eqtype t

	val toString : t -> string
	val toStringFromList : t list -> string
	val toStringFromListList : t list list -> string
	val toStringFromOption : t option -> string

	val toStringFromOptionList : t option list -> string
	val toStringFromListOption : t list option -> string

	val toStringFromTuple2 : t*t -> string
	val toStringFromTuple3 : t*t*t -> string
	val toStringFromTuple4 : t*t*t*t -> string
	val toStringFromTuple5 : t*t*t*t*t -> string

	val toStringFromListOfTuple2s : (t*t) list -> string
end

functor ToStringFn (ToStringParam : sig
	type t
	val toString : t -> string
end) : TO_STRING = struct
	open ToStringParam

	fun to_list_string item_to_string xs =
		let
			fun helper nil = ""
			  | helper (sting::nil) = item_to_string(sting)
			  | helper (head::neck::rest) = item_to_string(head) ^ ", " ^ helper(neck::rest)
		in
			"[" ^ helper(xs) ^ "]"
		end

	fun to_option_string item_to_string (NONE) = "NONE" 
	  | to_option_string item_to_string (SOME(v)) = "SOME(" ^ item_to_string(v) ^ ")"

	val toStringFromList = to_list_string toString
	val toStringFromListList = to_list_string toStringFromList

	val toStringFromOption = to_option_string toString

	val toStringFromOptionList = to_list_string toStringFromOption
	val toStringFromListOption = to_option_string toStringFromList

	fun toStringFromTuple2(a,b) =
		"(" ^ toString(a) ^ ", " ^ toString(b) ^ ")"
	fun toStringFromTuple3(a,b,c) =
		"(" ^ toString(a) ^ ", " ^ toString(b) ^ ", " ^ toString(c) ^ ")"
	fun toStringFromTuple4(a,b,c,d) =
		"(" ^ toString(a) ^ ", " ^ toString(b) ^ ", " ^ toString(c) ^ ", " ^ toString(d) ^ ")"
	fun toStringFromTuple5(a,b,c,d,e) =
		"(" ^ toString(a) ^ ", " ^ toString(b) ^ ", " ^ toString(c) ^ ", " ^ toString(d) ^ ", " ^ toString(e) ^ ")"

	val toStringFromListOfTuple2s = to_list_string toStringFromTuple2
end

functor ToStringEqFn (ToStringParam : sig
	eqtype t
	val toString : t -> string
end) : TO_STRING_EQ = struct
	structure Adapter = ToStringFn(struct
		type t = ToStringParam.t
		val toString = ToStringParam.toString
	end)
	open Adapter
end
