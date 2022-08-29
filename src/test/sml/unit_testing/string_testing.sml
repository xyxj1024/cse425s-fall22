structure StringTesting = EqualityTestingFn (struct
	type t = String.string
	fun toString(s) = 
		"\"" ^ s ^ "\""
	val compare = String.compare
end)
