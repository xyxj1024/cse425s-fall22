(* AVL tree - October 7, 2022 *)
(* Xingjian Xuanyuan *)
(* Dennis Cosgrove *)

structure BinarySearchTree :> BINARY_SEARCH_TREE = struct

    type 'k compare_function = (('k * 'k) -> order)
	type ('e,'k) to_key_function = 'e -> 'k

    datatype 'e node = Nil | Sub of 'e * ('e node) * ('e node)
    type ('e,'k) tree = ('e node * 
                         'k compare_function * ('e,'k) to_key_function)

    fun create_empty(cmp : 'k compare_function, to_key : ('e,'k) to_key_function) : ('e,'k) tree =
		(Nil, cmp, to_key)

	fun create_empty_simple(cmp : 'k compare_function) : ('k, 'k) tree =
		(Nil, cmp, (fn(v)=>v))

	(* Returns x if x equals y *)
	fun max(x, y) = if x < y then y else x;

	(* 'e node -> int *)
	fun height_simple(Nil) = 0
	  | height_simple(Sub (element, left_child, right_child)) =
		1 + max(height_simple(left_child), height_simple(right_child));

	(* Returns tree height *)
	fun height(bst : ('e, 'k) tree) : int =
		let
			val (root, _, _) = bst
		in
			height_simple(root)
		end

	(* Returns the number of internal nodes *)
	fun count_internal(root : 'e node) : int =
		case root of
			Nil => 0
		  | Sub (_, left_child, right_child) =>
				case (left_child, right_child) of
					(Nil, Nil) => 0
				  | (left, Nil) => 1 + count_internal(left)
				  | (Nil, right) => 1 + count_internal(right)
				  | (left, right) =>
					   (count_internal(left) + 1 + 
						count_internal(right));
		end
	
	(* Returns true if bst is balanced; false, otherwise *)
	fun is_balanced(bst : ('e, 'k) tree) : bool =
		let
			val (root, _, _) = bst
			fun is_balanced_helper(n : 'e node) : bool =
				case n of
					Nil => true
				  | Sub (this_val, left_child, right_child) =>
				        (is_balanced_helper(left_child)) andalso
						(is_balanced_helper(right_child)) andalso
						(abs(height_simple(left_child) - height_simple(right_child)) <= 1)
		in
			is_balanced_helper(root)
		end

	fun rotate_left( Sub (val, left_sub, (Sub (right_val, right_sub_left, right_sub_right))) ) =
		Sub (right_val, (Sub (val, left_sub, right_sub_left)), right_sub_right);
	
	fun rotate_right( Sub (val, (Sub (left_val, left_sub_left, left_sub_right)), right_sub) ) =
		Sub (left_val, left_sub_left, (Sub (val, left_sub_right, right_sub)));
	
	(* First rotate_left then rotate_right *)
	fun rotate_left_right( Sub (v, (Sub (lv, ll, (Sub (lrv, lrl, lrr)))), r) ) =
		Sub (lrv, (Sub (lv, ll, lrl)), (Sub (v, lrr, r)));
	
	(* First rotate_right then rotate_left *)
	fun rotate_right_left( Sub (v, l, (Sub (rv, (Sub (rlv, rll, rlr)), rr))) ) =
		Sub (rlv, (Sub (v, l, rll)), (Sub (rv, rlr, rr)));
	
	fun insert(t : ('e,'k) tree, element : 'e) : (('e,'k) tree * 'e option) =
		let
			val (root, cmp, to_key) = t
			val ret = ref NONE
			fun insert_helper(n : 'e node) : 'e node =
				case n of
					Nil => Sub (element, Nil, Nil)
				  | Sub (this_val, left_child, right_child) =>
				        case cmp(to_key(element), to_key(this_val)) of
						    GREATER =>
								let
									val new_right as Sub (new_right_val, _, _) = insert_helper(right_child)
									val new_tree = Sub (this_val, left_child, new_right)
								in
									if height_simple (new_right) - height_simple(left_child) = 2
									then
										if element > new_right_val
										then rotate_left(new_tree)
										else rotate_right_left(new_tree)
									else new_tree
								end
						  | LESS =>
						  		let
									val new_left as Sub (new_left_val, _, _) = insert(left_child)
									val new_tree = Sub (this_val, new_left, right_child)
								in
									if height_simple (new_left) - height_simple(right_child) = 2
									then
										if element < new_left_val
										then rotate_right(new_tree)
										else rotate_left_right(new_tree)
									else new_tree
								end
						  | EQUAL => 
							   (ret := SOME element;
								Sub (this_val, left_child, right_child))
		in
			((insert_helper(root), cmp, to_key), !ret)
		end
	
	fun balance_left_right(root as Sub (_, Sub (_, left_sub_left, left_sub_right), _)) =
    	if height_simple(left_sub_left) >= height_simple(left_sub_right) 
        then rotate_right(root)
        else rotate_left_right(root);
	
	fun balance_right_left(root as Sub (_, _, Sub (_, right_sub_left, right_sub_right))) =
        if height_simple(right_sub_right) >= height_simple(right_sub_left) 
        then rotate_left(root)
        else rotate_right_left(root);

end (* struct *)