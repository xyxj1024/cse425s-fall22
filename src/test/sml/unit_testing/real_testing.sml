structure RealTesting : sig include TO_STRING
    val assertEvalCloseEnoughWithMessage : real * (unit -> real) * real * string -> unit
    val assertEvalCloseEnough : real * (unit -> real) * real -> unit
    val assertCloseEnoughWithMessage : real * real * real * string -> unit
    val assertCloseEnough : real * real * real -> unit


    val assertEvalCloseEnoughRelativeWithMessage : real * (unit -> real) * real * string -> unit
    val assertEvalCloseEnoughRelative : real * (unit -> real) * real -> unit

    val assertCloseEnoughRelativeWithMessage : real * real * real * string -> unit
    val assertCloseEnoughRelative : real * real * real -> unit

end = struct

    structure RealToString = ToStringFn(struct
        type t = real
        val toString = Real.toString
    end)

    open RealToString

    fun assert_eval_within_delta( expected : real, thunk : unit -> real, delta : real, message_option : string option) = 
		let
			val actual = (thunk()) handle e => (UnitTesting.on_exception(message_option, Real.toString(expected), e); raise e)
            val success = CloseEnough.withinDelta(expected, actual, delta)
		in
            if success
            then UnitTesting.on_success( message_option, "as expected, close enough: " ^ Real.toString(expected))
            else UnitTesting.on_delta_failure( message_option, expected, actual, delta )
		end

    fun assertEvalCloseEnoughWithMessage( expected : real, thunk : unit -> real, delta : real, message : string ) = 
        assert_eval_within_delta(expected, thunk, delta, SOME(message))

    fun assertEvalCloseEnough( expected : real, thunk : unit -> real, delta : real ) = 
        assert_eval_within_delta(expected, thunk, delta, NONE)

    fun assert_within_delta( expected : real, actual : real, delta : real, message_option : string option) = 
        assert_eval_within_delta(expected, fn()=>actual, delta, message_option)

    fun assertCloseEnoughWithMessage( expected : real, actual : real, delta : real, message : string ) = 
        assert_within_delta(expected, actual, delta, SOME(message))

    fun assertCloseEnough( expected : real, actual : real, delta : real ) = 
        assert_within_delta(expected, actual, delta, NONE)

    fun assert_eval_within_epsilon( expected : real, thunk : unit -> real, epsilon : real, message_option : string option) = 
        let
            val actual = (thunk()) handle e => (UnitTesting.on_exception(message_option, Real.toString(expected), e); raise e)
            val success = 
                if Real.compare(expected, 0.0) = EQUAL
                then Real.compare(expected, actual) = EQUAL
                else CloseEnough.withinEpsilon(expected, actual, epsilon)
        in
            if success
            then UnitTesting.on_success(message_option, "as expected, close enough (relatively): " ^ Real.toString(expected))
            else UnitTesting.on_epsilon_failure( message_option, expected, actual, epsilon )
        end

    fun assertEvalCloseEnoughRelativeWithMessage( expected : real, thunk : unit -> real, epsilon : real, message : string ) = 
        assert_eval_within_epsilon(expected, thunk, epsilon, SOME(message))

    fun assertEvalCloseEnoughRelative( expected : real, thunk : unit -> real, epsilon : real ) = 
        assert_eval_within_epsilon(expected, thunk, epsilon, NONE)

    fun assert_within_epsilon( expected : real, actual : real, epsilon : real, message_option : string option) = 
        assert_eval_within_epsilon(expected, fn()=>actual, epsilon, message_option)

    fun assertCloseEnoughRelativeWithMessage( expected : real, actual : real, epsilon : real, message : string ) = 
        assert_within_epsilon(expected, actual, epsilon, SOME(message))

    fun assertCloseEnoughRelative( expected : real, actual : real, epsilon : real ) = 
        assert_within_epsilon(expected, actual, epsilon, NONE)
end