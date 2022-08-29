signature PREDICATE_TESTING_PARAMETER = sig
    type param_type
    val evaluate : param_type -> bool
    val to_string_from_param : param_type -> string
end