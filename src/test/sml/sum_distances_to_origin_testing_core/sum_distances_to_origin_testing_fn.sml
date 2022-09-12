signature TESTING_FN = sig
    val test_sum_distances_to_origin : unit -> unit
end

signature TESTING_PARAMETER = sig
    val function : (real * real) list -> real
    val function_name : string
end

functor SumDistancesToOriginTestingFn (SumDistancesToOriginParameter : TESTING_PARAMETER) : TESTING_FN = struct
    open SumDistancesToOriginParameter

    fun test_sum_distances_to_origin() =
        let
            fun assert_sum_distances_to_origin(expected, xys, delta) = 
                RealTesting.assertEvalCloseEnoughWithMessage(
                    expected, 
                    fn() => function(xys), 
                    delta, 
                    function_name ^ "(" ^ RealTesting.toStringFromListOfTuple2s(xys) ^ ")"
                )
            val reasonable_delta = 0.000001
        in
            ( UnitTesting.enter(function_name)
                ; assert_sum_distances_to_origin(0.0, [], 0.0)
                ; assert_sum_distances_to_origin(0.0, [(0.0, 0.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(1.0, [(1.0, 0.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(1.0, [(0.0, 1.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(5.0, [(3.0, 4.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(10.0, [(6.0, 8.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(0.0, [(0.0, 0.0), (0.0, 0.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(1.0, [(0.0, 0.0), (1.0, 0.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(2.0, [(1.0, 0.0), (1.0, 0.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(2.0, [(1.0, 0.0), (0.0, 1.0)], reasonable_delta)
                ; assert_sum_distances_to_origin(17.0, [(1.0, 0.0), (0.0, 1.0), (3.0, 4.0), (6.0, 8.0)], reasonable_delta)
            ; UnitTesting.leave() )
        end
end
