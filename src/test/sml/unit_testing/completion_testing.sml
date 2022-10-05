structure CompletionTesting : sig
    val assertEvalCompletionWithMessage : (unit -> 'a) * string -> 'a
    val assertEvalCompletionWithMessageAndExceptionNote : (unit -> 'a) * string * string -> 'a
end = struct
    fun assertEvalCompletionWithMessage(thunk : unit -> 'a, message : string ) = 
		let
			val message_option = SOME(message)
			val result = thunk() handle e => (UnitTesting.on_exception(message_option, "completion", e) ; raise e)
			val _ = UnitTesting.on_success(message_option, "exception not raised")
		in
			result
		end
    fun assertEvalCompletionWithMessageAndExceptionNote(thunk : unit -> 'a, message : string, exception_note : string ) = 
		let
			val message_option = SOME(message)
			val result = thunk() handle e => (UnitTesting.on_exception(SOME(message ^ "\n!!!                note: " ^ exception_note), "completion", e) ; raise e)
			val _ = UnitTesting.on_success(message_option, "exception not raised")
		in
			result
		end
end