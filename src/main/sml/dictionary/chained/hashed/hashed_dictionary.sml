(* __STUDENT_NAME__ *)
structure HashedDictionary = DictionaryFn(struct
	type ''k hash_function = ''k -> int

	
	(* TODO: replace unit with the type you decide upon *)
	type (''k,'v) dictionary = unit
	

    type ''k create_parameter_type = (int * (''k hash_function))

    fun create(bucket_count_request : int, hash : ''k hash_function) : (''k,'v) dictionary = 
        raise Fail "NotYetImplemented"

	fun positive_remainder(v : int, n : int) : int = 
		let
			val result = v mod n 
		in 
			if result >= 0 then result else result+n
		end 

	

    fun get(dict : (''k,'v) dictionary, key : ''k) : 'v option = 
        raise Fail "NotYetImplemented"

    fun put(dict : (''k,'v) dictionary, key : ''k , value : 'v) : (''k,'v) dictionary * 'v option =
        raise Fail "NotYetImplemented"

    fun remove(dict : (''k,'v) dictionary, key : ''k) : (''k,'v) dictionary * 'v option =
		raise Fail "NotYetImplemented"

	fun entries(dict : (''k,'v) dictionary) : (''k*'v) list =
		raise Fail "NotYetImplemented"

end)