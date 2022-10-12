structure HashedDictionaryTesting = struct
	structure HDTesting = DictionaryTestingFn(
		structure Dictionary = HashedDictionary
		val DictionaryName = "HashedDictionary"
		val strictness_level = ListStrictness.ANY_ORDER
	)
	fun test() =
		let
			fun string_hash(x : string) = 
				let
					val w = HashString.hashString(x)
				in
					Word.toInt(
						case Int.maxInt of
							NONE => w
						| SOME(max_int) => Word.mod(w, Word.fromInt(max_int))
					)
				end
			
			(*
			fun pessimal_hash(x : 'a) : int = 0 
			*)

			fun test(bucket_count) =
				HDTesting.test_dictionary(Random.rand(231425, 425231), true, "with bucket_count="^Int.toString(bucket_count), 
					(Int.toString(bucket_count) ^ ", string_hash", (bucket_count, string_hash)),
					(Int.toString(bucket_count) ^ ", fn(x)=>x", (bucket_count, fn(x)=>x))
				)
		in
			( test(1)
			; test(2)
			; test(16)
			)
		end
end