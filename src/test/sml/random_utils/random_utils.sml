signature RANDOM_UTILS = sig
	val shuffle : ('a list * Random.rand) -> 'a list
end

structure RandomUtils : RANDOM_UTILS = struct
    fun shuffle(original_list : 'a list, r : Random.rand) : 'a list =
        let
            val input = ref original_list
            val output = ref []
            fun remove_random(xs, r) = 
                let 
                    val i = Random.randInt(r) mod List.length(xs)
                    val x = List.nth(xs, i)
                    val xs' = List.take(xs, i) @ List.drop(xs, i+1)
                in
                    (x, xs')
                end
            val _ = 
                while List.length(!input) > 0 do
                    let
                        val (v, input') = remove_random(!input, r)
                        val _ = output := (v :: !output)
                        val _ = input := input'
                    in
                        ()
                    end
        in
            !output
        end
end
