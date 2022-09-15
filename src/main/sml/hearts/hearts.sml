structure Hearts = struct
  datatype suit = Clubs | Diamonds | Hearts | Spades
  datatype rank = Jack | Queen | King | Ace | Num of int 
  type card = suit * rank
  type player = card list

  (* Xingjian Xuanyuan *)

  (* Returns false if the int value of Num < 2 or > 10; otherwise, true. *)
  fun is_card_valid(c : card) : bool =
      let val (s, r) = c
      in
          case r of Num(x) =>
              if x < 2 orelse x > 10
              then false
              else true
          | _ => true
      end

  (* Returns false if any of the cards in the list are invalid;
     otherwise true. *)
  fun are_all_cards_valid(taken_cards : card list) : bool =
      case taken_cards of 
          [] => true
        | head::rest => 
              if is_card_valid(head)
              then are_all_cards_valid(rest)
              else false

  fun card_score(c : card) : int =
      (* let val (s, r) = c
      in
          case s of
              Spades => if r = Queen then 13 else 0
            | Diamonds => if r = Jack then ~10 else 0
            | Hearts => 1
            | Clubs => 0
      end *)
      case c of
          (Spades, Queen) => 13
        | (Diamonds, Jack) => ~10
        | (Hearts, _) => 1
        | (_, _) => 0

  (* Returns the sum of the scores of cards. *)
  fun total_score_of_card_list(cards : card list) : int =
      (* case cards of [] => 0
      | (head::rest) => card_score(head) + total_score_of_card_list(rest) *)
      let fun aux(cs, acc) =
          case cs of [] => acc
          | (head::tail) => aux(tail, card_score(head) + acc)
      in aux(cards, 0)
      end

  (* Returns the sum of scores of players. *)
  fun total_score_of_player_list(players : player list) : int =
      let fun aux(ps, acc) =
          case ps of [] => acc
          | (head::tail) => aux(tail, total_score_of_card_list(head) + acc)
      in aux(players, 0)
      end

  (* Returns the total number of cards of players. *)
  fun total_card_count_for_all_players(players : player list) : int =
      let 
          fun len(xs, acc) = 
              case xs of [] => acc
              | (head::tail) => len(tail, acc + 1)

          fun aux(f, xs, acc) =
              case xs of [] => acc
              | (head::tail) => aux(f, tail, f(head, 0) + acc)
      in
          aux(len, players, 0)
      end

  (* Returns true if the total number of cards of players is 52;
     otherwise false. *)
  fun is_correct_total_of_cards(players : player list) : bool =
      if total_card_count_for_all_players(players) = 52
      then true
      else false

  (* Returns true if the total points of players is not 16;
     otherwise fakse. *)
  fun is_shenanigans_detected(players : player list) =
      if total_score_of_player_list(players) <> 16
      then true
      else false
      
end