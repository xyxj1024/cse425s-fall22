structure ScanHof = struct
	(* Xingjian Xuanyuan *)
	fun scan operation values =
		let fun scan(acc, lst) =
			case (acc, lst) of
				(acc, []) => acc
			  | ([], head::rest) => scan([head], rest)
			  | (y::ys, head::rest) => scan(operation(y, head)::y::ys, rest)
		in
			List.rev(scan([], values))
		end
end