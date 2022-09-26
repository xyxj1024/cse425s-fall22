(* Xingjian Xuanyuan *)
(* Dennis Cosgrove *)
structure Csv = struct
    (* fun is_separator(c : char) : bool =
           c = #"/" *)
    
    fun is_new_line(c : char) : bool =
        c = #"\n"

    fun is_comma(c : char) : bool =
        c = #","
    
    fun read_csv(csv:string) : string list list =
    List.map (String.fields is_comma) (String.fields is_new_line csv)
end
