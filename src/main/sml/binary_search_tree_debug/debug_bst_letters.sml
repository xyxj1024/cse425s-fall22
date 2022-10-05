(* Dennis Cosgrove *)
CM.make "../binary_search_tree/binary_search_tree.cm";

val bst = BinarySearchTree.create_empty(String.compare, fn(v)=>v)
val (bst,_) = BinarySearchTree.insert(bst, "f")
val (bst,_) = BinarySearchTree.insert(bst, "b")
val (bst,_) = BinarySearchTree.insert(bst, "g")
val (bst,_) = BinarySearchTree.insert(bst, "a")
val (bst,_) = BinarySearchTree.insert(bst, "d")
val (bst,_) = BinarySearchTree.insert(bst, "i")
val (bst,_) = BinarySearchTree.insert(bst, "c")
val (bst,_) = BinarySearchTree.insert(bst, "e")
val (bst,_) = BinarySearchTree.insert(bst, "h")

val identity = fn(s)=>s

val dot = BinarySearchTree.to_graphviz_dot(identity, identity, bst)
val _ = print(dot)

val debug_message = BinarySearchTree.debug_message(identity, bst)
val _ = print(debug_message ^ "\n")

val ostream = TextIO.openOut "debug_bst_letters.dot"
val _ = TextIO.output (ostream, dot) handle e => (TextIO.closeOut ostream; raise e)
val _ = TextIO.closeOut ostream

val is_exit_desired = true
val _ = if is_exit_desired 
		then OS.Process.exit(OS.Process.success)
		else ()
