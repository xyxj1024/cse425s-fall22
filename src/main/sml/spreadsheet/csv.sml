(* __STUDENT_NAME__ *)
(* Dennis Cosgrove *)
structure Csv = struct
    fun is_new_line(c : char) : bool =
        c = #"\n"

    fun is_comma(c : char) : bool =
        c = #","

    fun read_csv(csv:string) : string list list =
        raise Fail "NotYetImplemented"
end
