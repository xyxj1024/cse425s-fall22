(* Xingjian Xuanyuan *)
val xys = [(10,20), (30,40), (50, 60)]

(* val xs = map xys #1 *)
val xs = map #1 xys

val sum_xs = foldl op+ 0 xs

val _ = OS.Process.exit(OS.Process.success)
