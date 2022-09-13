(* Dennis Cosgrove *)
structure HeartsTesting :> sig
    val test_hearts : unit -> unit
end = struct
    open Hearts
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
        fun compare(a,b) = raise Fail "unsupported"
    end)

    fun test_is_card_valid() =
        let
            fun assert_card_validity assert_eval_true_or_false_with_message card = 
                assert_eval_true_or_false_with_message(
                    fn() => is_card_valid(card), 
                    "is_card_valid(" ^ CardTesting.toString(card) ^ ")"
                )

            val assert_card_valid = assert_card_validity BoolTesting.assertEvalTrueWithMessage
            val assert_card_not_valid = assert_card_validity BoolTesting.assertEvalFalseWithMessage
        in
            ( UnitTesting.enter("is_card_valid")

                ; assert_card_valid(Clubs, Ace)
                ; assert_card_valid(Clubs, King)
                ; assert_card_valid(Clubs, Queen)
                ; assert_card_valid(Clubs, Jack)
                ; assert_card_valid(Clubs, Num 10)
                ; assert_card_valid(Clubs, Num 9)
                ; assert_card_valid(Clubs, Num 8)
                ; assert_card_valid(Clubs, Num 7)
                ; assert_card_valid(Clubs, Num 6)
                ; assert_card_valid(Clubs, Num 5)
                ; assert_card_valid(Clubs, Num 4)
                ; assert_card_valid(Clubs, Num 3)
                ; assert_card_valid(Clubs, Num 2)
                
                ; assert_card_valid(Diamonds, Ace)
                ; assert_card_valid(Diamonds, King)
                ; assert_card_valid(Diamonds, Queen)
                ; assert_card_valid(Diamonds, Jack)
                ; assert_card_valid(Diamonds, Num 10)
                ; assert_card_valid(Diamonds, Num 9)
                ; assert_card_valid(Diamonds, Num 8)
                ; assert_card_valid(Diamonds, Num 7)
                ; assert_card_valid(Diamonds, Num 6)
                ; assert_card_valid(Diamonds, Num 5)
                ; assert_card_valid(Diamonds, Num 4)
                ; assert_card_valid(Diamonds, Num 3)
                ; assert_card_valid(Diamonds, Num 2)
                
                ; assert_card_valid(Hearts, Ace)
                ; assert_card_valid(Hearts, King)
                ; assert_card_valid(Hearts, Queen)
                ; assert_card_valid(Hearts, Jack)
                ; assert_card_valid(Hearts, Num 10)
                ; assert_card_valid(Hearts, Num 9)
                ; assert_card_valid(Hearts, Num 8)
                ; assert_card_valid(Hearts, Num 7)
                ; assert_card_valid(Hearts, Num 6)
                ; assert_card_valid(Hearts, Num 5)
                ; assert_card_valid(Hearts, Num 4)
                ; assert_card_valid(Hearts, Num 3)
                ; assert_card_valid(Hearts, Num 2)
                
                ; assert_card_valid(Spades, Ace)
                ; assert_card_valid(Spades, King)
                ; assert_card_valid(Spades, Queen)
                ; assert_card_valid(Spades, Jack)
                ; assert_card_valid(Spades, Num 10)
                ; assert_card_valid(Spades, Num 9)
                ; assert_card_valid(Spades, Num 8)
                ; assert_card_valid(Spades, Num 7)
                ; assert_card_valid(Spades, Num 6)
                ; assert_card_valid(Spades, Num 5)
                ; assert_card_valid(Spades, Num 4)
                ; assert_card_valid(Spades, Num 3)
                ; assert_card_valid(Spades, Num 2)

                (* number cards outside of 2 and 10 inclusive are not valid *)
                ; assert_card_not_valid(Spades, Num 1)
                ; assert_card_not_valid(Spades, Num 11)
                ; assert_card_not_valid(Spades, Num 425)
                ; assert_card_not_valid(Spades, Num ~10)

                ; assert_card_not_valid(Hearts, Num 1)
                ; assert_card_not_valid(Hearts, Num 11)
                ; assert_card_not_valid(Hearts, Num 425)
                ; assert_card_not_valid(Hearts, Num ~10)

                ; assert_card_not_valid(Diamonds, Num 1)
                ; assert_card_not_valid(Diamonds, Num 11)
                ; assert_card_not_valid(Diamonds, Num 425)
                ; assert_card_not_valid(Diamonds, Num ~10)

                ; assert_card_not_valid(Clubs, Num 1)
                ; assert_card_not_valid(Clubs, Num 11)
                ; assert_card_not_valid(Clubs, Num 425)
                ; assert_card_not_valid(Clubs, Num ~10)

            ; UnitTesting.leave()
            )
        end

    val INVALID_CARD = (Spades, Num(231))

    fun test_are_all_cards_valid() =
        let
            fun assert_all_cards_validity assert_eval_true_or_false_with_message cards = 
                assert_eval_true_or_false_with_message(
                    fn() => are_all_cards_valid(cards), 
                    "are_all_cards_valid(" ^ CardTesting.toStringFromList(cards) ^ ")"
                )

            val assert_all_cards_valid = assert_all_cards_validity BoolTesting.assertEvalTrueWithMessage
            val assert_all_cards_not_valid = assert_all_cards_validity BoolTesting.assertEvalFalseWithMessage
        in
            ( UnitTesting.enter("are_all_cards_valid")
                ; assert_all_cards_valid([])
                ; assert_all_cards_valid([(Spades, Ace)])
                ; assert_all_cards_valid([(Spades, Ace), (Diamonds, King)])
                ; assert_all_cards_valid([(Spades, Ace), (Diamonds, King), (Clubs, Num(7))])
                ; assert_all_cards_valid([(Spades, Ace), (Diamonds, King), (Clubs, Num(7)), (Clubs, Num(2))])
                ; assert_all_cards_not_valid([INVALID_CARD])
                ; assert_all_cards_not_valid([INVALID_CARD, (Spades, Ace)])
                ; assert_all_cards_not_valid([(Spades, Ace), INVALID_CARD])
                ; assert_all_cards_not_valid([INVALID_CARD, (Spades, Ace), (Diamonds, King)])
                ; assert_all_cards_not_valid([(Spades, Ace), INVALID_CARD, (Diamonds, King)])
                ; assert_all_cards_not_valid([(Spades, Ace), (Diamonds, King), INVALID_CARD])
                ; assert_all_cards_not_valid([INVALID_CARD, (Spades, Ace), (Diamonds, King), (Clubs, Num(7))])
                ; assert_all_cards_not_valid([(Spades, Ace), INVALID_CARD, (Diamonds, King), (Clubs, Num(7))])
                ; assert_all_cards_not_valid([(Spades, Ace), (Diamonds, King), INVALID_CARD, (Clubs, Num(7))])
                ; assert_all_cards_not_valid([(Spades, Ace), (Diamonds, King), (Clubs, Num(7)), INVALID_CARD])
                ; assert_all_cards_not_valid([INVALID_CARD, (Spades, Ace), (Diamonds, King), (Clubs, Num(7)), (Clubs, Num(2))])
                ; assert_all_cards_not_valid([(Spades, Ace), INVALID_CARD, (Diamonds, King), (Clubs, Num(7)), (Clubs, Num(2))])
                ; assert_all_cards_not_valid([(Spades, Ace), (Diamonds, King), INVALID_CARD, (Clubs, Num(7)), (Clubs, Num(2))])
                ; assert_all_cards_not_valid([(Spades, Ace), (Diamonds, King), (Clubs, Num(7)), INVALID_CARD, (Clubs, Num(2))])
                ; assert_all_cards_not_valid([(Spades, Ace), (Diamonds, King), (Clubs, Num(7)), (Clubs, Num(2)), INVALID_CARD])
                ; assert_all_cards_not_valid([INVALID_CARD, INVALID_CARD, (Spades, Ace), INVALID_CARD, (Diamonds, King), INVALID_CARD, (Clubs, Num(7)), INVALID_CARD, INVALID_CARD, (Clubs, Num(2)), INVALID_CARD])
            ; UnitTesting.leave()
            )
        end
    (* ======================================================== *)
    (* NOTE: all tests from here on will only pass valid cards. *)
    (*       you need NOT check for validity or handle invalid cards from here on. *)
    (* ======================================================== *)
    fun test_card_score() =
        let
            fun assert_card_score(expected, card) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => card_score(card), 
                    "card_score(" ^ CardTesting.toString(card) ^ ")"
                )
        in
            ( UnitTesting.enter("card_score")
                ; assert_card_score(13, (Spades, Queen))
                ; assert_card_score(1, (Hearts, Ace))
                ; assert_card_score(1, (Hearts, King))
                ; assert_card_score(1, (Hearts, Queen))
                ; assert_card_score(1, (Hearts, Jack))
                ; assert_card_score(1, (Hearts, Num 10))
                ; assert_card_score(1, (Hearts, Num 9))
                ; assert_card_score(1, (Hearts, Num 8))
                ; assert_card_score(1, (Hearts, Num 7))
                ; assert_card_score(1, (Hearts, Num 6))
                ; assert_card_score(1, (Hearts, Num 5))
                ; assert_card_score(1, (Hearts, Num 4))
                ; assert_card_score(1, (Hearts, Num 3))
                ; assert_card_score(1, (Hearts, Num 2))
                ; assert_card_score(~10, (Diamonds, Jack))
                
                ; assert_card_score(0, (Clubs, Ace))
                ; assert_card_score(0, (Clubs, King))
                ; assert_card_score(0, (Clubs, Queen))
                ; assert_card_score(0, (Clubs, Jack))
                ; assert_card_score(0, (Clubs, Num 10))
                ; assert_card_score(0, (Clubs, Num 9))
                ; assert_card_score(0, (Clubs, Num 8))
                ; assert_card_score(0, (Clubs, Num 7))
                ; assert_card_score(0, (Clubs, Num 6))
                ; assert_card_score(0, (Clubs, Num 5))
                ; assert_card_score(0, (Clubs, Num 4))
                ; assert_card_score(0, (Clubs, Num 3))
                ; assert_card_score(0, (Clubs, Num 2))
                
                ; assert_card_score(0, (Diamonds, Ace))
                ; assert_card_score(0, (Diamonds, King))
                ; assert_card_score(0, (Diamonds, Queen))
                
                ; assert_card_score(0, (Diamonds, Num 10))
                ; assert_card_score(0, (Diamonds, Num 9))
                ; assert_card_score(0, (Diamonds, Num 8))
                ; assert_card_score(0, (Diamonds, Num 7))
                ; assert_card_score(0, (Diamonds, Num 6))
                ; assert_card_score(0, (Diamonds, Num 5))
                ; assert_card_score(0, (Diamonds, Num 4))
                ; assert_card_score(0, (Diamonds, Num 3))
                ; assert_card_score(0, (Diamonds, Num 2))
                
                ; assert_card_score(0, (Spades, Ace))
                ; assert_card_score(0, (Spades, King))

                ; assert_card_score(0, (Spades, Jack))
                ; assert_card_score(0, (Spades, Num 10))
                ; assert_card_score(0, (Spades, Num 9))
                ; assert_card_score(0, (Spades, Num 8))
                ; assert_card_score(0, (Spades, Num 7))
                ; assert_card_score(0, (Spades, Num 6))
                ; assert_card_score(0, (Spades, Num 5))
                ; assert_card_score(0, (Spades, Num 4))
                ; assert_card_score(0, (Spades, Num 3))
                ; assert_card_score(0, (Spades, Num 2))
            ; UnitTesting.leave()
            )
        end

    val all_clubs = [(Clubs, Ace), (Clubs, King), (Clubs, Queen), (Clubs, Jack), (Clubs, Num(10)), (Clubs, Num(9)), (Clubs, Num(8)), (Clubs, Num(7)), (Clubs, Num(6)), (Clubs, Num(5)), (Clubs, Num(4)), (Clubs, Num(3)), (Clubs, Num(2))]
    val all_diamonds = [(Diamonds, Ace), (Diamonds, King), (Diamonds, Queen), (Diamonds, Jack), (Diamonds, Num(10)), (Diamonds, Num(9)), (Diamonds, Num(8)), (Diamonds, Num(7)), (Diamonds, Num(6)), (Diamonds, Num(5)), (Diamonds, Num(4)), (Diamonds, Num(3)), (Diamonds, Num(2))]
    val all_hearts = [(Hearts, Ace), (Hearts, King), (Hearts, Queen), (Hearts, Jack), (Hearts, Num(10)), (Hearts, Num(9)), (Hearts, Num(8)), (Hearts, Num(7)), (Hearts, Num(6)), (Hearts, Num(5)), (Hearts, Num(4)), (Hearts, Num(3)), (Hearts, Num(2))]
    val all_spades = [(Spades, Ace), (Spades, King), (Spades, Queen), (Spades, Jack), (Spades, Num(10)), (Spades, Num(9)), (Spades, Num(8)), (Spades, Num(7)), (Spades, Num(6)), (Spades, Num(5)), (Spades, Num(4)), (Spades, Num(3)), (Spades, Num(2))]

    val all_aces = [(Clubs, Ace), (Diamonds, Ace), (Hearts, Ace), (Spades, Ace)]
    val all_kings = [(Clubs, King), (Diamonds, King), (Hearts, King), (Spades, King)]
    val all_queens = [(Clubs, Queen), (Diamonds, Queen), (Hearts, Queen), (Spades, Queen)]
    val all_jacks = [(Clubs, Jack), (Diamonds, Jack), (Hearts, Jack), (Spades, Jack)]
    val all_10s = [(Clubs, Num(10)), (Diamonds, Num(10)), (Hearts, Num(10)), (Spades, Num(10))]
    val all_9s = [(Clubs, Num(9)), (Diamonds, Num(9)), (Hearts, Num(9)), (Spades, Num(9))]
    val all_8s = [(Clubs, Num(8)), (Diamonds, Num(8)), (Hearts, Num(8)), (Spades, Num(8))]
    val all_7s = [(Clubs, Num(7)), (Diamonds, Num(7)), (Hearts, Num(7)), (Spades, Num(7))]
    val all_6s = [(Clubs, Num(6)), (Diamonds, Num(6)), (Hearts, Num(6)), (Spades, Num(6))]
    val all_5s = [(Clubs, Num(5)), (Diamonds, Num(5)), (Hearts, Num(5)), (Spades, Num(5))]
    val all_4s = [(Clubs, Num(4)), (Diamonds, Num(4)), (Hearts, Num(4)), (Spades, Num(4))]
    val all_3s = [(Clubs, Num(3)), (Diamonds, Num(3)), (Hearts, Num(3)), (Spades, Num(3))]
    val all_2s = [(Clubs, Num(2)), (Diamonds, Num(2)), (Hearts, Num(2)), (Spades, Num(2))]

    fun test_total_score_of_card_list() =
        let
            fun assert_total_score_of_card_list(expected, cards) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => total_score_of_card_list(cards), 
                    "total_score_of_card_list(" ^ CardTesting.toStringFromList(cards) ^ ")"
                )
        in
            ( UnitTesting.enter("total_score_of_card_list")
                ; assert_total_score_of_card_list(0, [])
                ; assert_total_score_of_card_list(13, [(Spades, Queen)])
                ; assert_total_score_of_card_list(1, [(Hearts, King)])
                ; assert_total_score_of_card_list(~10, [(Diamonds, Jack)])
                ; assert_total_score_of_card_list(0, [(Clubs, Ace)])
                ; assert_total_score_of_card_list(0, all_clubs)
                ; assert_total_score_of_card_list(~10, all_diamonds)
                ; assert_total_score_of_card_list(13, all_hearts)
                ; assert_total_score_of_card_list(13, all_spades)
                ; assert_total_score_of_card_list(1, all_aces)
                ; assert_total_score_of_card_list(1, all_kings)
                ; assert_total_score_of_card_list(14, all_queens)
                ; assert_total_score_of_card_list(~9, all_jacks)
                ; assert_total_score_of_card_list(1, all_10s)
                ; assert_total_score_of_card_list(1, all_9s)
                ; assert_total_score_of_card_list(1, all_8s)
                ; assert_total_score_of_card_list(1, all_7s)
                ; assert_total_score_of_card_list(1, all_6s)
                ; assert_total_score_of_card_list(1, all_5s)
                ; assert_total_score_of_card_list(1, all_4s)
                ; assert_total_score_of_card_list(1, all_3s)
                ; assert_total_score_of_card_list(1, all_2s)
            ; UnitTesting.leave()
            )
        end   
    (* ======================================================== *)
    (* NOTE: total_score_of_player_list must be tail recursive. *)
    (* ======================================================== *)

    fun test_total_score_of_player_list() =
        let
            fun assert_total_score_of_player_list(expected, players) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => total_score_of_player_list(players), 
                    "total_score_of_player_list(" ^ CardTesting.toStringFromListList(players) ^ ")"
                )
        in
            ( UnitTesting.enter("total_score_of_player_list")
                ; assert_total_score_of_player_list(0, [])
                ; assert_total_score_of_player_list(0, [[]])
                ; assert_total_score_of_player_list(0, [[],[]])
                ; assert_total_score_of_player_list(0, [[],[],[]])
                ; assert_total_score_of_player_list(13, [[(Spades, Queen)]])
                ; assert_total_score_of_player_list(1, [[(Hearts, King)]])
                ; assert_total_score_of_player_list(~10, [[(Diamonds, Jack)]])
                ; assert_total_score_of_player_list(0, [[(Clubs, Ace)]])
                ; assert_total_score_of_player_list(0, [all_clubs])
                ; assert_total_score_of_player_list(~10, [all_diamonds])
                ; assert_total_score_of_player_list(13, [all_hearts])
                ; assert_total_score_of_player_list(13, [all_spades])
                ; assert_total_score_of_player_list(1, [all_aces])
                ; assert_total_score_of_player_list(1, [all_kings])
                ; assert_total_score_of_player_list(14, [all_queens])
                ; assert_total_score_of_player_list(~9, [all_jacks])
                ; assert_total_score_of_player_list(1, [all_10s])
                ; assert_total_score_of_player_list(1, [all_9s])
                ; assert_total_score_of_player_list(1, [all_8s])
                ; assert_total_score_of_player_list(1, [all_7s])
                ; assert_total_score_of_player_list(1, [all_6s])
                ; assert_total_score_of_player_list(1, [all_5s])
                ; assert_total_score_of_player_list(1, [all_4s])
                ; assert_total_score_of_player_list(1, [all_3s])
                ; assert_total_score_of_player_list(1, [all_2s])
                ; assert_total_score_of_player_list(~10, [all_clubs, all_diamonds])
                ; assert_total_score_of_player_list(3, [all_diamonds, all_hearts])
                ; assert_total_score_of_player_list(26, [all_hearts, all_spades])
                ; assert_total_score_of_player_list(16, [all_diamonds, all_hearts, all_spades])
                ; assert_total_score_of_player_list(16, [all_clubs, all_diamonds, all_hearts, all_spades])
                ; assert_total_score_of_player_list(2, [all_7s, all_2s])
                ; assert_total_score_of_player_list(2, [all_aces, all_kings])
                ; assert_total_score_of_player_list(15, [all_aces, all_queens])
                ; assert_total_score_of_player_list(~8, [all_aces, all_jacks])
                ; assert_total_score_of_player_list(16, [all_aces, all_kings, all_queens])
                ; assert_total_score_of_player_list(7, [all_aces, all_kings, all_queens, all_jacks])
                ; assert_total_score_of_player_list(16, [all_aces, all_kings, all_queens, all_jacks, all_10s, all_9s, all_8s, all_7s, all_6s, all_5s, all_4s, all_3s, all_2s])
                ; assert_total_score_of_player_list(16, [[], all_aces, all_kings, all_queens, all_jacks, all_10s, all_9s, all_8s, all_7s, all_6s, all_5s, all_4s, all_3s, all_2s])
                ; assert_total_score_of_player_list(16, [all_aces, all_kings, all_queens, all_jacks, all_10s, [], all_9s, all_8s, all_7s, all_6s, all_5s, all_4s, all_3s, all_2s])
                ; assert_total_score_of_player_list(16, [all_aces, all_kings, all_queens, all_jacks, all_10s, all_9s, all_8s, all_7s, all_6s, all_5s, all_4s, all_3s, all_2s, []])
            ; UnitTesting.leave()
            )
        end
    (* ======================================================== *)
    (* NOTE: total_card_count_for_all_players may use length.   *)
    (* ======================================================== *)

    (* ======================================================== *)
    (* NOTE: total_card_count_for_all_players must use a higher order function. *)
    (* ======================================================== *)
    fun test_total_card_count_for_all_players() =
        let
            fun assert_total_card_count_for_all_players(expected, players) = 
                IntTesting.assertEvalEqualsWithMessage(
                    expected, 
                    fn() => total_card_count_for_all_players(players), 
                    "total_card_count_for_all_players(" ^ CardTesting.toStringFromListList(players) ^ ")"
                )
        in
            ( UnitTesting.enter("total_card_count_for_all_players")
                ; assert_total_card_count_for_all_players(0, [])
                ; assert_total_card_count_for_all_players(0, [[]])
                ; assert_total_card_count_for_all_players(0, [[],[]])
                ; assert_total_card_count_for_all_players(0, [[],[],[]])
                ; assert_total_card_count_for_all_players(1, [[(Spades, Queen)]])
                ; assert_total_card_count_for_all_players(1, [[(Hearts, King)]])
                ; assert_total_card_count_for_all_players(1, [[(Diamonds, Jack)]])
                ; assert_total_card_count_for_all_players(1, [[(Clubs, Ace)]])
                ; assert_total_card_count_for_all_players(13, [all_clubs])
                ; assert_total_card_count_for_all_players(13, [all_diamonds])
                ; assert_total_card_count_for_all_players(13, [all_hearts])
                ; assert_total_card_count_for_all_players(13, [all_spades])
                ; assert_total_card_count_for_all_players(4, [all_aces])
                ; assert_total_card_count_for_all_players(4, [all_kings])
                ; assert_total_card_count_for_all_players(4, [all_queens])
                ; assert_total_card_count_for_all_players(4, [all_jacks])
                ; assert_total_card_count_for_all_players(4, [all_10s])
                ; assert_total_card_count_for_all_players(4, [all_9s])
                ; assert_total_card_count_for_all_players(4, [all_8s])
                ; assert_total_card_count_for_all_players(4, [all_7s])
                ; assert_total_card_count_for_all_players(4, [all_6s])
                ; assert_total_card_count_for_all_players(4, [all_5s])
                ; assert_total_card_count_for_all_players(4, [all_4s])
                ; assert_total_card_count_for_all_players(4, [all_3s])
                ; assert_total_card_count_for_all_players(4, [all_2s])
                ; assert_total_card_count_for_all_players(26, [all_clubs, all_diamonds])
                ; assert_total_card_count_for_all_players(26, [all_diamonds, all_hearts])
                ; assert_total_card_count_for_all_players(26, [all_hearts, all_spades])
                ; assert_total_card_count_for_all_players(39, [all_diamonds, all_hearts, all_spades])
                ; assert_total_card_count_for_all_players(52, [all_clubs, all_diamonds, all_hearts, all_spades])
                ; assert_total_card_count_for_all_players(8, [all_7s, all_2s])
                ; assert_total_card_count_for_all_players(8, [all_aces, all_kings])
                ; assert_total_card_count_for_all_players(8, [all_aces, all_queens])
                ; assert_total_card_count_for_all_players(8, [all_aces, all_jacks])
                ; assert_total_card_count_for_all_players(12, [all_aces, all_kings, all_queens])
                ; assert_total_card_count_for_all_players(16, [all_aces, all_kings, all_queens, all_jacks])
                ; assert_total_card_count_for_all_players(52, [all_aces, all_kings, all_queens, all_jacks, all_10s, all_9s, all_8s, all_7s, all_6s, all_5s, all_4s, all_3s, all_2s])
            ; UnitTesting.leave()
            )
        end
    
    fun test_is_correct_total_of_cards() =
        let
            fun assert_total_correctness assert_eval_true_or_false_with_message players = 
                assert_eval_true_or_false_with_message(
                    fn() => is_correct_total_of_cards(players), 
                    "is_correct_total_of_cards(" ^ CardTesting.toStringFromListList(players) ^ ")"
                )

            val assert_total_correct = assert_total_correctness BoolTesting.assertEvalTrueWithMessage
            val assert_total_incorrect = assert_total_correctness BoolTesting.assertEvalFalseWithMessage
        in
            ( UnitTesting.enter("is_correct_total_of_cards")
                ; assert_total_incorrect([])
                ; assert_total_incorrect([[]])
                ; assert_total_incorrect([[],[]])
                ; assert_total_incorrect([[],[],[]])
                ; assert_total_incorrect([[(Spades, Queen)]])
                ; assert_total_incorrect([[(Hearts, King)]])
                ; assert_total_incorrect([[(Diamonds, Jack)]])
                ; assert_total_incorrect([[(Clubs, Ace)]])
                ; assert_total_incorrect([all_clubs])
                ; assert_total_incorrect([all_diamonds])
                ; assert_total_incorrect([all_hearts])
                ; assert_total_incorrect([all_spades])
                ; assert_total_incorrect([all_aces])
                ; assert_total_incorrect([all_kings])
                ; assert_total_incorrect([all_queens])
                ; assert_total_incorrect([all_jacks])
                ; assert_total_incorrect([all_10s])
                ; assert_total_incorrect([all_9s])
                ; assert_total_incorrect([all_8s])
                ; assert_total_incorrect([all_7s])
                ; assert_total_incorrect([all_6s])
                ; assert_total_incorrect([all_5s])
                ; assert_total_incorrect([all_4s])
                ; assert_total_incorrect([all_3s])
                ; assert_total_incorrect([all_2s])
                ; assert_total_incorrect([all_clubs, all_diamonds])
                ; assert_total_incorrect([all_diamonds, all_hearts])
                ; assert_total_incorrect([all_hearts, all_spades])
                ; assert_total_incorrect([all_diamonds, all_hearts, all_spades])
                ; assert_total_correct([all_clubs, all_diamonds, all_hearts, all_spades])
                ; assert_total_incorrect([all_7s, all_2s])
                ; assert_total_incorrect([all_aces, all_kings])
                ; assert_total_incorrect([all_aces, all_queens])
                ; assert_total_incorrect([all_aces, all_jacks])
                ; assert_total_incorrect([all_aces, all_kings, all_queens])
                ; assert_total_incorrect([all_aces, all_kings, all_queens, all_jacks])
                ; assert_total_correct([all_aces, all_kings, all_queens, all_jacks, all_10s, all_9s, all_8s, all_7s, all_6s, all_5s, all_4s, all_3s, all_2s])
            ; UnitTesting.leave()
            )
        end

    fun test_is_shenanigans_detected() =
        let
            fun assert_shenanigans_state assert_eval_true_or_false_with_message players = 
                assert_eval_true_or_false_with_message(
                    fn() => is_shenanigans_detected(players),
                    "is_shenanigans_detected(" ^ CardTesting.toStringFromListList(players) ^ ")"
                )

            val assert_shenanigans = assert_shenanigans_state BoolTesting.assertEvalTrueWithMessage
            val assert_no_shenanigans = assert_shenanigans_state BoolTesting.assertEvalFalseWithMessage
        in
            ( UnitTesting.enter("is_shenanigans_detected")
                ; assert_shenanigans([])
                ; assert_shenanigans([[]])
                ; assert_shenanigans([[],[]])
                ; assert_shenanigans([[],[],[]])
                ; assert_shenanigans([[(Spades, Queen)]])
                ; assert_shenanigans([[(Hearts, King)]])
                ; assert_shenanigans([[(Diamonds, Jack)]])
                ; assert_shenanigans([[(Clubs, Ace)]])
                ; assert_shenanigans([all_clubs])
                ; assert_shenanigans([all_diamonds])
                ; assert_shenanigans([all_hearts])
                ; assert_shenanigans([all_spades])
                ; assert_shenanigans([all_aces])
                ; assert_shenanigans([all_kings])
                ; assert_shenanigans([all_queens])
                ; assert_shenanigans([all_jacks])
                ; assert_shenanigans([all_10s])
                ; assert_shenanigans([all_9s])
                ; assert_shenanigans([all_8s])
                ; assert_shenanigans([all_7s])
                ; assert_shenanigans([all_6s])
                ; assert_shenanigans([all_5s])
                ; assert_shenanigans([all_4s])
                ; assert_shenanigans([all_3s])
                ; assert_shenanigans([all_2s])
                ; assert_shenanigans([all_clubs, all_diamonds])
                ; assert_shenanigans([all_diamonds, all_hearts])
                ; assert_shenanigans([all_hearts, all_spades])

                (* ======================================================== *)
                (* note: there are missing cards, but we fail to detect shenanigans due to all missing Clubs would count for 0 points anyway, so we get the expected result of 16 *)
                ; assert_no_shenanigans([all_diamonds, all_hearts, all_spades]) 
                (* ======================================================== *)
            
                ; assert_no_shenanigans([all_clubs, all_diamonds, all_hearts, all_spades])
                ; assert_shenanigans([all_7s, all_2s])
                ; assert_shenanigans([all_aces, all_kings])
                ; assert_shenanigans([all_aces, all_queens])
                ; assert_shenanigans([all_aces, all_jacks])

                (* ======================================================== *)
                (* note: there are missing cards, but we fail to detect shenanigans due to the ten missing Hearts are counter balanced by the missing Jack of Diamonds, so we get the expected result of 16 *)
                ; assert_no_shenanigans([all_aces, all_kings, all_queens])
                (* ======================================================== *)

                ; assert_shenanigans([all_aces, all_kings, all_queens, all_jacks])
                ; assert_no_shenanigans([all_aces, all_kings, all_queens, all_jacks, all_10s, all_9s, all_8s, all_7s, all_6s, all_5s, all_4s, all_3s, all_2s])
            ; UnitTesting.leave()
            )
        end

    fun test_hearts() =
        ( test_is_card_valid()
        ; test_are_all_cards_valid()
        ; test_card_score()
        ; test_total_score_of_card_list()
        ; test_total_score_of_player_list()
        ; test_total_card_count_for_all_players()
        ; test_is_correct_total_of_cards()
        ; test_is_shenanigans_detected()
        )
end
