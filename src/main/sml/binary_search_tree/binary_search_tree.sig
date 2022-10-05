(* Dennis Cosgrove *)

signature BINARY_SEARCH_TREE = sig
    type 'k compare_function = (('k * 'k) -> order)
    type ('e,'k) to_key_function = 'e -> 'k

    type ('e,'k) tree;

    val create_empty : ('k compare_function * ('e,'k) to_key_function) -> ('e,'k) tree

    val find : (('e,'k) tree * 'k) -> 'e option
    val insert : (('e,'k) tree * 'e) -> (('e,'k) tree * 'e option)
    val remove : (('e,'k) tree * 'k) -> (('e,'k) tree * 'e option)

    val fold_lnr : ((('e * 'b) -> 'b) * ('b) * (('e,'k) tree)) -> 'b 
    val fold_rnl : ((('e * 'b) -> 'b) * ('b) * (('e,'k) tree)) -> 'b 
    
    val debug_message : (('e -> string) * (('e,'k) tree)) -> string
    val to_graphviz_dot : (('e -> string) * ('k -> string) * (('e,'k) tree)) -> string
end
