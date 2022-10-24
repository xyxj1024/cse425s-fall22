(* Xingjian Xuanyuan *)
structure HashedDictionary = DictionaryFn(struct
	type ''k hash_function = ''k -> int
	
	type (''k, 'v) bucket = (''k * 'v) list
	(*
  type (''k,'v) dictionary = (((''k,'v) bucket) Array.array ref *
                              int ref *
                              ''k hash_function)
  fun create(bucket_count_request : int, hash : ''k hash_function) : (''k,'v) dictionary =
    (ref (Array.array(bucket_count_request, nil)), ref 0, hash)
  *)
  type (''k, 'v) dictionary = (((''k, 'v) bucket) Vector.vector ref *
                              ''k hash_function)

  type ''k create_parameter_type = (int * (''k hash_function))

  fun create(bucket_count_request : int, hash : ''k hash_function) : (''k, 'v) dictionary =
    (ref (Vector.tabulate(bucket_count_request, fn(_) => nil)), hash)

  fun positive_remainder(v : int, n : int) : int = 
    let
      val result = v mod n 
    in 
      if result >= 0 
      then result 
      else result + n
		end

  (*
  fun get(dict : (''k,'v) dictionary, key : ''k) : 'v option = 
    let
      val (ref buckets, hash) = dict
      val index = positive_remainder(hash(key), Array.length(buckets))
      val blist = Array.sub(buckets, index)
      fun lookup(b, k) =
        case b of
          nil => NONE
        | (this_key, this_val)::rest =>
            if k = this_key
            then SOME this_val
            else lookup(rest, k)
    in
      lookup(blist, key)
    end
  *)

  fun find_bucket(dict : (''k, 'v) dictionary, key : ''k) : (''k, 'v) bucket =
    let
      val (ref buckets, hash) = dict
      val index = positive_remainder(hash(key), Vector.length(buckets))
    in
      Vector.sub(buckets, index)
    end

  fun get(dict : (''k, 'v) dictionary, key : ''k) : 'v option =
    Chain.get(find_bucket(dict, key), key)

  fun put(dict : (''k, 'v) dictionary, key : ''k , value : 'v) : (''k, 'v) dictionary * 'v option =
    let
      val (ref buckets, hash) = dict
      val index = positive_remainder(hash(key), Vector.length(buckets))
      val blist = Vector.sub(buckets, index)
      val this_valop = Chain.get(blist, key)
    in
      case this_valop of
        NONE => ((ref (Vector.update(buckets, index, blist@[(key, value)])), hash), NONE)
      | SOME _ =>
          let
            val (mlist, rem_valop) = Chain.remove(blist, key)
          in
            ((ref (Vector.update(buckets, index, mlist@[(key, value)])), hash), rem_valop)
          end
    end
  
  fun remove(dict : (''k, 'v) dictionary, key : ''k) : (''k, 'v) dictionary * 'v option =
    let
      val (ref buckets, hash) = dict
      val index = positive_remainder(hash(key), Vector.length(buckets))
      val blist = Vector.sub(buckets, index)
      val this_valop = Chain.get(blist, key)
    in
      case this_valop of
        NONE => (dict, NONE)
      | SOME _ =>
          let
            val (mlist, rem_valop) = Chain.remove(blist, key)
          in
            ((ref (Vector.update(buckets, index, mlist)), hash), rem_valop)
          end
    end

	fun entries(dict : (''k, 'v) dictionary) : (''k * 'v) list =
    let
      val (ref buckets, _) = dict
    in
      Vector.foldl (fn (x, acc) => acc@x) [] buckets
    end

end)