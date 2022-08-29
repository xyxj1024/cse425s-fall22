functor PredicateTestingFn (PredicateTestingParameter : PREDICATE_TESTING_PARAMETER) : PREDICATE_TESTING_FN = struct
    open PredicateTestingParameter
    fun assert_status assert_true_or_false_with_message (param:param_type) : unit =
        let
            val actual = evaluate(param)
            val message = to_string_from_param(param)
        in
            assert_true_or_false_with_message(actual, message)
        end

    val assert_true = assert_status BoolTesting.assertTrueWithMessage
    val assert_false = assert_status BoolTesting.assertFalseWithMessage
end