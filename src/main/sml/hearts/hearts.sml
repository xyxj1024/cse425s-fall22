structure Hearts = struct
  datatype suit = Clubs | Diamonds | Hearts | Spades
  datatype rank = Jack | Queen | King | Ace | Num of int 
  type card = suit * rank
  type player = card list

  (* __STUDENT_NAME__ *)
  fun is_card_valid(c : card) : bool =
  	raise Fail "NotYetImplemented"

  fun are_all_cards_valid(taken_cards : card list) : bool =
  	raise Fail "NotYetImplemented"

  fun card_score(c : card) : int =
  	raise Fail "NotYetImplemented"

  fun total_score_of_card_list(cards : card list) : int =
  	raise Fail "NotYetImplemented"

  fun total_score_of_player_list(players : player list) : int =
  	raise Fail "NotYetImplemented"

  fun total_card_count_for_all_players(players : player list) : int =
  	raise Fail "NotYetImplemented"

  fun is_correct_total_of_cards(players : player list) : bool =
  	raise Fail "NotYetImplemented"

  fun is_shenanigans_detected(players : player list) =
  	raise Fail "NotYetImplemented"

end