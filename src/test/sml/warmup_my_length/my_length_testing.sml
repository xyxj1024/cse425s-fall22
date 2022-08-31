(* Dennis Cosgrove *)

structure MyLengthTesting : sig
	val test_my_length : unit -> unit
end = struct
    open MyLength

    fun assert_my_length to_list_string (expected, xs) = 
        IntTesting.assertEvalEqualsWithMessage(
            expected, 
            fn() => my_length(xs), 
            "my_length(" ^ to_list_string(xs) ^ ")"
        )

    val assert_my_length_ints = assert_my_length IntTesting.toStringFromList
    val assert_my_length_strings = assert_my_length StringTesting.toStringFromList

    fun test_my_length() =
        ( UnitTesting.enter("my_length")
            ; assert_my_length_ints(0, [])
            ; assert_my_length_ints(1, [425])
            ; assert_my_length_ints(2, [425, 231])
            ; assert_my_length_strings(2, ["PL", "Parallel"])
            ; assert_my_length_strings(7, ["A", "B", "C", "D", "E", "F", "G"])
        ; UnitTesting.leave() )
end
