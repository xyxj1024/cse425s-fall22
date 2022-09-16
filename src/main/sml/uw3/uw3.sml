(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

(* type point = (int * int)
   type circle = (point * int)

   fun is_overlapping_with_origin(circle_option : circle option) : bool =
       case circle_option of
	       NONE => false
		 | SOME((x,y),radius) => x*x + y*y <= radius*radius

   fun is_radius_42(circle_option : circle option) : bool =
       case circle_option of
	       SOME(_,42) => true
		 | _ => false
 *)

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

datatype typ = Anything       (* any type of value is okay *)
	     | UnitT              (* type of Unit *)
	     | IntT               (* type for integers *)
	     | TupleT of typ list (* tuple types *)
	     | Datatype of string (* some named datatype *)

(**** you can put all your code here ****)

(* Takes a string list and returns a string list that
   has only the strings in the argument that start with
   an uppercase letter. *)
val only_capitals = fn lst =>
	List.filter (fn str => Char.isUpper(String.sub(str, 0))) lst

(* Takes a string list and returns the longest string in the list. *)
val longest_string1 = fn lst =>
	foldl (fn (str, max) => 
		       case (String.size str > String.size max) of 
			       true => str | false => max)
	"" lst

(* In the case of ties, returns the string closest to the end *)
val longest_string2 = fn lst =>
	foldl
	(fn (str, max) =>
		(* >= rather than > *) 
		case (String.size str >= String.size max) of 
			true => str | false => max)
	"" lst

(* (int * int -> bool) -> string list -> string *)
fun longest_string_helper f lst =
	foldl
	(fn (x, y) =>
		(* A more general function*)
		case f (String.size x, String.size y) of 
			true => x | false => y)
	"" lst

(* Has the same behavior as 1; Defined with val-bindings
   and partial applications of the helper function. *)
val longest_string3 =
	longest_string_helper (fn (x, y) => x > y)

(* Has the same behavior as 2; Defined with val-bindings
   and partial applications of the helper function. *)
val longest_string4 =
	longest_string_helper (fn (x, y) => x >= y)

(* Takes a string list and returns the longest string in the list
   that begins with an uppercase letter. *)
val longest_capitalized = longest_string1 o only_capitals

(* Takes a string and returns the string that is the same characters in reverse order *)
val rev_string = implode o rev o explode


(*********************************** Utilities for Pattern Matching *******************************)
(* ('a -> 'b option) -> 'a list -> 'b
   The first argument should be applied to elements of the second argument in order
   until the first time it returns SOME v for some v and then v is the result of the
   call to first_answer. *)
fun first_answer f lst =
	case lst of 
		[] => raise NoAnswer
	  | x::xs => case f x of
	  		SOME v => v
		  | NONE => first_answer f xs

(* ('a -> 'b list option) -> 'a list -> 'b list option *)
fun all_answers f lst =
	let fun aux(f, lst, acc) =
		case lst of
			[] => SOME acc
		  | x::xs => case f x of
		  		SOME v => aux(f, xs, v@acc)
			  | NONE => NONE
	in
		aux(f, lst, [])
	end

(************************************* Pattern and Valu Datatypes ********************************)
(* Given valu v and pattern p, if v matches p, returns a list of string * valu pairs. *)

(* Takes a pattern and returns how many Wildcard patterns it contains. *)
val count_wildcards = g (fn _ => 1) (fn _ => 0)

(* Takes a pattern and returns the number of Wildcard patterns it contains
   plus the sum of the string lengths of all the variables in the variable
   patterns it contains. *)
val count_wild_and_variable_lengths = g (fn _ => 1) String.size

(* Takes a string * pattern pair and returns the number of times the string
   appears as a variable in the pattern. *)
val count_some_var = fn (str, pat) =>
	g (fn _ => 0) (fn x => case x = str of true => 1 | false => 0) pat

(* Takes a pattern and returns true iff all the variables in the pattern 
   use different strings. *)
val check_pat =
		(* Takes a pattern and returns a list of all strings the pattern
		   uses for variables. *)
	let fun get_strlst pat =
		case pat of
			Variable x => [x]
		  | TupleP ps => foldl (fn (p, acc) => (get_strlst p)@acc) [] ps
		  | ConstructorP(_, p) => get_strlst p
		  | _ => []
		(* Takes a list of strings and returns true iff no repeated strings. *)
		fun diff_str lst =
		case lst of
			[] => true | x::xs =>
			case List.exists (fn y => x = y) xs of
		  		false => diff_str xs
			  | true => false
	in
		diff_str o get_strlst
	end

(* Takes a valu * pattern pair and returns a (string * valu) list option:
   NONE if the pattern does not match; SOME lst where lst is the list of bindings. *)
fun match x = (* To recursively call match, avoid the anonymous function binding *)
	case x of
	    (* Wildcard matches everything *)
		(_, Wildcard) => SOME []
	  | (v, Variable s) => SOME [(s, v)]
	    (* UnitP matches only Unit *)
	  | (Unit, UnitP) => SOME []
	    (* int value matches *)
	  | (Const y, ConstP z) => ( case y = z of 
			true => SOME [] 
		  | false => NONE )
	  | (Tuple vs, TupleP ps) => ( case List.length vs = List.length ps of
	    	true => all_answers match (ListPair.zip (vs, ps))
		  | false => NONE )
	  | (Constructor(s, v), ConstructorP(t, p)) => ( case s = t of 
			true => match(v, p)
		  | false => NONE )
	  | _ => NONE

(* Takes a value and a list of patterns and returns a (string * valu) list option *)
fun first_match v lst =
	SOME (first_answer (fn p => match (v, p)) lst)
	handle NoAnswer => NONE

(* ((string * string * typ) list) * (pattern list) -> typ option) *)
val typecheck_patterns = fn _ => NONE

(* Xingjian Xuanyuan *)