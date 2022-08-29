CM.make "../unit_testing/unit_testing.cm";
use "../../../main/sml/uw0/uw0.sml";

fun test_double() =
    let
        fun assert_double(expected, x) = 
            IntTesting.assertEvalEqualsWithMessage(
                expected, 
                fn() => double(x), 
                "double(" ^ IntTesting.toString(x) ^ ")"
            )
    in
        ( UnitTesting.enter("double")
            ; assert_double(34, 17)
            ; assert_double(0, 0)

            (* add additional tests here *)

        ; UnitTesting.leave() )
    end


fun test_triple() =
    let
        fun assert_triple(expected, x) = 
            IntTesting.assertEvalEqualsWithMessage(
                expected, 
                fn() => triple(x), 
                "triple(" ^ IntTesting.toString(x) ^ ")"
            )
    in
        ( UnitTesting.enter("triple")

            ; assert_triple(~12, ~4)
            ; assert_triple(0, 0)

            (* You can add more tests here, for example you can uncomment the line below *)
            (* by deleting the first two character and last two characters on the line *)
            (* ; IntTesting.assertEquals(~3, triple ~1) *)

        ; UnitTesting.leave() )
    end

fun test_f() =
    let
        fun assert_f(expected, x, y) = 
            IntTesting.assertEvalEqualsWithMessage(
                expected, 
                fn() => f(x, y), 
                "f(" ^ IntTesting.toString(x) ^ ", " ^ IntTesting.toString(y) ^ ")"
            )
    in
        ( UnitTesting.enter("f")

            ; assert_f(324, 12, 27)


            (* add additional tests here *)

        ; UnitTesting.leave() )
    end


fun test_uw0() =
    ( test_double()
    ; test_triple()
    ; test_f() )

val _ = ( test_uw0()
        ; OS.Process.exit(OS.Process.success)
        )