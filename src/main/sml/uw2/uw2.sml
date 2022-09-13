(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* Xingjian Xuanyuan *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* Returns NONE if str is not in lst, else returns SOME res where res is
   identical to lst except str is not in it. 
   Assume str appears at most once. *)
fun all_except_option(str, lst) =
   case lst of [] => NONE | x::xs =>
      if same_string(str, x) then SOME xs
      else case all_except_option(str, xs) of
         NONE => NONE
       | SOME ys => SOME(x::ys)

(* @param sll - a string list list
   @param str - a string
   Returns a string list containing strings that belong to those sll's string
   lists having str as a member, except str should not be in the result. *)
fun get_substitutions1(sll, str) =
   case sll of [] => [] | x::xs =>
      case all_except_option(str, x) of
         NONE => get_substitutions1(xs, str)
       | SOME ys => ys@get_substitutions1(xs, str)

(* A tail-recursive implementation *)
fun get_substitutions2(sll, str) =
   let fun aux(sll, str, acc) =
      case sll of [] => acc | x::xs =>
         case all_except_option(str, x) of
            NONE => aux(xs, str, acc)
          | SOME ys => aux(xs, str, acc@ys)
   in
      aux(sll, str, [])
   end

(* @param sll - a string list list
   @param fml - {first: string, middle: string, last: string}
   Returns the list of full names that can be produced by substituting for
   the first name only. *)
type full_names = {first:string, middle:string, last:string}
fun similar_names(sll, fml) =
   let
      val {first = f, middle = m, last = l} = fml 
      fun aux(first_names, fml, acc) =
         case first_names of [] => acc | x::xs =>
            aux(xs, fml, acc@[{first = x, last = l, middle = m}])
   in
      aux(get_substitutions2(sll, f), fml, [fml])
   end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
(* Takes a card and returns its color *)
fun card_color(x : card) : color =
   let val (suit, rank) = x
   in
      case suit of
         Clubs => Black
       | Diamonds => Red
       | Hearts => Red
       | Spades => Black
   end

(* Takes a card and returns its value *)
fun card_value(x : card) : int =
   let val (suit, rank) = x
   in
      case rank of
         Ace => 11
       | Num(x) => x
       | Jack => 10
       | Queen => 10
       | King => 10
   end

(* Takes a list of cards cs, a card c, and an exception e
   Returns a list that has all the elements of cs except c. *)
fun remove_card(cs : card list, c : card, e : exn) : card list =
   case cs of [] => raise e | x::xs =>
      if x = c then xs
      else case remove_card(xs, c, e) of
         ys => x::ys

(* Takes a list of cards and returns true if all the cards in the list
   are the same color. *)
fun all_same_color(cs : card list) : bool =
   case cs of [] => true | x::[] => true | head::(neck::rest) =>
      card_color(head) = card_color(neck) andalso all_same_color(neck::rest)

(* Takes a list of cards and returns the sum of their values *)
fun sum_cards(cs : card list) : int =
   case cs of [] => 0 | x::[] => card_value(x) | head::(neck::rest) =>
      card_value(head) + sum_cards(neck::rest)

(* Takes a card list and an int and computes the score. *)
fun score(held : card list, goal : int) : int =
   let fun pre_score(cs) =
      let val sum = sum_cards(cs)
      in
         if sum > goal then 3 * (sum - goal)
         else goal - sum
      end
   in
      if all_same_color(held) then pre_score(held) div 2
      else pre_score(held)
   end

(* Takes a card list, a move list, and an int
   Returns the score at the end of the game after
   processing the moves in the move list in order. *)
fun officiate(cs : card list, mv : move list, goal : int) : int =
   let fun make_move(cs, mv, held) =
      case mv of [] => held | m::ms => 
         case m of
            Discard c => make_move(cs, ms, remove_card(held, c, IllegalMove))
          | Draw => 
            case cs of [] => held | c::_ =>
               if sum_cards(c::held) > goal then c::held
               else make_move(remove_card(cs, c, IllegalMove), ms, c::held)
   in
      score(make_move(cs, mv, []), goal)
   end

(* Each ace can have a value of 1 or 11
   Should always return the best possible score. *)
fun score_challenge(held : card list, goal : int) : int =
   let
      val bench_mark = score(held, goal)
      fun new_score(xs : card list, ys : card list, min : int) : int =
         case xs of 
            [] => min
          | (suit, Ace)::rest =>
            let val cur_score = score(ys@[(suit, Num 1)]@rest, goal)
            in
               if min > cur_score
               then new_score(rest, ys@[(suit, Num 1)], cur_score)
               else new_score(rest, ys@[(suit, Ace)], min)
            end
         (* This branch should be placed here to avoid match redundancy *)
          | c::rest => new_score(rest, ys@[c], min)
   in
      new_score(held, [], bench_mark)
   end


fun officiate_challenge(cs : card list, mv : move list, goal : int) : int =
   let fun make_move(cs, mv, held) =
      case mv of [] => held | m::ms => 
         case m of
            Discard c => make_move(cs, ms, remove_card(held, c, IllegalMove))
          | Draw => 
            case cs of [] => held | c::_ =>
               if sum_cards(c::held) > goal then c::held
               else make_move(remove_card(cs, c, IllegalMove), ms, c::held)
   in
      score_challenge(make_move(cs, mv, []), goal)
   end

(* Takes a card list and a goal and returns a move list *)
fun careful_player(cs : card list, goal : int) : move list =
   let 
      (* Returns a (to be discarded) card option *)
      fun discard(xs, held::held_rest, card::card_rest) =
         if score(card::xs@held_rest, goal) = 0
         then SOME held
         else discard(held::xs, held_rest, card::card_rest)
        | discard(_) = NONE

      (* Returns a move list *)
      fun make_move(held_list, card_list) =
         case card_list of [] => [] | y::ys =>
            (* No more moves after reaching zero *)
            if score(held_list, goal) = 0 then []
            else case discard([], held_list, y::ys) of
               SOME c => [Discard c, Draw]
             | NONE =>
               (* A card is drown whenever the goal is more than 10 
                  greater than the value of the held cards. *)
               if goal <= 10 + sum_cards(held_list)
               then []
               else Draw::make_move(y::held_list, ys)
   in
      make_move([], cs)
   end