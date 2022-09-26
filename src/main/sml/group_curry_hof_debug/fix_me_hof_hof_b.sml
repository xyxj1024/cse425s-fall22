(* Xingjian Xuanyuan *)
(* val sum = foldl(op+, 0, [1,2,3,4]) *)
val sum = foldl op+ 0 [1,2,3,4]


val _ = OS.Process.exit(OS.Process.success)