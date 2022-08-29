CM.make "../unit_testing/unit_testing.cm";
use "../../../main/sml/uw1/uw1.sml";

structure UW1Testing :> sig
    val test_base_credit : unit -> unit
    val test_extra_credit : unit -> unit
end = struct
    structure DateTesting = EqualityTestingFn (struct
        type t = int * int * int
        val toString = IntTesting.toStringFromTuple3
        fun compare((ay,am,ad),(by,bm,bd)) = 
            if ay=by
            then 
                if am=bm
                then Int.compare(ad,bd)
                else Int.compare(am,bm)
            else Int.compare(ay,by)
    end)

    fun test_is_older() =
        let
            fun assert_older_state assert_eval_true_or_false_with_message (a, b) = 
                assert_eval_true_or_false_with_message(
                    fn() => is_older(a, b), 
                    "is_older(" ^ DateTesting.toString(a) ^ ", " ^ DateTesting.toString(b) ^ ")"
                )

            val assert_older = assert_older_state BoolTesting.assertEvalTrueWithMessage
            val assert_not_older = assert_older_state BoolTesting.assertEvalFalseWithMessage
        in
            ( UnitTesting.enter("is_older")

                ; assert_older((1,2,3),(2,3,4))

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_number_in_month() =
        let
            fun assert_number_in_month(expected, dates, target_month) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => number_in_month(dates, target_month), 
                    "number_in_month(" ^ DateTesting.toStringFromList(dates) ^ ", " ^ Int.toString(target_month) ^ ")"
                )
        in
            ( UnitTesting.enter("number_in_month")

                ; assert_number_in_month(1, [(2012,2,28),(2013,12,1)],2)

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_number_in_months() =
        let
            fun assert_number_in_months(expected, dates, target_months) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => number_in_months(dates, target_months), 
                    "number_in_months(" ^ DateTesting.toStringFromList(dates) ^ ", " ^ IntTesting.toStringFromList(target_months) ^ ")"
                )
        in
            ( UnitTesting.enter("number_in_months")

                ; assert_number_in_months(3, [(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4])

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_dates_in_month() =
        let
            fun assert_dates_in_month(expected, dates, target_month) = 
                DateTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => dates_in_month(dates, target_month), 
                    "dates_in_month(" ^ DateTesting.toStringFromList(dates) ^ ", " ^ Int.toString(target_month) ^ ")"
                )
        in
            ( UnitTesting.enter("dates_in_month")

                ; assert_dates_in_month([(2012,2,28)], [(2012,2,28),(2013,12,1)], 2)

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_dates_in_months() =
        let
            fun assert_dates_in_months(expected, dates, target_months) = 
                DateTesting.assertListEvalEqualsAnyOrderWithMessage(
                    expected, 
                    fn() => dates_in_months(dates, target_months), 
                    "dates_in_months(" ^DateTesting.toStringFromList(dates) ^ ", " ^ IntTesting.toStringFromList(target_months) ^ ")"
                )
        in
            ( UnitTesting.enter("dates_in_months")

                ; assert_dates_in_months([(2012,2,28),(2011,3,31),(2011,4,28)], [(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4])

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_get_nth() =
        let
            fun assert_get_nth(expected, strings, n) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => get_nth(strings, n), 
                    "get_nth(" ^ StringTesting.toStringFromList(strings) ^ ", " ^ Int.toString(n) ^ ")"
                )
        in
            ( UnitTesting.enter("get_nth")

                ; assert_get_nth("there", ["hi", "there", "how", "are", "you"], 2)

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_date_to_string() =
        let
            fun assert_date_to_string(expected, date) = 
                StringTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => date_to_string(date), 
                    "date_to_string(" ^ DateTesting.toString(date) ^ ")"
                )
        in
            ( UnitTesting.enter("date_to_string")

                ; assert_date_to_string("June 1, 2013", (2013, 6, 1))

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_number_before_reaching_sum() =
        let
            fun assert_number_before_reaching_sum(expected, sum, xs) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => number_before_reaching_sum(sum, xs), 
                    "number_before_reaching_sum(" ^ Int.toString(sum) ^ ", " ^ IntTesting.toStringFromList(xs) ^ ")"
                )
        in
            ( UnitTesting.enter("number_before_reaching_sum")

                ; assert_number_before_reaching_sum(3, 10, [1,2,3,4,5,6,7,8])

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_what_month_tests() =
        let
            fun assert_what_month(expected, num_days) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => what_month(num_days), 
                    "what_month(" ^ Int.toString(num_days) ^ ")"
                )
        in
            ( UnitTesting.enter("what_month_tests")

                ; assert_what_month(3, 70)

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_month_range() =
        let
            fun assert_month_range(expected, a, b) = 
                IntTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => month_range(a, b), 
                    "month_range(" ^ Int.toString(a) ^ ", " ^ Int.toString(b) ^ ")"
                )
        in
            ( UnitTesting.enter("month_range")

                ; assert_month_range([1,2,2,2], 31, 34)

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_oldest() =
        let
            fun assert_oldest(expected, dates) = 
                DateTesting.assertOptionEvalEqualsWithMessage(
                    expected, 
                    fn() => oldest(dates), 
                    "oldest(" ^ DateTesting.toStringFromList(dates) ^ ")"
                )
        in
            ( UnitTesting.enter("oldest")

                ; assert_oldest(SOME (2011,3,31), [(2012,2,28),(2011,3,31),(2011,4,28)])

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_number_in_months_challenge() =
        let
            fun assert_number_in_months_challenge(expected, dates, months) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => number_in_months_challenge(dates, months), 
                    "number_in_months_challenge(" ^ DateTesting.toStringFromList(dates) ^ ", " ^ IntTesting.toStringFromList(months) ^ ")"
                )
        in
            ( UnitTesting.enter("number_in_months_challenge")

                ; assert_number_in_months_challenge(3, [(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4])

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_dates_in_months_challenge() =
        let
            fun assert_dates_in_months_challenge(expected, dates, target_months) = 
                DateTesting.assertListEvalEqualsAnyOrderWithMessage(
                    expected, 
                    fn() => dates_in_months_challenge(dates, target_months), 
                    "dates_in_months_challenge(" ^ DateTesting.toStringFromList(dates) ^ ", " ^ IntTesting.toStringFromList(target_months) ^ ")"
                )
        in
            ( UnitTesting.enter("dates_in_months_challenge")

                ; assert_dates_in_months_challenge([(2012,2,28),(2011,3,31),(2011,4,28)], [(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4])

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_reasonable_date() =
        let
            fun assert_reasonable_date_state assert_eval_true_or_false_with_message date = 
                assert_eval_true_or_false_with_message(
                    fn() => reasonable_date(date), 
                    "reasonable_date(" ^ DateTesting.toString(date) ^ ")"
                )
            val assert_reasonable = assert_reasonable_date_state BoolTesting.assertEvalTrueWithMessage
            val assert_not_reasonable = assert_reasonable_date_state BoolTesting.assertEvalFalseWithMessage
        in
            ( UnitTesting.enter("reasonable_date")

                ; assert_reasonable((1,2,3))

                (* add additional tests here *)

            ; UnitTesting.leave() )
        end

    fun test_base_credit() =
        ( test_is_older()
        ; test_number_in_month()
        ; test_number_in_months()
        ; test_dates_in_month()
        ; test_dates_in_months()
        ; test_get_nth()
        ; test_date_to_string()
        ; test_number_before_reaching_sum()
        ; test_what_month_tests()
        ; test_month_range()
        ; test_oldest() )

    fun test_extra_credit() =
        ( test_number_in_months_challenge()
        ; test_dates_in_months_challenge()
        ; test_reasonable_date() )
end

val _ = ( UW1Testing.test_base_credit()
        ; UW1Testing.test_extra_credit()
        ; OS.Process.exit(OS.Process.success)
        )
