(* Dennis Cosgrove *)
structure ChainedTesting : sig
	val test_single_chain_if_desired : unit -> unit
	val test_chained : unit -> unit
end = struct
	val is_single_list_testing_desired = CommandLineArgs.getBoolOrDefault("single_list", true)
	val is_hashed_testing_desired = CommandLineArgs.getBoolOrDefault("hashed", true)

	fun test_single_chain_if_desired() =
		if is_single_list_testing_desired 
		then SingleChainedDictionaryTesting.test()
		else ()

	fun test_hashed_if_desired() =
		if is_hashed_testing_desired 
		then HashedDictionaryTesting.test()
		else ()

	fun test_chained() =
        ( test_single_chain_if_desired() 
        ; test_hashed_if_desired()
		)
end
