structure ClosestToOrigin = struct

    (* Xingjian Xuanyuan *)
    fun closest_to_origin(xys : (real*real) list) : (real*real) option =
    	case xys of
    	  nil => NONE
		| [x] => SOME x
    	| (head :: tail) =>
			let val res = closest_to_origin(tail)
				val min = Math.sqrt((#1 (valOf res)) * (#1 (valOf res)) + (#2 (valOf res)) * (#2 (valOf res)))
				val tmp = Math.sqrt((#1 head) * (#1 head) + (#2 head) * (#2 head))
			in
				if tmp < min
				then SOME head
				else res
			end
end