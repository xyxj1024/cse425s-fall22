structure Chain : CHAIN = struct
    

  fun get(chain : (''k * 'v) list, key:''k) : 'v option =
    case chain of
      [] => NONE
    | (this_key, this_val)::rest =>
        if key = this_key
        then SOME this_val
        else get(rest, key)

  fun put(chain : (''k * 'v) list, key:''k, value:'v) : (''k * 'v) list * 'v option =
    let
      val ret = ref NONE
      fun put_chain_helper(ps, k, v) =
        case ps of
          [] => ps
        | (this_key, this_val)::rest =>
            if k = this_key
            then (ret := SOME this_val; (this_key, v)::rest)
            else (this_key, this_val)::put_chain_helper(rest, k, v)
    in
      (put_chain_helper(chain, key, value), !ret)
    end

  fun remove(chain : (''k * 'v) list, key : ''k) : (''k * 'v) list * 'v option =
    let
      val ret = ref NONE
      fun remove_chain_helper(ps, k) =
        case ps of
          [] => ps
        | (this_key, this_val)::rest =>
            if k = this_key
            then (ret := SOME this_val; rest)
            else (this_key, this_val)::remove_chain_helper(rest, k)
    in
      (remove_chain_helper(chain, key), !ret)
    end

end