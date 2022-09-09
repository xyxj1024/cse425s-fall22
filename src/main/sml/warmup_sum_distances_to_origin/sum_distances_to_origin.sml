(* Xingjian Xuanyuan *)
structure SumDistancesToOrigin = struct

	fun sum_distances_to_origin(xys : (real*real) list) : real =
		if null xys
		then 0.0
		else sum_distances_to_origin(tl xys) + 
			Math.sqrt(#1(hd xys) * #1(hd xys) + #2(hd xys) * #2(hd xys));
end