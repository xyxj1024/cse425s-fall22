signature EQUALITY_TESTING = sig include TO_STRING_EQ
    val assertEvalEqualsWithMessage : t * (unit -> t) * string -> unit
    val assertEvalEquals : t * (unit -> t) -> unit
    val assertEqualsWithMessage : t * t * string -> unit
    val assertEquals : t * t -> unit

    val assertOptionEvalEquals : t option * (unit -> t option) -> unit
    val assertOptionEvalEqualsWithMessage : t option * (unit -> t option) * string -> unit
    val assertOptionEquals : t option * t option -> unit
    val assertOptionEqualsWithMessage : t option * t option * string -> unit

	val assertListEvalPassesStrictnessLevel : t list * (unit -> t list) * ListStrictness.level -> unit
	val assertListEvalPassesStrictnessLevelWithMessage : t list * (unit -> t list) * ListStrictness.level * string -> unit
	val assertListPassesStrictnessLevel : t list * t list * ListStrictness.level -> unit
	val assertListPassesStrictnessLevelWithMessage : t list * t list * ListStrictness.level * string -> unit

    val assertListEvalEquals : t list * (unit -> t list) -> unit
    val assertListEvalEqualsWithMessage : t list * (unit -> t list) * string -> unit
    val assertListEquals : t list * t list -> unit
    val assertListEqualsWithMessage : t list * t list * string -> unit

    val assertListEvalEqualsAnyOrderWithMessage : (t list * (unit -> t list) * string) -> unit
    val assertListEvalEqualsAnyOrder : (t list * (unit -> t list)) -> unit
    val assertListEqualsAnyOrderWithMessage : (t list * t list * string) -> unit
    val assertListEqualsAnyOrder : (t list * t list) -> unit

    val assertListEvalEqualsSortedExpectedWithMessage : (t list * (unit -> t list) * string) -> unit
    val assertListEvalEqualsSortedExpected : (t list * (unit -> t list)) -> unit
    val assertListEqualsSortedExpectedWithMessage : (t list * t list * string) -> unit
    val assertListEqualsSortedExpected : (t list * t list) -> unit

    val assertListListEvalEquals : t list list * (unit -> t list list) -> unit
    val assertListListEvalEqualsWithMessage : t list list * (unit -> t list list) * string -> unit
    val assertListListEquals : t list list * t list list -> unit
    val assertListListEqualsWithMessage : t list list * t list list * string -> unit
(*
    val assertEqualsOneOf : (''a->string) -> (''a list * ''a) -> unit
    val assertEqualsForwardOrReverse : (''a list->string) -> (''a list * ''a list) -> unit

    val assertEqualsAnyOrder_Option : (''a list option->string) -> ((''a * ''a) -> bool) -> (''a list option * ''a list option) -> unit
*)

    val assertListOptionEvalEquals : (t list option * (unit -> t list option)) -> unit
    val assertListOptionEvalEqualsWithMessage : (t list option * (unit -> t list option) * string) -> unit
    val assertListOptionEquals : (t list option * t list option) -> unit
    val assertListOptionEqualsWithMessage : (t list option * t list option * string) -> unit

    val assertListOptionEvalEqualsAnyOrder : (t list option * (unit -> t list option)) -> unit
    val assertListOptionEvalEqualsAnyOrderWithMessage : (t list option * (unit -> t list option) * string) -> unit
    val assertListOptionEqualsAnyOrder : (t list option * t list option) -> unit
    val assertListOptionEqualsAnyOrderWithMessage : (t list option * t list option * string) -> unit
end