(* Red-Black Tree (Self-Balanced BST) - October 8, 2022 *)
(* Xingjian Xuanyuan *)
(* Dennis Cosgrove *)

functor RedBlackTree () = struct
	
	type 'k compare_function = (('k * 'k) -> order)
	type ('e,'k) to_key_function = 'e -> 'k

  (* A node taking the form of Sub (Black, element, Nil, Nil) 
   * is called a sentinel node (i.e., leaf). *)
  datatype color = Red | Black
	datatype 'e node = Nil | Sub of color * 'e * ('e node) * ('e node)
	type ('e,'k) tree = ('e node * 
                       'k compare_function * 
                       ('e,'k) to_key_function)

	fun create_empty(cmp : 'k compare_function, to_key : ('e,'k) to_key_function) : ('e,'k) tree =
    (Nil, cmp, to_key)

	fun find(t : ('e,'k) tree, key : 'k) : 'e option =
    let
      val (root, cmp, to_key) = t
      fun find_helper(n : 'e node) : 'e option =
        case n of
          Nil => NONE
        | Sub (_, this_val, left_child, right_child) =>
            case cmp(key, to_key(this_val)) of
              GREATER => find_helper(right_child)
            | LESS => find_helper(left_child)
            | EQUAL => SOME this_val
    in
      find_helper(root)
    end

	fun insert(t : ('e,'k) tree, element : 'e) : (('e,'k) tree * 'e option) =
		raise Fail("NotYetImplemented")

	fun remove(t : ('e,'k) tree, key : 'k) : (('e,'k) tree * 'e option) =
		raise Fail("NotYetImplemented")

	fun fold_lnr(f, init, t) = 
		raise Fail("NotYetImplemented")
	
	fun fold_rnl(f, init, t) = 
		raise Fail("NotYetImplemented")

	fun debug_message(element_to_string : 'e -> string, t : ('e,'k) tree) : string =
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
