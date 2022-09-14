(* Dennis Cosgrove *)
structure IsStrictlyAscendingPatternTesting = IsStrictlyAscendingTestingFn (struct
	val function = IsStrictlyAscendingPattern.is_strictly_ascending
	val function_name = "is_strictly_ascending"
end)
