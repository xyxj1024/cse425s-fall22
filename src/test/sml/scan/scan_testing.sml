structure ScanTesting :> sig
    val test_scan : unit -> unit
end = struct
	structure SumScanViaCurriedScanTesting = SumScanTestingFn (struct
		(* val function = ScanHof.scan op+ *)
		(* function wrap necessitated by value restriction *)
		fun function(values) = 
			ScanHof.scan op+ values
		val function_name = "scan op+"
		val is_curried = true
	end)

	open ScanHof

	fun test_product_scan() =
		let
            fun assert_product_scan(expected, xs) = 
                IntTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => scan op* xs, 
                    "scan op* " ^ IntTesting.toStringFromList(xs)
                )
		in
			( UnitTesting.enter("scan Int.min")
				; assert_product_scan([], [])
				; assert_product_scan([0], [0])
				; assert_product_scan([1], [1])
				; assert_product_scan([231], [231])
				; assert_product_scan([425], [425])
				; assert_product_scan([0, 0], [0, 0])
				; assert_product_scan([0, 0], [0, 1])
				; assert_product_scan([1, 0], [1, 0])
				; assert_product_scan([0, 0], [0, 425])
				; assert_product_scan([425, 0], [425, 0])
				; assert_product_scan([1, 10], [1, 10])
				; assert_product_scan([10, 10], [10, 1])
				; assert_product_scan([1, 2], [1, 2])
				; assert_product_scan([2, 8], [2, 4])
				; assert_product_scan([231, 98175], [231, 425])
				; assert_product_scan([0, 0, 0], [0, 0, 0])
				; assert_product_scan([0, 0, 0], [0, 0, 425])
				; assert_product_scan([0, 0, 0], [0, 425, 0])
				; assert_product_scan([425, 0, 0], [425, 0, 0])
				; assert_product_scan([1, 2, 6], [1, 2, 3])
				; assert_product_scan([131, 30261, 12860925], [131, 231, 425])
				; assert_product_scan([1, 2, 6, 24, 120], [1, 2, 3, 4, 5])
				; assert_product_scan([5, 20, 60, 120, 120], [5, 4, 3, 2, 1])
				; assert_product_scan([7, 49, 343, 31899, 350889], [7, 7, 7, 93, 11])
			; UnitTesting.leave() )
		end

	fun test_min_scan() =
		let
            fun assert_min_scan(expected, xs) = 
                IntTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => scan Int.min xs, 
                    "scan Int.min " ^ IntTesting.toStringFromList(xs)
                )
		in
			( UnitTesting.enter("scan Int.min")
				; assert_min_scan([], [])
				; assert_min_scan([0], [0])
				; assert_min_scan([1], [1])
				; assert_min_scan([231], [231])
				; assert_min_scan([425], [425])
				; assert_min_scan([0, 0], [0, 0])
				; assert_min_scan([0, 0], [0, 1])
				; assert_min_scan([1, 0], [1, 0])
				; assert_min_scan([0, 0], [0, 425])
				; assert_min_scan([425, 0], [425, 0])
				; assert_min_scan([1, 1], [1, 10])
				; assert_min_scan([10, 1], [10, 1])
				; assert_min_scan([1, 1], [1, 2])
				; assert_min_scan([2, 2], [2, 4])
				; assert_min_scan([231, 231], [231, 425])
				; assert_min_scan([0, 0, 0], [0, 0, 0])
				; assert_min_scan([0, 0, 0], [0, 0, 425])
				; assert_min_scan([0, 0, 0], [0, 425, 0])
				; assert_min_scan([425, 0, 0], [425, 0, 0])
				; assert_min_scan([1, 1, 1], [1, 2, 3])
				; assert_min_scan([131, 131, 131], [131, 231, 425])
				; assert_min_scan([1, 1, 1, 1, 1], [1, 2, 3, 4, 5])
				; assert_min_scan([5, 4, 3, 2, 1], [5, 4, 3, 2, 1])
				; assert_min_scan([7, 7, 7, 7, 7], [7, 7, 7, 93, 11])
			; UnitTesting.leave() )
		end

	fun test_max_scan() =
		let
            fun assert_max_scan(expected, xs) = 
                IntTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => scan Int.max xs, 
                    "scan Int.max " ^ IntTesting.toStringFromList(xs)
                )
		in
			( UnitTesting.enter("scan Int.min")
				; assert_max_scan([], [])
				; assert_max_scan([0], [0])
				; assert_max_scan([1], [1])
				; assert_max_scan([231], [231])
				; assert_max_scan([425], [425])
				; assert_max_scan([0, 0], [0, 0])
				; assert_max_scan([0, 1], [0, 1])
				; assert_max_scan([1, 1], [1, 0])
				; assert_max_scan([0, 425], [0, 425])
				; assert_max_scan([425, 425], [425, 0])
				; assert_max_scan([1, 10], [1, 10])
				; assert_max_scan([10, 10], [10, 1])
				; assert_max_scan([1, 2], [1, 2])
				; assert_max_scan([2, 4], [2, 4])
				; assert_max_scan([231, 425], [231, 425])
				; assert_max_scan([0, 0, 0], [0, 0, 0])
				; assert_max_scan([0, 0, 425], [0, 0, 425])
				; assert_max_scan([0, 425, 425], [0, 425, 0])
				; assert_max_scan([425, 425, 425], [425, 0, 0])
				; assert_max_scan([1, 2, 3], [1, 2, 3])
				; assert_max_scan([131, 231, 425], [131, 231, 425])
				; assert_max_scan([1, 2, 3, 4, 5], [1, 2, 3, 4, 5])
				; assert_max_scan([5, 5, 5, 5, 5], [5, 4, 3, 2, 1])
				; assert_max_scan([7, 7, 7, 93, 93], [7, 7, 7, 93, 11])
			; UnitTesting.leave() )
		end

	fun binding_to_set_operation(binding) =
		(* bug in string literal pattern matching on windows
		   does not seem to be tripped by this particular set of strings.
		   however, we use elect to use if/elseif anyway *)
		if binding = "intersection" then IntRedBlackSet.intersection
		else if binding = "union" then IntRedBlackSet.union
		else raise Fail binding
		(* case binding of
		  "intersection" => IntRedBlackSet.intersection
		| "union" => IntRedBlackSet.union
		| _ => raise Fail binding *)

	fun assert_set_operation_scan set_operation_name (expected_list_of_lists, list_of_lists) =
		let
			val list_of_sets = map IntRedBlackSet.fromList list_of_lists
			val set_operation = binding_to_set_operation(set_operation_name)
		in
			IntTesting.assertListListEvalEqualsWithMessage(
				expected_list_of_lists, 
				fn() =>  map IntRedBlackSet.listItems (scan set_operation list_of_sets), 
				"scan " ^ set_operation_name ^ " " ^ IntTesting.toStringFromListList(list_of_lists)
			)
		end

	val assert_set_intersection_scan = assert_set_operation_scan "intersection"
	val assert_set_union_scan = assert_set_operation_scan "union"

	fun test_set_intersection_scan() =
		( UnitTesting.enter("scan IntRedBlackSet.intersection")

			; assert_set_intersection_scan(
				[], 
				[]
			)
			; assert_set_intersection_scan(
				[ [] ], 
				[ [] ]
			)
			; assert_set_intersection_scan(
				[ [1,2,3] ], 
				[ [1,2,3] ]
			)
			; assert_set_intersection_scan(
				[ [1,2,3], [] ],
				[ [1,2,3], [] ]
			)

			; assert_set_intersection_scan(
				[[], []], 
				[[], [1,2,3]]
			)
			
			; assert_set_intersection_scan(
				[[1,2,3], []], 
				[[1,2,3], [4,5,6]]
			)
			
			; assert_set_intersection_scan(
				[[1,2,3], [1,2,3]], 
				[[1,2,3], [1,2,3]]
			)

			; assert_set_intersection_scan(
				[[1,2,3], [2,3]], 
				[[1,2,3], [2,3,4]]
			)
			
			; assert_set_intersection_scan(
				[[1,2,3,4,5], [2,3,4], [2]], 
				[[1,2,3,4,5], [2,3,4], [0,1,2]]
			)
			
			; assert_set_intersection_scan(
				[[1,2,3,4,5], [2,3,4], [2], []], 
				[[1,2,3,4,5], [2,3,4], [0,1,2], [231,425]]
			)

		; UnitTesting.leave() )

	fun test_set_union_scan() =
		( UnitTesting.enter("scan IntRedBlackSet.union")

			; assert_set_union_scan(
				[], 
				[]
			)

			; assert_set_union_scan(
				[[]], 
				[[]]
			)

			; assert_set_union_scan(
				[[1,2,3]], 
				[[1,2,3]]
			)

			; assert_set_union_scan(
				[[1,2,3], [1,2,3]], 
				[[1,2,3], []]
			)

			; assert_set_union_scan(
				[[], [1,2,3]], 
				[[], [1,2,3]]
			)

			; assert_set_union_scan(
				[[1,2,3], [1,2,3,4,5,6]], 
				[[1,2,3], [4,5,6]]
			)

			; assert_set_union_scan(
				[[1,2,3], [1,2,3]], 
				[[1,2,3], [1,2,3]]
			)

			; assert_set_union_scan(
				[[1,2,3], [1,2,3,4]], 
				[[1,2,3], [2,3,4]]
			)

			; assert_set_union_scan(
				[[1,2,3,4,5], [1,2,3,4,5], [0,1,2,3,4,5]], 
				[[1,2,3,4,5], [2,3,4], [0,1,2]]
			)

			; assert_set_union_scan(
				[[1,2,3,4,5], [1,2,3,4,5], [0,1,2,3,4,5], [0,1,2,3,4,5,231,425]], 
				[[1,2,3,4,5], [2,3,4], [0,1,2], [231,425]]
			)

		; UnitTesting.leave() )

	fun test_scan() =
		( SumScanViaCurriedScanTesting.test_sum_scan()
		; test_product_scan()
		; test_min_scan()
		; test_max_scan()
		; test_set_intersection_scan()
		; test_set_union_scan()
		)
end
