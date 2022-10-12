(* Dennis Cosgrove *)

signature DICTIONARY = sig include DICTIONARY_FUNCTOR_PARAMETER
    val keys : (''k,'v) dictionary -> ''k list
    val values : (''k,'v) dictionary -> 'v list
end
