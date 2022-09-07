(* Dennis Cosgrove *)
structure IsStrictlyAscendingFunTesting = IsStrictlyAscendingTestingFn (struct
	val function = IsStrictlyAscendingFun.is_strictly_ascending
	val function_name = "is_strictly_ascending"
end)
