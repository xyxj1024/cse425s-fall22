(* Xingjian Xuanyuan *)
(* Dennis Cosgrove *)
structure SpreadsheetToDictionaries = struct
  open Spreadsheet

  (* datatype cell = EMPTY | TEXT of string | INTEGER of int
     type sheet = cell list list
     datatype (cell, cell) Record = Empty | Cons of cell * cell * (cell, cell) Record
     type (cell, cell) dictionary = (cell, cell) Record *)
  fun spreadsheet_to_dictionaries_using_headers_as_keys(s : sheet) : (cell, cell) SingleChainedDictionary.dictionary list =
    let
      (* returns a cell list, which is the first row if s *)
      val keys = Spreadsheet.row_at(s, 0)

      (* returns a (key, value) pair list list *)
      (* fun spreadsheet_to_kvs_list(s : sheet) : (cell * cell) list list = *)
      fun spreadsheet_to_kvs_list(s) =
        let
          fun values l =
            case l of
              [] => []
            | _::rest => rest
        in
          List.map (fn clist => ListPair.zip(keys, clist)) (values s)
        end

      (*
      (* returns a (key, value) pair list list *)
      fun kcs_to_kvs_list(kcs_list) =
        let
          fun kcs_to_kvs_helper(kcs) =
            case kcs of
              [] => []
            | (k, c)::rest =>
                case c of
                  TEXT str => (k, str)::kcs_to_kvs_list(rest)
                | INTEGER i => (k, i)::kcs_to_kvs_list(rest)
                | _ => kcs_to_kvs_list(rest)
        in
          foldl (fn(kcs, acc) => acc@[kcs_to_kvs_helper(kcs)]) [] kcs_list
        end
      *)
      
      (* returns a dictionary given a list of pairs *)
      (* fun pairs_to_dictionary(ps : (cell * cell) list, dict : (cell, cell) SingleChainedDictionary.dictionary) : (cell, cell) SingleChainedDictionary.dictionary = *)
      fun pairs_to_dictionary(ps, dict) =
        case ps of
          [] => dict
        | (k, v)::t =>
            let
              val (new_dict, _) = SingleChainedDictionary.put(dict, k, v)
            in
              pairs_to_dictionary(t, new_dict)
            end
      
      (* returns a dictionary list given a pair list list *)
      (* fun spreadsheet_to_dict_helper(pslist : (cell * cell) list list, dict : (cell, cell) SingleChainedDictionary.dictionary) : (cell, cell) SingleChainedDictionary.dictionary list = *)
      fun spreadsheet_to_dict_helper(pslist, dict) =
        List.map (fn ps => pairs_to_dictionary(ps, dict)) pslist

    in

      spreadsheet_to_dict_helper(
        (spreadsheet_to_kvs_list(s)), 
        (SingleChainedDictionary.create())
      )
    
    end
end
