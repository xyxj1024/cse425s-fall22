(* __STUDENT_NAME__ *)
fun add(a,b) =
    a + b
val sum = foldl(add, 0, [1,2,3,4])


val _ = OS.Process.exit(OS.Process.success)