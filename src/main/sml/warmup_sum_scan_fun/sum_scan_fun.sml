(* Wed August 31, 2022 *)
(* Xingjian *)
structure SumScanFun = struct

	fun sum_scan(xs : int list) : int list =
		(* raise Fail "NotYetImplemented" *)
		if null xs
		then []
		else if null (tl xs)
		then [hd xs]
		else
			let val tl_ans = sum_scan(hd xs + hd (tl xs) :: tl(tl xs))
			in
				hd xs :: tl_ans
			end
			
end