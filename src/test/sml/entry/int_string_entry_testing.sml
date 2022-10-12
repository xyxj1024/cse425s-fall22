structure IntStringEntryTesting = EqualityTestingFn (struct
	type t = int * string
	val toString = fn (n, text)=> "(" ^ Int.toString(n) ^ ", \"" ^ text ^ "\")"
	val compare = fn((ak,_),(bk,_)) => Int.compare(ak,bk)
end)
