structure Chain : CHAIN = struct
    

    fun get(chain : (''k*'v) list, key:''k) : 'v option =
        raise Fail "NotYetImplemented"

    fun put(chain : (''k*'v) list, key:''k, value:'v) : (''k*'v) list * 'v option =
        raise Fail "NotYetImplemented"

    fun remove(chain : (''k*'v) list, key : ''k) : (''k*'v) list * 'v option =
        raise Fail "NotYetImplemented"
end