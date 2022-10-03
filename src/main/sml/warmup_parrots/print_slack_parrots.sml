(* Dennis Cosgrove *)
CM.make "../warmup_mutable_list/mutable_list.cm";

open MutableList

fun millisecs_as_int() =
	let
		val t = Time.now()
		val millisec_as_large_int = Time.toMilliseconds(t)
		val millisec_as_large_int_that_wont_overflow = LargeInt.mod(millisec_as_large_int, 1000)
	in
		Int.fromLarge(millisec_as_large_int_that_wont_overflow)
	end

val rnd = Random.rand(425, millisecs_as_int())
fun random_parrot() =
	case Random.randNat(rnd) mod 4 of
	  0 => PARTY
	| 1 => SHUFFLE
	| 2 => PORTAL_BLUE_LEFT
	| _ => PORTAL_ORANGE_RIGHT

val a_parrots = construct_with_parrot(random_parrot())
val _ = add_to_front(a_parrots, random_parrot())
val _ = add_to_back(a_parrots, random_parrot())
val b_parrots = construct_from_immutable([random_parrot(), random_parrot(), random_parrot(), random_parrot(), random_parrot()])
val parrots = a_parrots @ b_parrots

fun parrot_to_slack(PARTY) = ":party_parrot:"
  | parrot_to_slack(SHUFFLE) = ":shuffleparrot:"
  | parrot_to_slack(PORTAL_BLUE_LEFT) = ":portal_blue_parrot:"
  | parrot_to_slack(PORTAL_ORANGE_RIGHT) = ":portal_orange_parrot:"

fun to_slack(parrot, acc) =
	acc ^ parrot_to_slack(parrot) ^ " "

val s = foldl(to_slack, "", parrots)

val _ = print("\n\n\n" ^ s ^ "\n\n\n")
val _ = OS.Process.exit(OS.Process.success)