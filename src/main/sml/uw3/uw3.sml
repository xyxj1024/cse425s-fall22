(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

val only_capitals = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function only_capitals."

val longest_string1 = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function longest_string1."

val longest_string2 = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function longest_string2."

val longest_string_helper = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function longest_string_helper."

val longest_string3 = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function longest_string3."

val longest_string4 = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function longest_string4."

val longest_capitalized = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function longest_capitalized."

val rev_string = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function rev_string."

val first_answer = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function first_answer."

val all_answers = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function all_answers."

val count_wildcards = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function count_wildcards."

val count_wild_and_variable_lengths = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function count_wild_and_variable_lengths."

val count_some_var = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function count_some_var."

val check_pat = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function check_pat."

val match = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function match."

val first_match = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function first_match."

val typecheck_patterns = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function typecheck_patterns."

(* __STUDENT_NAME__ *)

