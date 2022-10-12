(* __STUDENT_NAME__ *)

functor DictionaryFn(DictionaryParameter : DICTIONARY_FUNCTOR_PARAMETER) : DICTIONARY = struct

	open DictionaryParameter

    fun keys(dict : (''k,'v) dictionary) : ''k list = 
        raise Fail "NotYetImplemented"

    fun values(dict : (''k,'v) dictionary) : 'v list = 
        raise Fail "NotYetImplemented"
end