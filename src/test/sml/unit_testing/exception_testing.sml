structure ExceptionTesting : sig
    val assertRaisesExceptionWithMessage : (unit -> 'a) * exn * string -> unit 
    val assertRaisesException : (unit -> 'a) * exn -> unit 
end = struct
    fun assert_raises_exception(zero_arg_function : unit -> 'a, expected_exception : exn, message_option : string option) : unit =
        let
            val expected_exception_name = exnName(expected_exception)
        in
            ( zero_arg_function()
            ; UnitTesting.on_failure(message_option, "exception " ^ expected_exception_name ^ " raised.", "no exception raised.") )
            handle raised_exception => 
                if exnName(raised_exception)=expected_exception_name
                then UnitTesting.on_success(message_option, "as expected, " ^ expected_exception_name ^ " raised.")
                else 
                    if exnName(raised_exception)="AssertionFailure"
                    then raise raised_exception
                    else UnitTesting.on_failure(message_option, "exception " ^ expected_exception_name ^ " raised.", "exception " ^ exnName(raised_exception) ^ " raised.")
        end

    fun assertRaisesExceptionWithMessage(zero_arg_function, expected_exception, message) = 
        assert_raises_exception(zero_arg_function, expected_exception, SOME(message))

    fun assertRaisesException(zero_arg_function, expected_exception) = 
        assert_raises_exception(zero_arg_function, expected_exception, NONE)
end