(* Xingjian Xuanyuan *)

structure SortedDictionary = DictionaryFn(struct
  type ''k compare_function = (''k * ''k) -> order

  datatype (''k, 'v) node = Nil | Sub of (''k * 'v) * ((''k, 'v) node) * ((''k, 'v) node)
  type (''k, 'v) dictionary = ((''k, 'v) node * ''k compare_function)

  type ''k create_parameter_type = ''k compare_function

  fun create(cmp : ''k compare_function) : (''k, 'v) dictionary =
    (Nil, cmp)

  fun get(dict : (''k, 'v) dictionary, key:''k) : 'v option =
    let
			val (root, cmp) = dict
			fun get_helper(n : (''k, 'v) node) : 'v option =
			  case n of
					Nil => NONE
				| Sub ((this_key, this_val), left_child, right_child) =>
					  case cmp(key, this_key) of
					    GREATER => get_helper(right_child)
				    | LESS => get_helper(left_child)
				    | EQUAL => SOME this_val
		in
			get_helper(root)
		end

  fun put(dict : (''k, 'v) dictionary, key:''k, value:'v) : (''k, 'v) dictionary * 'v option =
		let
			val (root, cmp) = dict
			val ret = ref NONE
			fun put_helper(n : (''k, 'v) node) : (''k, 'v) node =
				case n of
					Nil => Sub ((key, value), Nil, Nil)
				| Sub ((this_key, this_val), left_child, right_child) =>
					  case cmp(key, this_key) of
						  GREATER => Sub ((this_key, this_val), left_child, put_helper(right_child))
				    | LESS => Sub((this_key, this_val), put_helper(left_child), right_child)
				    | EQUAL => (ret := SOME this_val;
					  			      Sub((key, value), left_child, right_child))
		in
			((put_helper(root), cmp), !ret)
		end

  fun remove(dict : (''k, 'v) dictionary, key : ''k) : (''k, 'v) dictionary * 'v option =
		let
			val (root, cmp) = dict
			val removed = ref NONE
			fun remove_helper(n : (''k, 'v) node) : (''k, 'v) node =
				case n of
					Nil => n
				| Sub ((this_key, this_val), left_child, right_child) =>
					  case cmp(key, this_key) of
						  GREATER => Sub ((this_key, this_val), left_child, remove_helper(right_child))
				  	| LESS => Sub ((this_key, this_val), remove_helper(left_child), right_child)
				  	| EQUAL => (* Found the node to be removed *)
					   	 (removed := SOME this_val;
				  			case (left_child, right_child) of
								  (Nil, Nil) => Nil (* Clear the leaf *)
			  			  | (Nil, only_right) => only_right
			  			  | (only_left, Nil) => only_left
			  			  | _ =>
									  let
										  fun find_right(Sub ((left_sub_key, left_sub_val), left_sub_left, left_sub_right) : (''k, 'v) node) : (''k, 'v) node = 
											  case left_sub_right of
												  Nil => Sub ((left_sub_key, left_sub_val), left_sub_left, left_sub_right)
				  					    | _ =>
												    find_right(left_sub_right)
									  in 
										  let
											  (* Find the rightmost descendant of n's left sub-tree *)
											  val Sub ((new_key, new_val), new_left, new_right) = find_right(left_child)
                        fun remove_duplicate(n : (''k, 'v) node) : (''k, 'v) node =
		                      case n of
			                      Nil => Nil
		                      | Sub ((this_key, this_val), left_child, right_child) =>
			                        case right_child of
				                        Nil => left_child
			                        | Sub ((right_child_key, right_child_val), right_child_left, right_child_right) =>
			                            Sub ((this_key, this_val), left_child, remove_duplicate(right_child))
										  in
											  Sub ((new_key, new_val), remove_duplicate(left_child), right_child)
										  end
									  end)

		in
			((remove_helper(root), cmp), !removed)
		end

  fun entries(dict : (''k, 'v) dictionary) : (''k * 'v) list =
    let
      val (root, _) = dict
	    fun to_list_lnr(n : (''k, 'v) node) : (''k * 'v) list =
		    case n of
			    Nil => []
		    | Sub ((this_key, this_val), left_child, right_child) =>
			      to_list_lnr(left_child) @ [(this_key, this_val)] @ to_list_lnr(right_child)
    in
      to_list_lnr(root)
    end

end)