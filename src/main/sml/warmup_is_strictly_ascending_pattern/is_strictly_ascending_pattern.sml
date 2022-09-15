structure IsStrictlyAscendingPattern = struct
	(* Xingjian Xuanyuan *)

    fun is_strictly_ascending(xs : int list) : bool =
		let fun compare_hd(head::rest : int list) : bool =
			case rest of [] => true
			| z::zs => 
				if head < z
				then compare_hd(rest)
				else false
		in
			case xs of [] => true
			| x::[] => true
			| _ => compare_hd(xs)
		end
end
