signature DICT_TESTING_COMMON = sig 
	structure Dictionary : DICTIONARY
	val DictionaryName : string
	eqtype key_type
	eqtype value_type
	val strictness_level : ListStrictness.level
	val KeyTesting_toString : key_type -> string;
	val ValueTesting_toString : value_type -> string;
	val ValueTesting_toStringFromList : value_type list -> string;
end

signature DICT_TESTING_PARAMETER = sig include DICT_TESTING_COMMON
	val ValueTesting_assertOptionEvalEqualsWithMessage : value_type option * (unit -> value_type option) * string -> unit;
	val KeyTesting_assertListEvalPassesStrictnessLevelWithMessage : key_type list * (unit -> key_type list) * ListStrictness.level * string -> unit;
	val ValueTesting_assertListEvalPassesStrictnessLevelWithMessage : value_type list * (unit -> value_type list) * ListStrictness.level * string -> unit;
	val EntryTesting_assertListEvalPassesStrictnessLevelWithMessage : (key_type * value_type) list * (unit ->  (key_type * value_type) list) * ListStrictness.level * string -> unit;
end

signature DICT_TESTING = sig include DICT_TESTING_COMMON
    val assert_create_completion : string * key_type Dictionary.create_parameter_type -> (key_type,value_type) Dictionary.dictionary
    val assert_get : value_type option * string * (key_type, value_type) Dictionary.dictionary * key_type -> unit
    val assert_put : value_type option * string * (key_type,value_type) Dictionary.dictionary * key_type * value_type -> (key_type,value_type) Dictionary.dictionary
    val assert_remove : value_type option * string * (key_type,value_type) Dictionary.dictionary * key_type -> (key_type,value_type) Dictionary.dictionary
    val assert_keys_strictness_level : key_type list * string * (key_type,value_type) Dictionary.dictionary -> unit
    val assert_values_strictness_level : value_type list * string * (key_type,value_type) Dictionary.dictionary -> unit
    val assert_entries_strictness_level : (key_type * value_type) list * string * (key_type,value_type) Dictionary.dictionary -> unit
    val assert_keys_exact_match : key_type list * string * (key_type,value_type) Dictionary.dictionary -> unit
    val assert_values_exact_match : value_type list * string * (key_type,value_type) Dictionary.dictionary -> unit
    val assert_entries_exact_match : (key_type * value_type) list * string * (key_type,value_type) Dictionary.dictionary -> unit
end

functor DictTestingFn(DictTestingParameter : DICT_TESTING_PARAMETER) : DICT_TESTING = struct

	open DictTestingParameter

	(* note: investigate better support for sorted values by their keys *)
	val strictness_level = if strictness_level = ListStrictness.ANY_ORDER then ListStrictness.ANY_ORDER else ListStrictness.EXACT_MATCH  (* note: value strictness does not sort *)

	fun assert_create_completion(arg_text, arg) = 
		CompletionTesting.assertEvalCompletionWithMessage(
			fn() => Dictionary.create(arg),
			DictionaryName ^ ".create(" ^ arg_text ^ ")"
		)

	fun assert_get(expected, dict_binding, dict, key) = 
		ValueTesting_assertOptionEvalEqualsWithMessage(
			expected, 
			fn() => Dictionary.get(dict, key),
			DictionaryName ^ ".get(" ^ dict_binding ^ ", " ^ KeyTesting_toString(key) ^ ")"
		)

	fun assert_put(expected_prev, dict_binding, dict, key, value) = 
		let
            val dict_prime_ref = ref dict
			fun f() =
				let
					val (dict', prev) = Dictionary.put(dict, key, value)
					val _ = dict_prime_ref := dict'
				in
					prev
				end
			val _ = 
				ValueTesting_assertOptionEvalEqualsWithMessage(
					expected_prev, 
					f,
					DictionaryName ^ ".put(" ^ dict_binding ^ ", " ^ KeyTesting_toString(key) ^ ", " ^ ValueTesting_toString(value) ^ ")"
				)
		in
			!dict_prime_ref
		end
	
	fun assert_remove(expected_prev, dict_binding, dict, key) = 
		let
            val dict_prime_ref = ref dict
			fun f() =
				let
					val (dict', prev) = Dictionary.remove(dict, key)
					val _ = dict_prime_ref := dict'
				in
					prev
				end
			val _ = 
				ValueTesting_assertOptionEvalEqualsWithMessage(
					expected_prev, 
					f,
					DictionaryName ^ ".remove(" ^ dict_binding ^ ", " ^ KeyTesting_toString(key) ^ ")"
				)
		in
			!dict_prime_ref
		end

	fun assert_keys_strictness strictness (expected, dict_binding, dict) =
		KeyTesting_assertListEvalPassesStrictnessLevelWithMessage(
			expected, 
			fn() => Dictionary.keys(dict),
			strictness,
			DictionaryName ^ ".keys(" ^ dict_binding ^ ")"
		)

	fun assert_values_strictness strictness (expected, dict_binding, dict) =
		ValueTesting_assertListEvalPassesStrictnessLevelWithMessage(
			expected, 
			fn() => Dictionary.values(dict),
			strictness,
			DictionaryName ^ ".values(" ^ dict_binding ^ ")"
		)

	fun assert_entries_strictness strictness (expected, dict_name, dict) =
		EntryTesting_assertListEvalPassesStrictnessLevelWithMessage(
			expected, 
			fn() => Dictionary.entries(dict),
			strictness,
			DictionaryName ^ ".entries(" ^ dict_name ^ ")"
		)

	fun assert_keys_strictness_level(expected, dict_binding, dict) = 
		assert_keys_strictness strictness_level (expected, dict_binding, dict)

	fun assert_values_strictness_level(expected, dict_binding, dict) = 
		assert_values_strictness strictness_level (expected, dict_binding, dict)

	val assert_entries_strictness_level = assert_entries_strictness strictness_level

	fun assert_keys_exact_match(expected, dict_binding, dict) = 
		assert_keys_strictness ListStrictness.EXACT_MATCH (expected, dict_binding, dict)

	fun assert_values_exact_match(expected, dict_binding, dict) = 
		assert_values_strictness ListStrictness.EXACT_MATCH (expected, dict_binding, dict)

	val assert_entries_exact_match = assert_entries_strictness ListStrictness.EXACT_MATCH
end
