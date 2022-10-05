(* __STUDENT_NAME__ *)
(* Dennis Cosgrove *)

structure BinarySearchTree :> BINARY_SEARCH_TREE = struct
	type 'k compare_function = (('k * 'k) -> order)
	type ('e,'k) to_key_function = 'e -> 'k

	
	(* TODO: replace unit with the datatype(s) and/or type synonym(s) you decide upon *)
	type ('e,'k) tree = unit
	

	fun create_empty(cmp : 'k compare_function, to_key : ('e,'k) to_key_function) : ('e,'k) tree =
		 raise Fail("NotYetImplemented")

	fun find(t : ('e,'k) tree, key : 'k) : 'e option = 
			raise Fail("NotYetImplemented")

	fun insert(t : ('e,'k) tree, element : 'e) : (('e,'k) tree * 'e option) =
		 raise Fail("NotYetImplemented")

	fun remove(t : ('e,'k) tree, key : 'k) : (('e,'k) tree * 'e option) =
			raise Fail("NotYetImplemented")

	

	(*
	 * depth-first, in-order traversal
	 * https://en.wikipedia.org/wiki/Tree_traversal#In-order_(LNR)
	 *)
	fun fold_lnr(f, init, t) = 
			raise Fail("NotYetImplemented")

	(*
	 * depth-first, reverse in-order traversal
	 * https://en.wikipedia.org/wiki/Tree_traversal#Reverse_in-order_(RNL)
	 *)
	fun fold_rnl(f, init, t) = 
			raise Fail("NotYetImplemented")

	fun debug_message(element_to_string, t) =
			"(Optional) TODO: BinarySearchTree.debug_message"

	fun to_graphviz_dot(element_to_string, key_to_string, t) =
		let
			
			(* TODO: bind root *)
			val root = raise Fail("NotYetImplemented")
			(* TODO: bind to_key *)
			val to_key = raise Fail("NotYetImplemented")
			

			fun node_to_dot(element) =
				"\t" ^ key_to_string(to_key(element)) ^ " [label= \"{ " ^ element_to_string(element) ^ " | { <child_left> | <child_right> } }\"]"

			fun edge_to_dot(parent_element_opt, tag, element) = 
				case parent_element_opt of
				  NONE => ""
				| SOME(parent_element) => "\t" ^ key_to_string(to_key(parent_element)) ^ tag ^ " -> " ^ key_to_string(to_key(element))

			fun nodes_to_dot(bst) =
					raise Fail("NotYetImplemented")

			fun edges_to_dot(bst, parent_element_opt, tag) =
					raise Fail("NotYetImplemented")

		in
			"digraph g {\n\n\tnode [\n\t\tshape = record\n\t]\n\n\tedge [\n\t\ttailclip=false,\n\t\tarrowhead=vee,\n\t\tarrowtail=dot,\n\t\tdir=both\n\t]\n\n" ^ nodes_to_dot(root) ^ edges_to_dot(root, NONE, "") ^ "\n}\n"
		end

end (* struct *) 
