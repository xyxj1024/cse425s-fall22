structure MutableList = struct
	(* Xingjian Xuanyuan *)
	(* Dennis Cosgrove *)

	datatype parrot = PARTY | SHUFFLE | PORTAL_BLUE_LEFT | PORTAL_ORANGE_RIGHT

	(* A mutable list implemented as a linked list with explicit references *)
	datatype 'a item = Nil
	                 | Cons of 'a * ('a item ref)
	
	(* A int ref is added to keep track of the length of the mutable list *)
	type 'a mutable_list = ('a item ref * int ref) ref

	(* Create an empty list node *)
	fun construct_empty() : 'a mutable_list = 
		ref (ref Nil, ref 0)
	
	fun length(mlist : 'a mutable_list) : int =
		let
			val (_, ref length) = !mlist
		in
			length
		end

	(* Let head of the list point to an empty node *)
	fun clear(mlist : 'a mutable_list) : unit =
		mlist := (ref Nil, ref 0)

	fun add_to_front(mlist : 'a mutable_list, value : 'a) : unit =
		let 
			val (ref_lst, ref_len) = !mlist
		in
			case !ref_lst of
				Nil =>
					(* If list empty, length equals one *)
					mlist := (ref (Cons(value, ref Nil)), ref 1)
		  	  | _ =>
			  		mlist := (ref (Cons(value, ref_lst)), ref (!ref_len + 1))
		end

	fun add_to_back(mlist : 'a mutable_list, value : 'a) : unit =
		let 
			val (ref_lst, ref_len) = !mlist
			(* 'a item ref * 'a -> 'a item ref *)
			fun add_to_back_helper(l, v) =
				case !l of
					Nil => ref (Cons(v, ref Nil))
		  	      | Cons(h, t) => ref (Cons(h, add_to_back_helper(t, v)))
		in
			mlist := (add_to_back_helper(ref_lst, value), ref (!ref_len + 1))
		end

	fun contains(predicate : ('a -> bool), mlist : 'a mutable_list) : bool =
		let 
			val (ref items, _) = !mlist;
			(* ('a -> bool) * 'a item -> bool *)
			fun contains_helper(p, l) =
				case l of
					Nil => false
		  	      | Cons(h, ref t) =>
					if p h
					then true
					else contains_helper(p, t)
		in
			contains_helper(predicate, items)
		end

	(* raise Subscript if index is out of bounds *)
	fun nth(mlist : 'a mutable_list, index : int) : 'a =
		let
			val (ref_lst, _) = !mlist;
			(* 'a item ref * int -> 'a *)
			fun nth_helper(l, i) =
				case !l of
					Nil => raise Subscript
		          | Cons(h, t) =>
					if i = 0
					then h
					else nth_helper(t, i - 1)
		in
			nth_helper(ref_lst, index)
		end

	fun construct_from_immutable(values : 'a list) : 'a mutable_list =
		let 
			(* 'a list -> 'a item *)
			fun construct_from_immutable_helper(imlist) =
				case imlist of
					[] => Nil
		          | h :: t =>
					Cons(h, ref (construct_from_immutable_helper(t)))
		in
			(* ('a item ref * int ref) ref *)
			ref (ref (construct_from_immutable_helper(values)), 
			     ref (List.length(values)))
		end

	fun foldl(f : ('a * 'b -> 'b), init : 'b, mlist : 'a mutable_list) : 'b =
		let
			val (ref_lst, _) = !mlist
			fun foldl_helper(f, i, l) =
				case !l of
					Nil => i
		  		  | Cons(h, t) => foldl_helper(f, (f(h, i)), t)
		in
			foldl_helper(f, init, ref_lst)
		end

	fun to_immutable(mlist : 'a mutable_list) : 'a list =
		let
			val (ref_lst, _) = !mlist
			(* 'a item ref -> 'a list *)
			fun to_immutable_helper(l) =
				case !l of
					Nil => []
		  		  | Cons(h, t) => h :: to_immutable_helper(t)
		in
			to_immutable_helper(ref_lst)
		end

	fun map(f : ('a -> 'b), mlist : 'a mutable_list) : 'b mutable_list =
		let
			val (ref_lst, ref_len) = !mlist
			(* ('a -> 'b) * 'a item -> 'b item *)
			fun map_helper(f, l) =
				case !l of
					Nil => Nil
		    	  | Cons(h, t) => Cons(f(h), ref (map_helper(f, t)))
		in
			ref (ref (map_helper(f, ref_lst)), ref_len)
		end

	fun copy(mlist : 'a mutable_list) : 'a mutable_list =
		let
			val (ref_lst, ref_len) = !mlist;
			(* 'a item ref -> 'a item *)
			fun copy_helper(l) =
				case !l of
					Nil => Nil
		  		  | Cons(h, t) => Cons(h, ref (copy_helper(t)))
		in
			ref (ref (copy_helper(ref_lst)), ref_len)
		end

	fun a @ b =
		let
			val (ref_lst_a, ref_len_a) = !a
			and (ref_lst_b, ref_len_b) = !b;
			(* 'a item ref * 'a item ref -> 'a item ref *)
			fun concat_helper(l_a, l_b) =
				case !l_a of
					Nil => l_b
		  		  | Cons(h, t) => ref (Cons(h, concat_helper(t, l_b)))
		in
			ref (concat_helper(ref_lst_a, ref_lst_b), 
			     ref (!ref_len_a + !ref_len_b))
		end

	fun reverse(mlist : 'a mutable_list) : unit =
		let
			val (ref_lst, ref_len) = !mlist
			(* 'a item ref * 'a item ref -> 'a item ref *)
			fun reverse_helper(l, acc) =
				case !l of
					Nil => acc
			      | Cons(h, t) => reverse_helper(t, ref (Cons(h, acc)))
		in 
			mlist := (reverse_helper(ref_lst, ref Nil), ref_len)
		end


	(* ('a item ref, int ref) ref -> int 
	   A random number generator *)
	fun rand_idx(mlist : 'a mutable_list) : int =
		let 
			val last = length(mlist) - 1
		in
			if last - 1 <= 0
			then 0
			else
				let
					val seed = Random.rand(425, 2022)
					and range = (0, last)
				in
					Random.randRange range seed
				end
		end

	fun do_remove_arbitrary(mlist : 'a mutable_list) : ('a mutable_list * 'a option ref) =
		let
			val (ref_lst, ref_len) = !mlist
			val res = ref NONE
			(* 'a item ref * int -> 'a item ref *)
			fun remove_helper(l, i) = 
				case !l of
					Nil	=> ref Nil
		         | Cons(h, t) =>
					if i = 0
					then (res := SOME h; t)
					else ref (Cons(h, remove_helper(t, i - 1)))
		in
			(ref (remove_helper(ref_lst, rand_idx(mlist)), ref_len), res)
		end
	
	fun remove_arbitrary(mlist : 'a mutable_list) : 'a option =
		let
			(* ('a item ref * int) -> 'a option ref *)
			(* fun locate_helper(l, i) =
				case !l of
					Nil => NONE
				  | Cons(h, t) =>
						case i of
							0 => SOME h
						  | i => locate_helper(t, i - 1) *)
			val (updated_list, removed_val) = do_remove_arbitrary(mlist)
		in
			(mlist := !updated_list; !removed_val)
		end

	fun construct_with_parrot(parrot) : parrot mutable_list =
		ref (ref (Cons(parrot, ref Nil)), ref 1)
		
end