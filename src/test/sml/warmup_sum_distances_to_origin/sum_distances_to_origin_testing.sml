signature SUM_DISTANCES_TO_ORIGIN_TESTING = sig
    val test_sum_distances_to_origin : unit -> unit
end

structure SumDistancesToOriginTesting :> SUM_DISTANCES_TO_ORIGIN_TESTING = struct
    fun test_sum_distances_to_origin() =
        let
            fun assert_sum_distances_to_origin(expected, xys, delta) = 
                RealTesting.assertEvalCloseEnoughWithMessage(
                    expected, 
                    fn() => SumDistancesToOrigin.sum_distances_to_origin(xys), 
                    delta, 
                    "sum_distances_to_origin(" ^ RealTesting.toStringFromListOfTuple2s(xys) ^ ")"
                )
            val reasonable_delta = 0.000001
        in
            ( UnitTesting.enter("sum_distances_to_origin")
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
