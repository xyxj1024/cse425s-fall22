(* AVL tree (Self-Balanced BST) - October 7, 2022 *)
(* Xingjian Xuanyuan *)
(* Dennis Cosgrove *)

functor AVLTree () = struct

  type 'k compare_function = (('k * 'k) -> order)
	type ('e,'k) to_key_function = 'e -> 'k

	(* A non-empty AVL tree node takes the form of
	 * Sub (height, element, left_child, right_child) *)
	type height = int
    datatype 'e node = Nil | Sub of height * 'e * ('e node) * ('e node)
    type ('e,'k) tree = ('e node * 
                         'k compare_function * 
						             ('e,'k) to_key_function)

  fun create_empty(cmp : 'k compare_function, to_key : ('e,'k) to_key_function) : ('e,'k) tree =
		(Nil, cmp, to_key)

	fun create_empty_simple(cmp : 'k compare_function) : ('k, 'k) tree =
		(Nil, cmp, (fn(v)=>v))

	(* Returns x if x equals y *)
	fun max(x, y) = if x < y then y else x;

	(* Given a sub-tree's root, returns its height *)
	fun height_node(Nil) = 0
	  | height_node(Sub (h, _, _, _)) = h;

	(* Returns tree height *)
	fun height_tree(bst as (root, _, _)) = height_node(root);

	(* Given a sub-tree's root, returns the number of internal nodes *)
	fun count_internal(root : 'e node) : int =
		case root of
			Nil => 0
		| Sub (_, _, left_child, right_child) =>
				case (left_child, right_child) of
					(Nil, Nil) => 0
				| (left, Nil) => 1 + count_internal(left)
				| (Nil, right) => 1 + count_internal(right)
				| (left, right) =>
					  (count_internal(left) + 1 + 
						 count_internal(right))
	
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
	
	fun is_balanced_node(n : 'e node) : bool =
		case n of
			Nil => true
		| Sub (_, this_val, left_child, right_child) =>
				(is_balanced_node(left_child)) andalso
				(is_balanced_node(right_child)) andalso
				(abs(height_node(left_child) - height_node(right_child)) <= 1)

	(* Returns true if bst is balanced; false, otherwise *)
	fun is_balanced_tree(bst as (root, _, _) : ('e, 'k) tree) : bool =
		is_balanced_node(root);

	fun balance_factor(Nil) = 0
	  | balance_factor(Sub (_, _, ls, rs)) = height_node(ls) - height_node(rs);
	
	(* Creates a new sub-tree with new height *)
	fun new_root_node(element : 'e, left_sub : 'e node, right_sub : 'e node) : 'e node =
		let 
			val new_height = 1 + max(height_node(left_sub), height_node(right_sub))
		in 
			Sub (new_height, element, left_sub, right_sub)
		end

	fun rotate_left(n : 'e node) : 'e node =
		case n of
			Sub (_, v, ls, Sub (_, rv, rls, rrs)) => 
				new_root_node(rv, new_root_node(v, ls, rls), rrs)
		| _ => n
	
	fun rotate_right(n : 'e node) : 'e node =
		case n of
			Sub (_, v, Sub (_, lv, lls, lrs), rs) => 
				new_root_node(lv, lls, new_root_node(v, lrs, rs))
		| _ => n
	
	fun balance(Nil) = Nil
	  | balance(n as Sub (height, this_val, left_child, right_child)) =
		    let
			    val n_balance_factor = balance_factor(n)
			    val l_balance_factor = balance_factor(left_child)
			    val r_balance_factor = balance_factor(right_child)
		    in
			    case (n_balance_factor, l_balance_factor, r_balance_factor) of
				    (2, ~1, _) =>
					  (* First rotate_left then rotate_right *)
					    rotate_right(new_root_node(this_val, rotate_left(left_child), right_child))
			    | (2, _, _) =>
			  		  rotate_right(n)
			    | (~2, _, 1) =>
			  		  (* First rotate_right then rotate_left *)
			  		  rotate_left(new_root_node(this_val, left_child, rotate_right(right_child)))
			    | (~2, _, _) =>
			  		  rotate_left(n)
			    | _ => n
		    end
	
	fun insert(t : ('e,'k) tree, element : 'e) : (('e,'k) tree * 'e option) =
		let
			val (root, cmp, to_key) = t
			val ret = ref NONE
			fun insert_helper(n : 'e node) : 'e node =
				case n of
					Nil => new_root_node(element, Nil, Nil)
				| Sub (height, this_val, left_child, right_child) =>
				    case cmp(to_key(element), to_key(this_val)) of
						  GREATER =>
								balance(new_root_node(this_val, left_child, insert_helper(right_child)))
						| LESS =>
						  	balance(new_root_node(this_val, insert_helper(left_child), right_child))
						| EQUAL => 
							  (ret := SOME element; n)
		in
			((insert_helper(root), cmp, to_key), !ret)
		end
	
	fun find_left(Nil) = (Nil, NONE)
    | find_left(n as Sub (_, right_sub_val, right_sub_left, right_sub_right))=
		    case right_sub_left of
			    Nil => (right_sub_right, SOME right_sub_val) (* Found the leftmost descendant *)
		    | _ =>
			      let
					    val (new_left, new_val_op) = find_left(right_sub_left)
				    in
					    (balance(new_root_node(right_sub_val, new_left, right_sub_right)), new_val_op)
				    end
	
	fun remove(t : ('e,'k) tree, key : 'k) : (('e,'k) tree * 'e option) =
		let
			val (root, cmp, to_key) = t
			val removed = ref NONE
			fun remove_helper(n : 'e node) : 'e node =
				case n of
					Nil => n
				| Sub (_, this_val, left_child, right_child) =>
					  case cmp(key, to_key(this_val)) of
						  GREATER =>
							  balance(new_root_node(this_val, left_child, remove_helper(right_child)))
						| LESS =>
						  	balance(new_root_node(this_val, remove_helper(left_child), right_child))
						| EQUAL =>
						   (removed := SOME this_val;
						    case (left_child, right_child) of
								  (_, Nil) => left_child
								| (Nil, _) => right_child
								| _ =>
									  let
											val (new_right, new_val_op) = find_left(right_child)
										in
											case new_val_op of
                        SOME new_val =>
                          balance(new_root_node(new_val, left_child, new_right))
                      | NONE => raise Fail "Remove Fail"
										end)
		in
			((remove_helper(root), cmp, to_key), !removed)
		end
	
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