structure BoolTesting : sig include EQUALITY_TESTING
    val assertWithMessage : bool * bool * string -> unit
    val assertTrueWithMessage : bool * string -> unit
    val assertFalseWithMessage : bool * string -> unit

    val assertEvalWithMessage : bool * (unit -> bool) * string -> unit
    val assertEvalTrueWithMessage : (unit -> bool) * string -> unit
    val assertEvalFalseWithMessage : (unit -> bool) * string -> unit

    val assert : bool * bool -> unit
    val assertTrue : bool -> unit
    val assertFalse : bool -> unit
end = struct
    structure BoolEqualityTest = EqualityTestingFn (struct
        type t = bool
        fun toString(b) = if b then "true" else "false"
        fun compare(a,b) = Int.compare(if a then 1 else 0, if b then 1 else 0)
    end)

    open BoolEqualityTest

    (* fun assert_state(expected : bool, actual : bool, message_option : string option) =
        if expected = actual
        then UnitTesting.on_success(message_option, "as expected, " ^ Bool.toString(expected) ^ " is " ^ Bool.toString(actual))
        else UnitTesting.on_failure(message_option, Bool.toString(expected), Bool.toString(actual)) *)

    fun assert_eval_state(expected : bool, thunk : unit -> bool, message_option : string option) =
        let
            val actual = thunk() handle e => (UnitTesting.on_exception(message_option, Bool.toString(expected), e); raise e)
        in
            if expected = actual
            then UnitTesting.on_success(message_option, "as expected, " ^ Bool.toString(expected) ^ " is " ^ Bool.toString(actual))
            else UnitTesting.on_failure(message_option, Bool.toString(expected), Bool.toString(actual))
        end

    fun assertEvalWithMessage(expected : bool, thunk : unit -> bool, message : string) =
        assert_eval_state(expected, thunk, SOME(message))

    fun assertEvalTrueWithMessage(thunk : unit -> bool, message : string) =
		assertEvalWithMessage(true, thunk, message)

    fun assertEvalFalseWithMessage(thunk : unit -> bool, message : string) =
		assertEvalWithMessage(false, thunk, message)

    fun assertWithMessage(expected : bool, actual : bool, message : string) =
        assert_eval_state(expected, fn _ => actual, SOME(message))

    fun assertTrueWithMessage(actual : bool, message : string) =
		assertWithMessage(true, actual, message)

    fun assertFalseWithMessage(actual : bool, message : string) =
		assertWithMessage(false, actual, message)

    fun assert(expected : bool, actual : bool) =
        assert_eval_state(expected, fn _ => actual, NONE)

    fun assertTrue(actual : bool) =
        assert(true, actual)

    fun assertFalse(actual : bool) =
        assert(false, actual)
end