structure SumDistancesToOriginPattern = struct
	(* __STUDENT_NAME__ *)

	(* 
	 * note: pattern matching removes any ambiguity of the type of xys, 
	 * thereby addressing the potential unresolved flex record error caused by 
	 * the use of #1 and #2 in warmup_sum_distances_to_origin_fun.
	 * the inferred signature from correctly implemented code which leverages 
	 * pattern matching will be the same as the explicit version 
	 * in warmup_sum_distances_to_origin_fun:
	 * fun sum_distances_to_origin(xys : (real * real) list) : real = 
	 *)
	fun sum_distances_to_origin(xys) =
		raise Fail "NotYetImplemented"

end