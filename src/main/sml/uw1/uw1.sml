(* HW1 Provided Code *)

(* Xingjian *)
fun is_older (a : int*int*int, b : int*int*int) : bool =
    if (#1 a) < (#1 b)
    then true
    else if (#1 a) > (#1 b)
    then false
    else if (#2 a) < (#2 b)
    then true
    else if (#2 a) > (#2 b)
    then false
    else if (#3 a) < (#3 b)
    then true
    else false

fun number_in_month (a : (int * int * int) list, b : int) : int =
    if null a
    then 0
    else
        if #2 (hd a) <> b (* results in type mismatch if using "(#2 hd a) <> b" *)
        then number_in_month(tl a, b)
        else 1 + number_in_month(tl a, b)

fun number_in_months (a : (int*int*int) list, b : int list) : int =
    if null b
    then 0
    else number_in_month(a, hd b) + number_in_months(a, tl b)

fun dates_in_month (a : (int * int * int) list, b : int) : (int * int * int) list =
    if null a
    then []
    else
        if #2 (hd a) <> b (* results in type mismatch if using "(#2 hd a) <> b" *)
        then [] @ dates_in_month(tl a, b)
        else hd a :: dates_in_month(tl a, b)

fun dates_in_months (a : (int*int*int) list, b : int list) : (int * int * int) list =
    if null b
    then []
    else dates_in_month(a, hd b) @ dates_in_months(a, tl b)

fun get_nth (a : string list, b : int) : string =
    if b <= 0
    then "Given the wrong index!"
    else if b = 1
    then hd a
    else get_nth(tl a, b - 1)

fun date_to_string (a : int*int*int) : string =
    let val months = ["January ", "February ", "March ",
                      "April ", "May ", "June ", "July ",
                      "August ", "September ", "October ",
                      "November ", "December "]
    in
        get_nth(months, (#2 a)) ^ Int.toString((#3 a)) ^ ", " ^ Int.toString((#1 a))
    end

fun number_before_reaching_sum (sum : int, pos : int list) : int =
    if null pos orelse hd pos >= sum
    then 0
    else if null (tl pos) 
    then 1
    else
        let val tl_ans = number_before_reaching_sum(sum, hd pos + hd (tl pos) :: tl(tl pos))
		in
            1 + tl_ans
		end

fun what_month (day : int) : int = 
    let val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        1 + number_before_reaching_sum(day, days_in_month)
    end

fun month_range (day1 : int, day2 : int) : int list =
    if day1 > day2
    then []
    else
        let val m1 = what_month(day1)
        in
            m1 :: month_range(day1 + 1, day2)
        end

fun oldest (dates : (int*int*int) list) : (int * int * int) option =
    if null dates
    then NONE
    else if null (tl dates)
    then SOME (hd dates)
    else
        let val tl_ans = oldest(tl dates)
        in
            if isSome tl_ans andalso is_older(hd dates, valOf tl_ans)
            then SOME (hd dates)
            else tl_ans
        end

fun remove_duplicates (a : int list) : int list =
        (* check if list xs contains an element x *)
    let fun compare (xs : int list, x : int) : bool =
            if null xs
            then false
            else if hd xs = x
            then true
            else compare (tl xs, x)
        (* check every element in xs if it has duplicates *)
        fun iterate (xs : int list) : int list =
                if null xs
                then []
                else if compare (tl xs, hd xs)
                then iterate(tl xs)
                else hd xs :: iterate(tl xs)
    in
        iterate (a)
    end

fun number_in_months_challenge (a : (int*int*int) list, b : int list) : int =
    let val months = remove_duplicates(b)
    in
        if null months
        then 0
        else number_in_month(a, hd months) + number_in_months(a, tl months)
    end

fun dates_in_months_challenge (a : (int*int*int) list, b : int list) : (int * int * int) list =
    let val months = remove_duplicates(b)
    in
        if null months
        then []
        else dates_in_month(a, hd months) @ dates_in_months(a, tl months)
    end

fun reasonable_date (date: (int*int*int)) : bool =
    (* check year range *)
    if #1 date <= 0
    then false
    (* check month range *)
    else if #2 date < 1 orelse #2 date > 12
    then false
    (* check day range *)
    else if #3 date < 1 orelse #3 date > 31
    then false
    (* check leap years *)
    else if #2 date = 2 andalso #3 date = 29
    then
        let fun check_leap(year : int) : bool =
                if ((year mod 400) <> 0) andalso ((year mod 4 <> 0) orelse (year mod 100 = 0))
                then false
                else true
        in
            check_leap(#1 date)
        end
    else
        let val month_days = [(1, 31), (2, 28), (3, 31), (4, 30), (5, 31),
                             (6, 30), (7, 31), (8, 31), (9, 30), (10, 31),
                             (11, 30), (12, 31)];
            fun compare_pair (xs : (int*int) list, x : int*int) : bool =
            if #1 (hd xs) = #1 x andalso #2 (hd xs) >= #2 x
            then true
            else compare_pair (tl xs, x)
        in
            compare_pair (month_days, (#2 date, #3 date))
        end

