(* Binary search tree with mutable storage - October 7, 2022 *)
(* Xingjian Xuanyuan *)
(* Dennis Cosgrove *)

structure BinarySearchTree :> BINARY_SEARCH_TREE = struct

    type 'k compare_function = (('k * 'k) -> order)
	type ('e,'k) to_key_function = 'e -> 'k

    datatype 'e node = Nil | Sub of 'e * ('e node ref) * ('e node ref)
    type ('e,'k) tree = ('e node ref * 
                         'k compare_function * ('e,'k) to_key_function) ref

    fun create_empty(cmp : 'k compare_function, to_key : ('e,'k) to_key_function) : ('e,'k) tree =
		ref (ref Nil, cmp, to_key)

	fun create_empty_simple(cmp : 'k compare_function) : ('k, 'k) tree =
		ref (ref Nil, cmp, (fn(v)=>v))

	(* Returns x if x equals y *)
	fun max(x, y) = if x < y then y else x;

	(* ('e, 'k) tree -> int *)
	fun height(bst) =
		let
			val (ref root, cmp, to_key) = !bst
		in
			case root of
				Nil => 0
			  | Sub(element, left_child, right_child) =>
				1 + max(height(ref (left_child, cmp, to_key)), height(ref (right_child, cmp, to_key)))
		end

	(* 'e node -> int *)
	fun height_simple(Nil) = 0
	  | height_simple(Sub (element, ref left_child, ref right_child)) =
		1 + max(height_simple(left_child), height_simple(right_child))

	(* ('e, 'k) tree -> int *)
	fun count_internal(bst) =
		let
			val (ref root, cmp, to_key) = !bst
		in
			case root of
				Nil => 0
			  | Sub(element, ref left_child, ref right_child) =>
				case (left_child, right_child) of
					(Nil, Nil) => 0
				  | (left, Nil) => 1 + count_internal(ref (ref left, cmp, to_key))
				  | (Nil, right) => 1 + count_internal(ref (ref right, cmp, to_key))
				  | (left, right) =>
					count_internal(ref (ref left, cmp, to_key)) + 1 + 
					count_internal(ref (ref right, cmp, to_key))
		end

end (* struct *)