signature SUM_SCAN_TESTING_FN = sig
    val test_sum_scan : unit -> unit
end

signature SUM_SCAN_TESTING_PARAMETER = sig
    val function : int list -> int list
    val function_name : string
    val is_curried : bool
end

functor SumScanTestingFn (SumScanTestingParameter : SUM_SCAN_TESTING_PARAMETER) : SUM_SCAN_TESTING_FN = struct
    open SumScanTestingParameter

    val prefix = if is_curried then " " else "("
    val postfix = if is_curried then "" else ")"

    fun test_sum_scan() =
        let
            fun assert_sum_scan(expected, xs) = 
                IntTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => function(xs), 
                    function_name ^ prefix ^ IntTesting.toStringFromList(xs) ^ postfix
                )
        in
            ( UnitTesting.enter(function_name)
                ; assert_sum_scan([], [])
                ; assert_sum_scan([0], [0])
                ; assert_sum_scan([1], [1])
                ; assert_sum_scan([231], [231])
                ; assert_sum_scan([425], [425])
                ; assert_sum_scan([0, 0], [0, 0])
                ; assert_sum_scan([0, 1], [0, 1])
                ; assert_sum_scan([1, 1], [1, 0])
                ; assert_sum_scan([0, 425], [0, 425])
                ; assert_sum_scan([425, 425], [425, 0])
                ; assert_sum_scan([1, 11], [1, 10])
                ; assert_sum_scan([10, 11], [10, 1])
                ; assert_sum_scan([1, 3], [1, 2])
                ; assert_sum_scan([2, 6], [2, 4])
                ; assert_sum_scan([231, 656], [231, 425])
                ; assert_sum_scan([0, 0, 0], [0, 0, 0])
                ; assert_sum_scan([0, 0, 425], [0, 0, 425])
                ; assert_sum_scan([0, 425, 425], [0, 425, 0])
                ; assert_sum_scan([425, 425, 425], [425, 0, 0])
                ; assert_sum_scan([1, 3, 6], [1, 2, 3])
                ; assert_sum_scan([131, 362, 787], [131, 231, 425])
                ; assert_sum_scan([1, 3, 6, 10, 15], [1, 2, 3, 4, 5])
                ; assert_sum_scan([5, 9, 12, 14, 15], [5, 4, 3, 2, 1])
                ; assert_sum_scan([7, 14, 21, 114, 125], [7, 7, 7, 93, 11])
            ; UnitTesting.leave() )
        end
end
