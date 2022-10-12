(* Xingjian Xuanyuan *)
structure SumScanNoIdentityElement = struct
	(* the identity element for addition is 0 *)
	(* https://en.wikipedia.org/wiki/Identity_element *)
	(* refrain from using 0 in this solution of sum_scan *)
	fun sum_scan(xs : int list) : int list =
		let
			fun sum_scan_helper(lst, prev, acc) =
				case lst of
					[] => acc
				| h::t => sum_scan_helper(t, h + prev, acc@[h + prev])
		in
			case xs of
				[] => []
			| h'::t' =>
			  	case t' of
            [] => [h']
          | th'::tt' => sum_scan_helper(tt', h' + th', [h']@[h' + th'])
		end
end
