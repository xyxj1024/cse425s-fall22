structure RemoveFirstOccurrence = struct

    (* Xingjian *)
    fun remove_first_occurrence(xs : ''a list, target : ''a) : ''a list =
        if null xs
        then []
        else if hd xs <> target
        then hd xs :: remove_first_occurrence(tl xs, target)
        else remove_first_occurrence(tl xs, target)

end
