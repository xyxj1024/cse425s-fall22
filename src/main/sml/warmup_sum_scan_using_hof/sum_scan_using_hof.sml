structure SumScanUsingHof = struct
	(* Xingjian Xuanyuan *)
	fun sum_scan(xs : int list) : int list =
		let fun scan(acc, lst) =
			case (acc, lst) of
				(acc, []) => acc
			  | ([], head::rest) => scan([head], rest)
			  | (y::ys, head::rest) => scan((y + head)::y::ys, rest)
		in
			List.rev(scan([], xs))
		end
end