(* Dennis Cosgrove *)
structure SortedDictionaryTesting : sig 
	val test : bool -> unit
end = struct
	structure SDTesting = DictionaryTestingFn(
		structure Dictionary = SortedDictionary
		val DictionaryName = "SortedDictionary"
		val strictness_level = ListStrictness.EXACT_MATCH_OF_SORTED_EXPECTED
	)

	fun test(is_remove_testing_desired) =
		SDTesting.test_dictionary(Random.rand(425, 231), is_remove_testing_desired, "", 
			("String.compare", String.compare),
			("Int.compare", Int.compare)
		)
end
