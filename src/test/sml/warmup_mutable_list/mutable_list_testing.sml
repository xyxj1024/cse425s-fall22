structure MutableListTesting :> sig
    val test_mutable_list : unit -> unit
end = struct
	fun to_string_from_immutable(imlist, imlist_tostring) =
		"MUT<" ^ imlist_tostring(imlist) ^ ">"

	fun to_string_from_empty() =
		to_string_from_immutable([], IntTesting.toStringFromList)

	fun to_string(mlist, imlist_tostring) = 
		let 
			val imlist = MutableList.to_immutable(mlist) handle e => (UnitTesting.on_exception(SOME "a", "b", e) ; raise e)
		in
			to_string_from_immutable(imlist, imlist_tostring)
		end


	fun assert_construct_empty() =
		CompletionTesting.assertEvalCompletionWithMessage(fn()=>MutableList.construct_empty(), "construct_empty()")

	fun assert_length(expected, mlist, binding_name) =
		IntTesting.assertEvalEqualsWithMessage(expected, fn()=> MutableList.length(mlist), "length(" ^ binding_name ^ ")")

	fun assert_add_to_front_hof to_string_function (mlist, value, binding_name) =
		CompletionTesting.assertEvalCompletionWithMessage(fn()=>MutableList.add_to_front(mlist, value), "add_to_front(" ^ binding_name ^ ", " ^ to_string_function(value) ^ ")")

	val assert_add_to_front_int = assert_add_to_front_hof IntTesting.toString
	val assert_add_to_front_string = assert_add_to_front_hof StringTesting.toString

	fun assert_contains_hof assert_function to_string_function (mlist, value, binding_name) =
		assert_function(fn()=>MutableList.contains(fn(x)=>x=value, mlist), "contains(" ^ binding_name ^ ", " ^ to_string_function(value) ^ ")")

	val assert_contains_int = assert_contains_hof (BoolTesting.assertEvalTrueWithMessage) (IntTesting.toString)
	val assert_does_not_contain_int = assert_contains_hof (BoolTesting.assertEvalFalseWithMessage) (IntTesting.toString)
	val assert_contains_string = assert_contains_hof (BoolTesting.assertEvalTrueWithMessage) (StringTesting.toString)
	val assert_does_not_contain_string = assert_contains_hof (BoolTesting.assertEvalFalseWithMessage) (StringTesting.toString)

	fun test_construct_empty() =
		let
			val _ = UnitTesting.enter("testing construct_empty")
			val mlist = assert_construct_empty()
		in
			UnitTesting.leave()
		end

	fun test_empty_length_0() =
		let
			val _ = UnitTesting.enter("testing empty_length_0")
			val mlist = assert_construct_empty()
			val _ = assert_length(0, mlist, "mlist")
		in
			UnitTesting.leave()
		end

	fun test_single_add_to_front_length_is_1() =
		let
			val _ = UnitTesting.enter("testing single add_to_front length is 1")
			val mlist = assert_construct_empty()
			val _ = assert_length(0, mlist, "mlist")
			val _ = assert_add_to_front_int(mlist, 425, "mlist")
			val _ = assert_length(1, mlist, "mlist")
		in
			UnitTesting.leave()
		end

	fun test_add_to_front_and_length() =
		let
			val _ = UnitTesting.enter("testing add_to_front and length")
			val mlist = assert_construct_empty()
			val _ = assert_length(0, mlist, "mlist")
			val _ = assert_add_to_front_string(mlist, "a", "mlist")
			val _ = assert_length(1, mlist, "mlist")
			val _ = assert_add_to_front_string(mlist, "b", "mlist")
			val _ = assert_length(2, mlist, "mlist")
			val _ = assert_add_to_front_string(mlist, "c", "mlist")
			val _ = assert_length(3, mlist, "mlist")
			val _ = assert_add_to_front_string(mlist, "d", "mlist")
			val _ = assert_length(4, mlist, "mlist")
			val _ = assert_add_to_front_string(mlist, "e", "mlist")
			val _ = assert_length(5, mlist, "mlist")
		in
			UnitTesting.leave()
		end


	fun test_single_add_to_front_length_is_1_and_contains() =
		let
			val _ = UnitTesting.enter("testing single add_to_front length is 1")
			val mlist = assert_construct_empty()
			val _ = assert_length(0, mlist, "mlist")
			val _ = assert_does_not_contain_int(mlist, 425, "mlist")
			val _ = assert_does_not_contain_int(mlist, 231, "mlist")
			val _ = assert_add_to_front_int(mlist, 425, "mlist")
			val _ = assert_length(1, mlist, "mlist")
			val _ = assert_contains_int(mlist, 425, "mlist")
			val _ = assert_does_not_contain_int(mlist, 231, "mlist")
		in
			UnitTesting.leave()
		end

	fun test_add_to_front_and_length_and_contains() =
		let
			val _ = UnitTesting.enter("testing add_to_front and length")
			val mlist = assert_construct_empty()
			val _ = assert_length(0, mlist, "mlist")
			val _ = assert_does_not_contain_string(mlist, "a", "mlist")

			val _ = assert_add_to_front_string(mlist, "a", "mlist")
			val _ = assert_length(1, mlist, "mlist")
			val _ = assert_contains_string(mlist, "a", "mlist")
			val _ = assert_does_not_contain_string(mlist, "b", "mlist")

			val _ = assert_add_to_front_string(mlist, "b", "mlist")
			val _ = assert_length(2, mlist, "mlist")
			val _ = assert_contains_string(mlist, "a", "mlist")
			val _ = assert_contains_string(mlist, "b", "mlist")
			val _ = assert_does_not_contain_string(mlist, "c", "mlist")

			val _ = assert_add_to_front_string(mlist, "c", "mlist")
			val _ = assert_length(3, mlist, "mlist")
			val _ = assert_contains_string(mlist, "a", "mlist")
			val _ = assert_contains_string(mlist, "b", "mlist")
			val _ = assert_contains_string(mlist, "c", "mlist")
			val _ = assert_does_not_contain_string(mlist, "d", "mlist")

			val _ = assert_add_to_front_string(mlist, "d", "mlist")
			val _ = assert_length(4, mlist, "mlist")
			val _ = assert_contains_string(mlist, "a", "mlist")
			val _ = assert_contains_string(mlist, "b", "mlist")
			val _ = assert_contains_string(mlist, "c", "mlist")
			val _ = assert_contains_string(mlist, "d", "mlist")
			val _ = assert_does_not_contain_string(mlist, "e", "mlist")

			val _ = assert_add_to_front_string(mlist, "e", "mlist")
			val _ = assert_length(5, mlist, "mlist")
			val _ = assert_contains_string(mlist, "a", "mlist")
			val _ = assert_contains_string(mlist, "b", "mlist")
			val _ = assert_contains_string(mlist, "c", "mlist")
			val _ = assert_contains_string(mlist, "d", "mlist")
			val _ = assert_contains_string(mlist, "e", "mlist")
			val _ = assert_does_not_contain_string(mlist, "f", "mlist")
		in
			UnitTesting.leave()
		end

	open MutableList

	fun assert_raises_subscript(thunk, message) =
		ExceptionTesting.assertRaisesExceptionWithMessage(thunk, Subscript, message)

	fun assert_nth_raises_subscript(mlist, index, binding_name) =
		assert_raises_subscript(fn()=>nth(mlist, index), "nth(" ^ binding_name ^ ", " ^ Int.toString(index) ^ ")")

	fun assert_length(expected, mlist, binding_name) =
		IntTesting.assertEvalEqualsWithMessage(expected, fn()=>length(mlist), "length(" ^ binding_name ^ ")")

	fun assert_contains(expected, target, mlist, x_name, xs_name) =
		BoolTesting.assertEvalWithMessage(expected, fn()=>contains(fn (v)=>v=target, mlist), "contains(fn (" ^ x_name ^ ")=>" ^ x_name ^ "=" ^ Int.toString(target) ^ ", " ^ xs_name ^ ")")

	fun nth_message(index, binding_name) =
		"nth(" ^ binding_name ^ ", " ^ Int.toString(index) ^ ")"

    fun test_construct_empty__length__clear__add_to_front__add_to_back__contains__nth() =
        let
            val xs : int mutable_list = construct_empty()

			fun assert_int_nth(expected, mlist, index, binding_name) =
				IntTesting.assertEqualsWithMessage(expected, nth(mlist, index), nth_message(index, binding_name))

			fun assert_xs_contains(expected, target, mlist) =
				assert_contains(expected, target, mlist, "x", "xs")

			fun assert_xs_length(expected, xs) =
				assert_length(expected, xs, "xs")

			fun assert_xs_nth(expected, xs, index) =
				assert_int_nth(expected, xs, index, "xs")

			fun assert_xs_nth_raises_subscript(mlist, index) =
				assert_nth_raises_subscript(mlist, index, "xs")
        in
            ( UnitTesting.enter("construct_empty, length, clear, add_to_front, add_to_back, contains, nth")
                ; assert_xs_length(0, xs)

				; add_to_front(xs, 23)

				; assert_xs_length(1, xs)
				; assert_xs_contains(true, 23, xs)
				; assert_xs_contains(false, 45, xs)
				; assert_xs_nth(23, xs, 0)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 1)

				; add_to_back(xs, 45)

				; assert_xs_length(2, xs)
				; assert_xs_contains(true, 23, xs)
				; assert_xs_contains(true, 45, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(23, xs, 0)
				; assert_xs_nth(45, xs, 1)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 2)

				; add_to_back(xs, 23)

				; assert_xs_length(3, xs)
				; assert_xs_contains(true, 23, xs)
				; assert_xs_contains(true, 45, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(23, xs, 0)
				; assert_xs_nth(45, xs, 1)
				; assert_xs_nth(23, xs, 2)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 3)

				; clear(xs)
                
				; assert_xs_length(0, xs)
				; assert_xs_contains(false, 23, xs)
				; assert_xs_contains(false, 45, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 0)

				; add_to_front(xs, 425)

				; assert_xs_length(1, xs)
				; assert_xs_contains(true, 425, xs)
				; assert_xs_contains(false, 231, xs)
				; assert_xs_nth(425, xs, 0)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 1)

				; add_to_front(xs, 231)

				; assert_xs_length(2, xs)
				; assert_xs_contains(true, 231, xs)
				; assert_xs_contains(true, 425, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(231, xs, 0)
				; assert_xs_nth(425, xs, 1)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 2)

				; add_to_front(xs, 131)

				; assert_xs_length(3, xs)
				; assert_xs_contains(true, 131, xs)
				; assert_xs_contains(true, 231, xs)
				; assert_xs_contains(true, 425, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(131, xs, 0)
				; assert_xs_nth(231, xs, 1)
				; assert_xs_nth(425, xs, 2)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 3)

				; add_to_back(xs, 500)

				; assert_xs_length(4, xs)
				; assert_xs_contains(true, 131, xs)
				; assert_xs_contains(true, 231, xs)
				; assert_xs_contains(true, 425, xs)
				; assert_xs_contains(true, 500, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(131, xs, 0)
				; assert_xs_nth(231, xs, 1)
				; assert_xs_nth(425, xs, 2)
				; assert_xs_nth(500, xs, 3)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 4)

				; add_to_back(xs, 600)

				; assert_xs_length(5, xs)
				; assert_xs_contains(true, 131, xs)
				; assert_xs_contains(true, 231, xs)
				; assert_xs_contains(true, 425, xs)
				; assert_xs_contains(true, 500, xs)
				; assert_xs_contains(true, 600, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(131, xs, 0)
				; assert_xs_nth(231, xs, 1)
				; assert_xs_nth(425, xs, 2)
				; assert_xs_nth(500, xs, 3)
				; assert_xs_nth(600, xs, 4)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 5)

				; clear(xs)
                
				; assert_xs_length(0, xs)
				; assert_xs_contains(false, 23, xs)
				; assert_xs_contains(false, 45, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 0)

				; add_to_back(xs, 4)

				; assert_xs_length(1, xs)
				; assert_xs_contains(true, 4, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(4, xs, 0)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 1)

				; add_to_back(xs, 66)

				; assert_xs_length(2, xs)
				; assert_xs_contains(true, 4, xs)
				; assert_xs_contains(true, 66, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(4, xs, 0)
				; assert_xs_nth(66, xs, 1)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 2)

				; add_to_back(xs, 99)

				; assert_xs_length(3, xs)
				; assert_xs_contains(true, 4, xs)
				; assert_xs_contains(true, 66, xs)
				; assert_xs_contains(true, 99, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(4, xs, 0)
				; assert_xs_nth(66, xs, 1)
				; assert_xs_nth(99, xs, 2)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 3)

				; add_to_front(xs, 1)

				; assert_xs_length(4, xs)
				; assert_xs_contains(true, 1, xs)
				; assert_xs_contains(true, 4, xs)
				; assert_xs_contains(true, 66, xs)
				; assert_xs_contains(true, 99, xs)
				; assert_xs_contains(false, 0, xs)
				; assert_xs_nth(1, xs, 0)
				; assert_xs_nth(4, xs, 1)
				; assert_xs_nth(66, xs, 2)
				; assert_xs_nth(99, xs, 3)
				; assert_xs_nth_raises_subscript(xs, ~1)
				; assert_xs_nth_raises_subscript(xs, 4)

            ; UnitTesting.leave() 
			)
        end

    fun test_construct_from_immutable() =
        let
            val empty : string mutable_list = construct_from_immutable([])
            val a : string mutable_list = construct_from_immutable(["a"])
            val ab : string mutable_list = construct_from_immutable(["a", "b"])
			val abc : string mutable_list = construct_from_immutable(["a", "b", "c"])
			val abcd : string mutable_list = construct_from_immutable(["a", "b", "c", "d"])

            val empty_via_clear : string mutable_list = construct_from_immutable(["a", "b", "c", "d", "e"])
			val _ = clear(empty_via_clear)

			fun assert_string_nth(expected, mlist, index, binding_name) =
				StringTesting.assertEqualsWithMessage(expected, nth(mlist, index), nth_message(index, binding_name))

			fun assert_a_nth(expected, index) =
				assert_string_nth(expected, a, index, "a")

			fun assert_ab_nth(expected, index) =
				assert_string_nth(expected, ab, index, "ab")

			fun assert_abc_nth(expected, index) =
				assert_string_nth(expected, abc, index, "abc")

			fun assert_abcd_nth(expected, index) =
				assert_string_nth(expected, abcd, index, "abcd")
        in
            ( UnitTesting.enter("construct_from_immutable")
				; assert_length(0, empty, "empty")
				; assert_length(1, a, "a")
				; assert_length(2, ab, "ab")
				; assert_length(3, abc, "abc")
				; assert_length(4, abcd, "abcd")
				; assert_length(0, empty_via_clear, "empty_via_clear")

				; assert_a_nth("a", 0)

				; assert_ab_nth("a", 0)
				; assert_ab_nth("b", 1)

				; assert_abc_nth("a", 0)
				; assert_abc_nth("b", 1)
				; assert_abc_nth("c", 2)

				; assert_abcd_nth("a", 0)
				; assert_abcd_nth("b", 1)
				; assert_abcd_nth("c", 2)
				; assert_abcd_nth("d", 3)
            ; UnitTesting.leave() 
			)
        end


    fun test_foldl() =
		( UnitTesting.enter("foldl")
			; IntTesting.assertEquals(0, foldl(op+, 0, construct_empty()))
			; IntTesting.assertEquals(1, foldl(op+, 0, construct_from_immutable([1])))
			; IntTesting.assertEquals(8, foldl(op+, 0, construct_from_immutable([3, 5])))
			; IntTesting.assertEquals(63, foldl(op+, 0, construct_from_immutable([1, 2, 4, 8, 16, 32])))
			; StringTesting.assertEquals("", foldl(op^, "", construct_empty()))
			; StringTesting.assertEquals("a", foldl(op^, "", construct_from_immutable(["a"])))
			; StringTesting.assertEquals("ba", foldl(op^, "", construct_from_immutable(["a", "b"])))
			; StringTesting.assertEquals("cba", foldl(op^, "", construct_from_immutable(["a", "b", "c"])))
			; StringTesting.assertEquals("dcba", foldl(op^, "", construct_from_immutable(["a", "b", "c", "d"])))
		; UnitTesting.leave() 
		)

    fun test_to_immutable() =
        let
			fun assert_to_immutable assertFunction toStringFromListFunction expected =
				assertFunction(expected, to_immutable(construct_from_immutable(expected)), "to_immutable(construct_from_immutable(" ^ toStringFromListFunction(expected) ^ "))")
			val assert_int_to_immutable = assert_to_immutable IntTesting.assertListEqualsWithMessage IntTesting.toStringFromList
			val assert_string_to_immutable = assert_to_immutable StringTesting.assertListEqualsWithMessage StringTesting.toStringFromList
        in
			( UnitTesting.enter("to_immutable")
				; assert_int_to_immutable([])
				; assert_int_to_immutable([1])
				; assert_int_to_immutable([231, 425])
				; assert_int_to_immutable([1, 1, 2, 3, 5, 8, 13, 21, 34])
				; assert_string_to_immutable(["a", "b", "c", "d", "e"])
			; UnitTesting.leave() 
			)
        end

    fun test_map() =
        let
			fun assert_to_immutable assertFunction toStringFromListFunction expected =
				assertFunction(expected, fn()=>to_immutable(construct_from_immutable(expected)), "to_immutable(construct_from_immutable(" ^ toStringFromListFunction(expected) ^ "))")
			val assert_int_to_immutable = assert_to_immutable IntTesting.assertListEvalEqualsWithMessage IntTesting.toStringFromList
			val assert_string_to_immutable = assert_to_immutable StringTesting.assertListEvalEqualsWithMessage StringTesting.toStringFromList
        in
			( UnitTesting.enter("map")
				; IntTesting.assertListEquals([], to_immutable(map(String.size, construct_from_immutable([]))))
				; IntTesting.assertListEquals([1], to_immutable(map(String.size, construct_from_immutable(["a"]))))
				; IntTesting.assertListEquals([4, 5, 3, 5, 5, 3], to_immutable(map(String.size, construct_from_immutable(["four", "score", "and", "seven", "years", "ago"]))))
				; IntTesting.assertListEquals([1, 4, 9, 16, 25, 36], to_immutable(map(fn (x)=>x*x, construct_from_immutable([1, 2, 3, 4, 5, 6]))))
			; UnitTesting.leave() 
			)
        end

    fun test_copy() =
        let
			val _ = UnitTesting.enter("copy")
			val xs = [131, 231, 425]
			val a = construct_from_immutable(xs)
			val _ = IntTesting.assertListEqualsWithMessage(xs, to_immutable(a), "a")
			val b = copy(a)
			val _ = IntTesting.assertListEqualsWithMessage(xs, to_immutable(b), "b")
			val _ = add_to_front(a, 1)
			val _ = IntTesting.assertListEqualsWithMessage(1::xs, to_immutable(a), "a after add_to_front(a, 1)")
			val _ = IntTesting.assertListEqualsWithMessage(xs, to_immutable(b), "b after add_to_front(a, 1)")
			val _ = add_to_front(b, 2)
			val _ = IntTesting.assertListEqualsWithMessage(1::xs, to_immutable(a), "a after add_to_front(a, 1) and add_to_front(b, 2)")
			val _ = IntTesting.assertListEqualsWithMessage(2::xs, to_immutable(b), "b after add_to_front(a, 1) and add_to_front(b, 2)")
			val _ = UnitTesting.leave()
		in
			()
        end

    fun test_concat() =
        let
			val _ = UnitTesting.enter("@")
			val xs = [1,2,3]
			val ys = [4,5,6]
			val xs_ys = List.@(xs,ys)
			val a = construct_from_immutable(xs)
			val _ = IntTesting.assertListEqualsWithMessage(xs, to_immutable(a), "a")
			val b = construct_from_immutable(ys)
			val _ = IntTesting.assertListEqualsWithMessage(ys, to_immutable(b), "b")
			val c = a @ b
			val _ = IntTesting.assertListEqualsWithMessage(xs_ys, to_immutable(c), "c")
			val _ = add_to_front(a, 100)
			val _ = add_to_front(b, 200)
			val _ = add_to_front(c, 300)
			val _ = IntTesting.assertListEqualsWithMessage(100::xs, to_immutable(a), "a after")
			val _ = IntTesting.assertListEqualsWithMessage(200::ys, to_immutable(b), "b after")
			val _ = IntTesting.assertListEqualsWithMessage(300::(xs_ys), to_immutable(c), "c after")
			val _ = UnitTesting.leave()
		in
			()
        end

    fun test_reverse() =
        let
			val _ = UnitTesting.enter("reverse")
			val xs = [1,2,3]
			val a = construct_from_immutable(xs)
			val _ = IntTesting.assertListEqualsWithMessage(xs, to_immutable(a), "a")
			val _ = reverse(a)
			val _ = IntTesting.assertListEqualsWithMessage(List.rev(xs), to_immutable(a), "a reverse")
			val _ = reverse(a)
			val _ = IntTesting.assertListEqualsWithMessage(xs, to_immutable(a), "a reverse reverse")
			val _ = UnitTesting.leave()
		in
			()
        end

	fun test_remove_arbitrary() =
        let
			val _ = UnitTesting.enter("remove_arbitrary")
			val xs = construct_empty()
			val _ = IntTesting.assertOptionEvalEqualsWithMessage(NONE, fn()=>remove_arbitrary(xs), "remove_arbitrary([])")
			val _ = add_to_front(xs, 425)
			val _ = IntTesting.assertOptionEvalEqualsWithMessage(SOME(425), fn()=>remove_arbitrary(xs), "remove_arbitrary([425])")
			val _ = IntTesting.assertListEvalEqualsWithMessage([], fn()=>to_immutable(xs), "to_immutable(xs)")

			val _ = add_to_front(xs, 425)
			val _ = add_to_front(xs, 231)

			val removed = remove_arbitrary(xs)

			val _ = BoolTesting.assertTrueWithMessage(isSome(removed), "isSome(removed)")
			val SOME(x) = removed
			val _ = BoolTesting.assertTrueWithMessage(x = 425 orelse x = 231, "x = 425 orelse x = 231")
			val _ = if x=425
					then IntTesting.assertListEqualsWithMessage([231], to_immutable(xs), "to_immutable(xs)")
					else IntTesting.assertListEqualsWithMessage([425], to_immutable(xs), "to_immutable(xs)")
			val _ = UnitTesting.leave()
		in
			()
        end


    structure ParrotTesting = EqualityTestingFn (struct
        type t = parrot
        fun toString(PARTY) = "PARTY"
          | toString(SHUFFLE) = "SHUFFLE"
          | toString(PORTAL_BLUE_LEFT) = "PORTAL_BLUE_LEFT"
          | toString(PORTAL_ORANGE_RIGHT) = "PORTAL_ORANGE_RIGHT"
        fun compare(a,b) = raise Fail "unsupported"
    end)

	fun assert_construct_with_parrot(parrot) =
		ParrotTesting.assertListEvalEqualsWithMessage([parrot], fn()=>to_immutable(construct_with_parrot(parrot)), "to_immutable(construct_with_parrot(" ^ ParrotTesting.toString(parrot) ^ "))")

	fun test_construct_with_parrot() =
        let
			val _ = UnitTesting.enter("construct_with_parrot")
			val _ = assert_construct_with_parrot(PARTY)
			val _ = assert_construct_with_parrot(SHUFFLE)
			val _ = assert_construct_with_parrot(PORTAL_BLUE_LEFT)
			val _ = assert_construct_with_parrot(PORTAL_ORANGE_RIGHT)
		in
			UnitTesting.leave()
        end

    fun test_mutable_list() =
		( test_construct_empty()
		; test_empty_length_0()
		; test_single_add_to_front_length_is_1()
		; test_add_to_front_and_length()
		; test_single_add_to_front_length_is_1_and_contains()
		; test_add_to_front_and_length_and_contains()

		; test_construct_empty__length__clear__add_to_front__add_to_back__contains__nth()
		; test_construct_from_immutable()
		; test_foldl()
		; test_to_immutable()
		; test_map()
		; test_copy()
		; test_concat()
		; test_reverse()

		; test_remove_arbitrary()

		; test_construct_with_parrot()

		)
end
