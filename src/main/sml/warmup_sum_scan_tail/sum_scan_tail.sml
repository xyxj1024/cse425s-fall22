(* Mon September 19, 2022 *)
structure SumScanTail = struct
	(* Xingjian Xuanyuan *)
	fun sum_scan(xs : int list) : int list =
		(* raise Fail "NotYetImplemented" *)
		let fun aux(xs, acc, tail) =
			case xs of [] => acc | y::ys =>
				case ys of [] => acc@[y + tail] | z::zs =>
					aux(zs, acc@[y + tail]@[y + z + tail], (y + z + tail))
		in aux(xs, [], 0)
		end
end