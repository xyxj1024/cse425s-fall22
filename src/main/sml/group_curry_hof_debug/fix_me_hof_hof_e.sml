(* __STUDENT_NAME__ *)
val xys = [(10,20), (30,40), (50, 60)]

val xs = map xys #1

val sum_xs = foldl op+ 0 xs

val _ = OS.Process.exit(OS.Process.success)
