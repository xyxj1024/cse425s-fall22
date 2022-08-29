signature PREDICATE_TESTING_FN = sig
    type param_type
	val assert_true : param_type -> unit
	val assert_false : param_type -> unit
end