(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* __STUDENT_NAME__ *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

val all_except_option = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function all_except_option."

val get_substitutions1 = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function get_substitutions1."

val get_substitutions2 = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function get_substitutions2."

val similar_names = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function similar_names."


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

val card_color = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function card_color."

val card_value = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function card_value."

val remove_card = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function remove_card."

val all_same_color = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function all_same_color."

val sum_cards = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function sum_cards."

val score = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function score."

val officiate = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function officiate."

val score_challenge = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function score_challenge."

val officiate_challenge = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function officiate_challenge."

val careful_player = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function careful_player."

