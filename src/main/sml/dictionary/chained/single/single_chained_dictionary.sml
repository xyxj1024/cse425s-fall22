(* Xingjian Xuanyuan *)

structure SingleChainedDictionary = DictionaryFn(struct
    
  (* TODO: replace unit with the type you decide upon *)
  datatype (''k,'v) Record = Empty | Cons of ''k * 'v * (''k,'v) Record
  type (''k,'v) dictionary = (''k,'v) Record
    
  (* accepts no parameters *)
  type ''k create_parameter_type = unit
  
  (* Creates an empty immutable Dictionary *)
  fun create() : (''k,'v) dictionary = Empty

  (* Behaves much like java.util.Map<K, V>'s get() *)
  fun get(dict : (''k,'v) dictionary, key : ''k) : 'v option =
    case dict of
      Empty => NONE
    | Cons (this_key, this_val, next_rec) =>
        if this_key = key
        then SOME this_val
        else get(next_rec, key)

  fun put(dict : (''k,'v) dictionary, key : ''k , value : 'v) : (''k,'v) dictionary * 'v option =
    let
      val ret = ref NONE
      fun put_helper(d, k, v) =
        case d of
          Empty => Cons (k, v, d)
        | Cons (this_key, this_val, next_rec) =>
            case k = this_key of
              false => 
                Cons (this_key, this_val, put_helper(next_rec, k, v))
            | true => 
                (ret := SOME this_val; Cons (this_key, v, next_rec))
    in
      (put_helper(dict, key, value), !ret)
    end
	
    fun remove(dict : (''k,'v) dictionary, key : ''k) : (''k,'v) dictionary * 'v option =
      let
        val ret = ref NONE
        fun remove_helper(d, k) =
          case d of
            Empty => Empty
          | Cons (this_key, this_val, next_rec) =>
              case k = this_key of
                false => Cons (this_key, this_val, remove_helper(next_rec, k))
              | true => (ret := SOME this_val; remove_helper(next_rec, k))
      in
        (remove_helper(dict, key), !ret)
      end

    fun entries(dict : (''k,'v) dictionary) : (''k*'v) list =
      case dict of
        Empty => []
      | Cons (this_key, this_val, next_rec) =>
          (this_key, this_val)::entries(next_rec)
end)