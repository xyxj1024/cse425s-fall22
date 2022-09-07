structure CloseEnough : sig
    val distance : real * real -> real
    val relativeDistance : real * real -> real option
    val withinDelta : real * real * real -> bool
    val withinEpsilon : real * real * real -> bool
end = struct
    fun distance(a : real, b : real) : real = 
       	abs(a-b)
    fun relativeDistance(a : real, b : real) : real option = 
        if Real.compare(a, 0.0) = EQUAL
        then NONE
        else SOME(abs(1.0 - (b/a)))
    fun withinDelta(a : real, b : real, delta : real) : bool = 
       	distance(a, b) <= delta
    fun withinEpsilon(a : real, b : real, epsilon : real) : bool = 
        case relativeDistance(a, b) of
          NONE => Real.compare(a, b) = EQUAL
        | SOME(rd) => rd <= epsilon
end