(* https://www.cs.cornell.edu/courses/cs312/2008sp/lectures/src/tree-print.sml *)
fun spaces(n : int) : string =
    if n > 0
    then " " ^ spaces(n - 1)
    else
        if n <= 0
        then ""
        else raise Fail "Negative space!"

fun right_diag(n : int) : string list =
    if n = 0
    then []
    else right_diag(n - 1) @ [spaces(n - 1) ^ "\\"]

fun left_diag(n : int) : string list =
    if n = 0
    then []
    else [spaces(n - 1) ^ "/"] @ left_diag(n - 1)

fun indent(sl : string list, n : int) : string list =
    let
        val white_spaces = spaces(n)
    in
        List.map (fn(s) => white_spaces ^s) sl
    end

fun pad(sl : string list, n : int) : string list =
    List.map (fn(s) => s ^ spaces(n - String.size(s))) sl

fun hsplice(h1::t1, h2::t2, w1, w2) = (h1 ^ h2) :: hsplice(t1, t2, w1 ,w2)
  | hsplice(sl1 : string list, nil, w1, w2) = pad(sl1, w1 + w2)
  | hsplice(nil, sl2, w1, w2) = indent(sl2, w1)

fun toStrings(t as (root, _, _) : ('e, 'k) tree): ((string list) * int * int * int) =
    case root of
        Nil => ([], 0, 0, 0)
      | Sub (_, _, left_child, right_child) =>
            let
                fun node_toString(Sub (_, element, _, _))= Int.toString(element)
                val vs = node_toString(root)
                val vl = String.size(vs)
                val (sl1, w1, h1, r1) = toStrings(left_child)
                val (sl2, w2, h2, r2) = toStrings(right_child)
                val padding =
                    case r2 + w1 - r1 of 
                        0 => 2
                      | 1 => 1
                      | 2 => 0
                      | diff =>
                            if diff mod 2 = 0
                            then 0
                            else 1
                val w = Int.max(w1 + w2 + padding, vl)
                val diagsize = (r2 + w1 - r1 + padding) div 2
                val leftarc = 
                    case left_child of
                        Nil => []
                      | _ => left_diag(diagsize)
                val rightarc =
                    case right_child of
                        Nil => []
                      | _ => right_diag(diagsize)
                val sl = pad(indent([vs],
                                    r1 + diagsize - (vl div 2)), 
                                    w)
                         @
                         pad(indent(hsplice(pad(leftarc, diagsize + 1), 
                                            pad(rightarc, diagsize), 
                                            diagsize + 1, 
                                            diagsize), 
                                    r1), 
                                    w)
                         @
                         hsplice(sl1, 
                                 indent(sl2, padding),
                                 w1,
                                 w2 + padding)
            in
                (sl, w, Int.max(h1, h2) + diagsize + 1, diagsize + r1)
            end

fun print(bst : ('e, 'k) tree) : string =
    let
        val (sl, w, h, r) = toStrings(bst)
    in
        List.app (fn (s : string) => TextIO.print(s ^ "\n")) sl
    end