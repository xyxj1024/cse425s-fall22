structure IsStrictlyAscendingFun = struct
	(* Xingjian *)

    fun is_strictly_ascending(xs : int list) : bool =
		let fun compare_hd(ys : int list) : bool =
				if null (tl ys)
				then true
				else if hd ys < hd (tl ys)
				then compare_hd(tl ys)
				else false
		in
			if null xs orelse null (tl xs)
			then true
			else compare_hd(xs)
		end
end
