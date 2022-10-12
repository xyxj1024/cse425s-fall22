(* __STUDENT_NAME__ *)

structure SingleChainedDictionary = DictionaryFn(struct
    
    (* TODO: replace unit with the type you decide upon *)
    type (''k,'v) dictionary = unit
    

    type ''k create_parameter_type = unit
    
    fun create() : (''k,'v) dictionary = 
        raise Fail "NotYetImplemented"

    fun get(dict : (''k,'v) dictionary, key : ''k) : 'v option = 
        raise Fail "NotYetImplemented"

    fun put(dict : (''k,'v) dictionary, key : ''k , value : 'v) : (''k,'v) dictionary * 'v option =
        raise Fail "NotYetImplemented"
	
    fun remove(dict : (''k,'v) dictionary, key : ''k) : (''k,'v) dictionary * 'v option =
        raise Fail "NotYetImplemented"

    fun entries(dict : (''k,'v) dictionary) : (''k*'v) list =
        raise Fail "NotYetImplemented"
end)