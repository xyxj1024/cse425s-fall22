(* Dennis Cosgrove *)
signature IS_STRICTLY_ASCENDING_TESTING_FN = sig
    val test_is_strictly_ascending : unit -> unit
end

signature IS_STRICTLY_ASCENDING_TESTING_PARAMETER = sig
    val function : int list -> bool
    val function_name : string
end

functor IsStrictlyAscendingTestingFn (IsStrictlyAscendingTestingParameter : IS_STRICTLY_ASCENDING_TESTING_PARAMETER) : IS_STRICTLY_ASCENDING_TESTING_FN = struct
    open IsStrictlyAscendingTestingParameter

    fun test_is_strictly_ascending() =
        let
            fun to_message(xs) = 
                function_name ^ "(" ^ IntTesting.toStringFromList(xs) ^ ")"
            fun assert_true(xs : int list) : unit =
                BoolTesting.assertEvalTrueWithMessage(fn() => function(xs), to_message(xs))
            fun assert_false(xs : int list) : unit =
                BoolTesting.assertEvalFalseWithMessage(fn() => function(xs), to_message(xs))
        in
            ( UnitTesting.enter(function_name)
            ; assert_true([])
            ; assert_true([231])
            ; assert_true([425])
            ; assert_true([1, 2])
            ; assert_false([1, 1])
            ; assert_false([2, 1])
            ; assert_true([231, 425])
            ; assert_false([425, 231])
            ; assert_true([1, 2, 3])
            ; assert_false([1, 1, 3])
            ; assert_false([1, 2, 2])
            ; assert_false([1, 1, 1])
            ; assert_false([2, 1, 3])
            ; assert_false([1, 3, 2])
            ; assert_false([2, 2, 1])
            ; assert_false([2, 1, 1])
            ; assert_false([425, 425, 425, 425])
            ; assert_false([231, 425, 425, 425])
            ; assert_false([231, 231, 425, 425])
            ; assert_false([231, 231, 231, 425])
            ; assert_false([425, 231, 425, 425])
            ; assert_false([425, 425, 231, 425])
            ; assert_false([425, 425, 425, 231])
            ; assert_true([1, 2, 3, 4, 5])
            ; assert_false([5, 4, 3, 2, 1])
            ; assert_false([1, 2, 3, 4, 5, 4, 3, 2, 1])
            ; UnitTesting.leave() )
        end
end
