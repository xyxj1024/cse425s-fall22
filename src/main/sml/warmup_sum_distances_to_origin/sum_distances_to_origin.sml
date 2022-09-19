(* Xingjian Xuanyuan *)
structure SumDistancesToOrigin = struct

	fun sum_distances_to_origin(xys : (real*real) list) : real =
		let fun aux(ps, acc) =
			case ps of [] => acc | (p1, p2)::ps' =>
				aux(ps', acc + Math.sqrt(p1*p1 + p2*p2))
		in aux(xys, 0.0)
		end

end