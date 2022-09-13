(* Xingjian Xuanyuan *)
structure SumScanPattern = struct
	fun sum_scan(xs : int list) : int list =
		case xs of [] => [] | y::ys =>
			case ys of [] => [y] | z::zs =>
				let val res = sum_scan((y + z)::zs)
				in y::res
				end
end
