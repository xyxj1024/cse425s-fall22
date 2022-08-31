(* Wed August 31 2022 *)
(* SML comes with a length function *)
(* http://sml-family.org/Basis/list.html#SIG:LIST.length:VAL *)
val length = "shadow built-in length function to prevent mistakenly calling it"

structure MyLength = struct
	(* Xingjian *)

	(* define a function my_length which returns the length of the specified list *)
	fun my_length(values) =
		if null values
		then 0
		else if null (tl values)
		then 1
		else
			let val tl_ans = my_length(tl values)
			in
				1 + tl_ans
			end
end
