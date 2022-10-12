(* Xingjian Xuanyuan *)

functor DictionaryFn(DictionaryParameter : DICTIONARY_FUNCTOR_PARAMETER) : DICTIONARY = struct

  open DictionaryParameter

  fun keys(dict : (''k,'v) dictionary) : ''k list =
    let
      fun keys_helper(ps) =
        case ps of
          [] => []
        | (this_key, _)::rest =>
            this_key::keys_helper(rest)
    in
      keys_helper(entries(dict))
    end

  fun values(dict : (''k,'v) dictionary) : 'v list =
    let
      fun vals_helper(ps) =
        case ps of
          [] => []
        | (_, this_val)::rest =>
            this_val::vals_helper(rest)
    in
      vals_helper(entries(dict))
    end
end