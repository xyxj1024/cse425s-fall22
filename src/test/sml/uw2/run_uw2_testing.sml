CM.make "../unit_testing/unit_testing.cm";
use "../../../main/sml/uw2/uw2.sml";

structure UW2Testing :> sig
    val test_base_credit : unit -> unit
    val test_extra_credit : unit -> unit
end = struct
    open UnitTesting

    structure FullNameTesting = EqualityTestingFn (struct
        type t = { first : string, middle : string, last : string }
        fun toString(a : t) = 
            #first a ^ " " ^ #middle a ^ " " ^ #last a
        fun compare({first=a_first, middle=a_middle, last=a_last}, {first=b_first, middle=b_middle, last=b_last}) = 
            case String.compare(a_first, b_first) of
              LESS => LESS
            | GREATER => GREATER
            | EQUAL =>
                case String.compare(a_middle, b_middle) of
                  LESS => LESS
                | GREATER => GREATER
                | EQUAL => String.compare(a_last, b_last)

    end)

    structure SuitTesting = EqualityTestingFn (struct
        type t = suit
        fun toString(Spades) = "Spades"
          | toString(Hearts) = "Hearts"
          | toString(Diamonds) = "Diamonds"
          | toString(Clubs) = "Clubs"
        fun compare(a,b) = raise Fail "unsupported"
    end)

    structure RankTesting = EqualityTestingFn (struct
        type t = rank
        fun toString(Jack) = "Jack"
          | toString(Queen) = "Queen"
          | toString(King) = "King"
          | toString(Ace) = "Ace"
          | toString(Num(x)) = IntTesting.toString(x)
        fun compare(a,b) = raise Fail "unsupported"
    end)

    structure CardTesting = EqualityTestingFn (struct
        type t = card
        fun toString(suit, rank) = "(" ^ SuitTesting.toString(suit) ^ ", " ^ RankTesting.toString(rank) ^ ")"
        fun compare((a_suit, a_rank), (b_suit, b_rank)) = 
            let
                fun suit_to_int Clubs = 100 |
                    suit_to_int Diamonds = 200 |
                    suit_to_int Hearts = 300 |
                    suit_to_int Spades = 400

                fun rank_to_int (Num v) = v |
                    rank_to_int Jack = 10 |
                    rank_to_int Queen = 11 |
                    rank_to_int King = 12 |
                    rank_to_int Ace = 13

                fun card_to_int(suit, rank) = 
                    suit_to_int(suit) + rank_to_int(rank)
            in
                Int.compare(card_to_int(a_suit, a_rank), card_to_int(b_suit, b_rank))
            end
    end)

    structure ColorTesting = EqualityTestingFn (struct
        type t = color
        fun toString(Red) = "Red"
          | toString(Black) = "Black"
        fun compare(a,b) = raise Fail "unsupported"
    end)

    structure MoveTesting = EqualityTestingFn (struct
        type t = move
        fun toString(Draw) = "Draw"
          | toString(Discard(c)) = "Discard(" ^ CardTesting.toString(c) ^ ")"
        fun compare(a,b) = raise Fail "unsupported"
    end)

    

    fun test_all_except_option() =
        let
            fun assert_all_except_option(expected, str, strs) = 
                StringTesting.assertListOptionEvalEqualsAnyOrderWithMessage(
                    expected, 
                    fn() => all_except_option(str, strs),
                    "all_except_option(" ^ StringTesting.toString(str) ^ ", " ^ StringTesting.toStringFromList(strs) ^ ")"
                )
        in
            ( enter("all_except_option")
                ; assert_all_except_option(SOME [], "string", ["string"])
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_get_substitutions1() =
        let
            fun assert_get_substitutions1(expected, substitutions : string list list, str : string) = 
                StringTesting.assertListEvalEqualsAnyOrderWithMessage(
                    expected, 
                    fn() => get_substitutions1(substitutions, str), 
                    "get_substitutions1(" ^ StringTesting.toStringFromListList(substitutions) ^ ", " ^ StringTesting.toString(str) ^ ")"
                )
        in
            ( enter("get_substitutions1")
                ; assert_get_substitutions1([], [["foo"],["there"]], "foo")
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_get_substitutions2() =
        let
            fun assert_get_substitutions2(expected, substitutions : string list list, str : string) = 
                StringTesting.assertListEvalEqualsAnyOrderWithMessage(
                    expected, 
                    fn() => get_substitutions2(substitutions, str), 
                    "get_substitutions2(" ^ StringTesting.toStringFromListList(substitutions) ^ ", " ^ StringTesting.toString(str) ^ ")"
                )
        in
            ( enter("get_substitutions2")
                ; assert_get_substitutions2([], [["foo"],["there"]], "foo")
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_similar_names() =
        let
            fun assert_similar_names(expected, substitutions : string list list, full_name : {first:string, middle:string, last:string}) = 
                FullNameTesting.assertListEvalEqualsAnyOrderWithMessage(
                    expected, 
                    fn() => similar_names(substitutions, full_name), 
                    "similar_names(" ^ StringTesting.toStringFromListList(substitutions) ^ ", " ^ FullNameTesting.toString(full_name) ^ ")"
                )
        in
            ( enter("similar_names")
                ; assert_similar_names([
                    {first="Fred", last="Smith", middle="W"}, 
                    {first="Fredrick", last="Smith", middle="W"},
                    {first="Freddie", last="Smith", middle="W"}, 
                    {first="F", last="Smith", middle="W"}], 
                    [["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"})

                (* add additional tests here *)

            ; leave() )
        end

    fun test_card_color() =
        let
            fun assert_card_color(expected, crd) = 
                ColorTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => card_color(crd), 
                    "card_color(" ^ CardTesting.toString(crd) ^ ")"
                )
        in
            ( enter("card_color")
                ; assert_card_color(Black, (Clubs, Num 2))
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_card_value() =
        let
            fun assert_card_value(expected, crd) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => card_value(crd), 
                    "card_value(" ^ CardTesting.toString(crd) ^ ")"
                )
        in
            ( enter("card_value")
                ; assert_card_value(2, (Clubs, Num 2))
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_remove_card() =
        let
            fun assert_remove_card(expected, crds, crd, e) = 
                CardTesting.assertListEvalEqualsAnyOrderWithMessage(
                    expected, 
                    fn() => remove_card(crds, crd, e), 
                    "remove_card(" ^ CardTesting.toStringFromList(crds) ^ ", " ^ CardTesting.toString(crd) ^ ", " ^ exnName(e) ^ ")"
                )
        in
            ( enter("remove_card")
                ; assert_remove_card([], [(Hearts, Ace)], (Hearts, Ace), IllegalMove)
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_all_same_color() =
        let
            fun assert_all_same_color_eval_status assert_eval_true_or_false_with_message crds = 
                assert_eval_true_or_false_with_message(
                    fn() => all_same_color(crds), 
                    "all_same_color(" ^ CardTesting.toStringFromList(crds) ^ ")"
                )

            val assert_all_same_color = assert_all_same_color_eval_status BoolTesting.assertEvalTrueWithMessage
            val assert_not_all_same_color = assert_all_same_color_eval_status BoolTesting.assertEvalFalseWithMessage
        in
            ( enter("all_same_color")
                ; assert_all_same_color([(Hearts, Ace), (Hearts, Ace)])
                ; assert_all_same_color([])

            ; leave() )
        end

    fun test_sum_cards() =
        let
            fun assert_sum_cards(expected, crds) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => sum_cards(crds), 
                    "sum_cards(" ^ CardTesting.toStringFromList(crds) ^ ")"
                )
        in
            ( enter("sum_cards")
                ; assert_sum_cards(4, [(Clubs, Num 2),(Clubs, Num 2)])
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_score() =
        let
            fun assert_score(expected, held_cards, goal) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => score(held_cards, goal), 
                    "score(" ^ CardTesting.toStringFromList(held_cards) ^ ", " ^ Int.toString(goal) ^ ")"
                )
        in
            ( enter("score")
                ; assert_score(4, [(Hearts, Num 2),(Clubs, Num 4)], 10)
                ; assert_score(5, [], 10)

            ; leave() )
        end
    
    fun test_officiate() =
        let
            fun assert_officiate(expected, draw_pile, moves, goal) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => officiate(draw_pile, moves, goal), 
                    "officiate(" ^ CardTesting.toStringFromList(draw_pile) ^ ", " ^ MoveTesting.toStringFromList(moves) ^ ", " ^ Int.toString(goal) ^ ")"
                )
        in
            ( enter("officiate")
                ; assert_officiate(6, [(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15)
                ; assert_officiate(3, [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw], 42)
                ; ExceptionTesting.assertRaisesExceptionWithMessage(fn() => officiate([(Clubs,Jack),(Spades,Num(8))], [Draw,Discard(Hearts,Jack)], 42), IllegalMove, "officiate")

                (* add additional tests here *)

            ; leave() )
        end

    fun test_score_challenge() =
        let
            fun assert_score_challenge(expected, held_cards, goal) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => score_challenge(held_cards, goal), 
                    "score_challenge(" ^ CardTesting.toStringFromList(held_cards) ^ ", " ^ Int.toString(goal) ^ ")"
                )
        in
            ( enter("score_challenge")
                ; assert_score_challenge(4, [(Hearts, Num 2),(Clubs, Num 4)],10)

                (* add additional tests here *)

            ; leave() )
        end

    fun test_officiate_challenge() =
        let
            fun assert_officiate_challenge(expected, draw_pile, moves, goal) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => officiate_challenge(draw_pile, moves, goal), 
                    "officiate_challenge(" ^ CardTesting.toStringFromList(draw_pile) ^ ", " ^ MoveTesting.toStringFromList(moves) ^ ", " ^ Int.toString(goal) ^ ")"
                )
        in
            ( enter("officiate_challenge")
                ; assert_officiate_challenge(6, [(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15)
                ; assert_officiate_challenge(3, [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw], 42)
                

                (* add additional tests here *)

            ; leave() )
        end
    
    fun test_careful_player() =
        let
            fun assert_careful_player(expected, cards, goal) = 
                MoveTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => careful_player(cards, goal), 
                    "careful_player(" ^ CardTesting.toStringFromList(cards) ^ ", " ^ Int.toString(goal) ^ ")"
                )
        in
            ( enter("careful_player")
                ; assert_careful_player([], [], 0)
                

                (* add additional tests here *)

            ; leave() )
        end

    fun test_base_credit() =
        ( test_all_except_option()
        ; test_get_substitutions1()
        ; test_get_substitutions2()
        ; test_similar_names()
        ; test_card_color()
        ; test_card_value()
        ; test_remove_card()
        ; test_all_same_color()
        ; test_sum_cards()
        ; test_score()
        ; test_officiate() )

    fun test_extra_credit() =
        ( test_score_challenge()
        ; test_officiate_challenge()
        ; test_careful_player() )
end

val _ = ( UW2Testing.test_base_credit()
        ; UW2Testing.test_extra_credit()
        ; OS.Process.exit(OS.Process.success)
        )
