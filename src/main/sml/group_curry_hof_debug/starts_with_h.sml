CM.make "../../../test/sml/unit_testing/unit_testing.cm";

val name = "fred"
(* https://smlfamily.github.io/Basis/string.html#SIG:STRING.sub:VAL *)
val f = String.sub(name, 0)
val r = String.sub(name, 1)
val e = String.sub(name, 2)
val d = String.sub(name, 3)

(* syntax for character literal *)
val letter_h = #"h"

(* TODO *)
val starts_with_h = List.filter (fn name => String.sub(name, 0) = letter_h)

val names = ["fred", "george", "ron", "hermione", "neville", "luna", "harry", "ginny", "hagrid"]
val expected = ["hermione", "harry", "hagrid"]
val actual = starts_with_h names

val result = StringTesting.assertListEqualsWithMessage(expected, actual, "starts_with_h names")

val _ = OS.Process.exit(OS.Process.success)