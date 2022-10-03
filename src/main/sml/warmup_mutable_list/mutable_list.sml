structure MutableList = struct
	(* __STUDENT_NAME__ *)
	(* Dennis Cosgrove *)

	datatype parrot = PARTY | SHUFFLE | PORTAL_BLUE_LEFT | PORTAL_ORANGE_RIGHT

	
	(* TODO: replace unit with the datatype/type synonym(s) you decide upon *)
	type 'a mutable_list = unit
	


	fun construct_empty() : 'a mutable_list = 
		raise Fail "NotYetImplemented"
	
	fun length(mlist : 'a mutable_list) : int = 
		raise Fail "NotYetImplemented"

	fun clear(mlist : 'a mutable_list) : unit =
		raise Fail "NotYetImplemented"

	

	fun add_to_front(mlist : 'a mutable_list, value : 'a) : unit =
		raise Fail "NotYetImplemented"

	

	fun add_to_back(mlist : 'a mutable_list, value : 'a) : unit =
		raise Fail "NotYetImplemented"

	fun contains(predicate : ('a -> bool), mlist : 'a mutable_list) : bool =
		raise Fail "NotYetImplemented"

	(* raise Subscript if index is out of bounds *)
	fun nth(mlist : 'a mutable_list, index : int) : 'a = 
		raise Fail "NotYetImplemented"

	fun construct_from_immutable(values : 'a list) : 'a mutable_list = 
		raise Fail "NotYetImplemented"

	fun foldl(f : ('a * 'b -> 'b), init : 'b, mlist : 'a mutable_list) : 'b = 
		raise Fail "NotYetImplemented"

	fun to_immutable(mlist : 'a mutable_list) : 'a list = 
		raise Fail "NotYetImplemented"

	fun map(f : ('a -> 'b), mlist : 'a mutable_list) : 'b mutable_list =
		raise Fail "NotYetImplemented"

	fun copy(mlist : 'a mutable_list) : 'a mutable_list =
		raise Fail "NotYetImplemented"

	fun a @ b = 
		raise Fail "NotYetImplemented"

	fun reverse(mlist : 'a mutable_list) : unit =
		raise Fail "NotYetImplemented"

	

	fun remove_arbitrary(mlist : 'a mutable_list) : 'a option =
		raise Fail "NotYetImplemented"


	fun construct_with_parrot(parrot) : parrot mutable_list =
		raise Fail "NotYetImplemented"
		
end