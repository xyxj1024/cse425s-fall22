structure SingleChainedDictionaryTesting = struct
	structure SCDTesting = DictionaryTestingFn(
		structure Dictionary = SingleChainedDictionary
		val DictionaryName = "SingleChainedDictionary"
		val strictness_level = ListStrictness.ANY_ORDER
	)
	fun test() =
		SCDTesting.test_dictionary(Random.rand(231, 425), true, "", 
			("", ()),
			("", ())
		)
end