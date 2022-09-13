structure EliminateUnsorted = struct
	(* Xingjian Xuanyuan *)

    fun eliminate_unsorted(xs : int list) : int list =
		case xs of [] => [] | y::ys =>
			let fun iterate(ys, max) =
				case ys of [] => [] | z::zs =>
					if z < max then iterate(zs, max)
					else z::iterate(zs, z)
		in
			iterate(xs, y)
		end
end
