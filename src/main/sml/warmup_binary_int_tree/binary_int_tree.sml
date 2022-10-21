(* __STUDENT_NAME__ *)
(* Dennis Cosgrove *)

structure BinaryIntTree = struct
	datatype int_tree = NODE of (int_tree * int * int_tree) | EMPTY

	fun sum(node : int_tree) : int = 
		 raise Fail("NotYetImplemented")

	fun sum_accumulate(init : int, node : int_tree) : int = 
		 raise Fail("NotYetImplemented")

	(*
	 * depth-first, reverse in-order traversal
	 * https://en.wikipedia.org/wiki/Tree_traversal#Reverse_in-order,_RNL
	 *)
	fun fold_rnl(f : (int * 'a) -> 'a, init : 'a, node : int_tree) : 'a = 
		 raise Fail("NotYetImplemented")

end (* struct *) 