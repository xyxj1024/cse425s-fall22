(* Dennis Cosgrove *)

signature DICTIONARY_FUNCTOR_PARAMETER = sig
    type (''k,'v) dictionary
    type ''k create_parameter_type
    val create : ''k create_parameter_type -> (''k,'v) dictionary
    val get : ((''k,'v) dictionary *''k) -> 'v option
    val put : ((''k,'v) dictionary *''k *'v) -> (''k,'v) dictionary * 'v option
    val remove : ((''k,'v) dictionary *''k) -> (''k,'v) dictionary * 'v option
    val entries : (''k,'v) dictionary -> (''k*'v) list
end
