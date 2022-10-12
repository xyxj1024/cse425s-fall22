structure StringIntEntryTesting = EqualityTestingFn (struct
	type t = string * int
	val toString = fn (text, n)=> "(\"" ^ text ^ "\", " ^ Int.toString(n) ^ ")"
	val compare = fn((ak,_),(bk,_)) => String.compare(ak,bk)
end)
