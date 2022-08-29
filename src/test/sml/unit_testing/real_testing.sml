structure RealTesting : sig include TO_STRING
    val assertWithinDeltaWithMessage : real * real * real * string -> unit
    val assertWithinDelta : real * real * real -> unit
    val assertWithinEpsilonWithMessage : real * real * real * string -> unit
    val assertWithinEpsilon : real * real * real -> unit
end = struct

    structure RealToString = ToStringFn(struct
        type t = real
        val toString = Real.toString
    end)

    open RealToString

    fun assert_within_delta( expected : real, actual : real, delta : real, message_option : string option) = 
        if abs(expected-actual)<=delta
        then UnitTesting.on_success(message_option, "as expected, within delta: " ^ Real.toString(actual))
        else UnitTesting.on_failure(message_option, Real.toString(expected), Real.toString(actual))

    fun assertWithinDeltaWithMessage( expected : real, actual : real, delta : real, message : string ) = 
        assert_within_delta(expected, actual, delta, SOME(message))

    fun assertWithinDelta( expected : real, actual : real, delta : real ) = 
        assert_within_delta(expected, actual, delta, NONE)

    fun assert_within_epsilon( expected : real, actual : real, epsilon : real, message_option : string option) = 
        raise Fail("TODO")

    fun assertWithinEpsilonWithMessage( expected : real, actual : real, epsilon : real, message : string ) = 
        assert_within_epsilon(expected, actual, epsilon, SOME(message))

    fun assertWithinEpsilon( expected : real, actual : real, epsilon : real ) = 
        assert_within_epsilon(expected, actual, epsilon, NONE)
end