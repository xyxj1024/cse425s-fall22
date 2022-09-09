/*******************************************************************************
 * Copyright (C) 2016-2020 Dennis Cosgrove
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 ******************************************************************************/
package immutable.list.util.exercise;

/* import edu.wustl.cse.cosgroved.NotYetImplementedException; */
import immutable.list.util.core.ImList;

/**
 * @author Xingjian Xuanyuan
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public class ImLists {
	/**
	 * Mimics the behavior of the nil constructor of the 'a list datatype in the
	 * <a href="https://smlfamily.github.io/Basis/list.html">SML List structure</a>.
	 * 
	 * @param <E> the type of elements held in the ImList
	 * @return an empty ImList
	 */
	@SuppressWarnings("unchecked")
	public static <E> ImList<E> nil() {
		return (ImList<E>) EmptyImList.getSingleton();
	}

	/**
	 * Mimics the behavior of the :: constructor of the 'a list datatype in the
	 * <a href="https://smlfamily.github.io/Basis/list.html">SML List structure</a>.
	 * 
	 * @param <E>  the type of elements held in the ImList
	 * @param head the value
	 * @param tail the rest
	 * @return the constructed list
	 */
	public static <E> ImList<E> cons(E head, ImList<E> tail) {
		return new NonEmptyImList<>(head, tail);
	}

	/**
	 * Recursively define ImList<E> as EmptyImList + cons(head, tail)
	 * 
	 * @param <E> the type of elements held in the ImList
	 * @param index the position of element in the elements array
	 * @param NewImList the constructed list
	 * @param elements the contents of the to be created list
	 * @return the created list
	 */
	@SafeVarargs
	private static <E> ImList<E> recursive_cons(int index, ImList<E> NewImList, E... elements) {
		if (index == 0) {
			return NewImList;
		} else {
			index--;
			NewImList = cons(elements[index], NewImList);
			return recursive_cons(index, NewImList, elements);
		}
	}

	/**
	 * Mimics the behavior of constructing an 'a list by enclosing elements in
	 * brackets. For example: [x, y, z].
	 * 
	 * @param <E>      the type of elements held in the ImList
	 * @param elements the contents of the to be created list
	 * @return the created list
	 */
	@SafeVarargs
	public static <E> ImList<E> brackets(E... elements) {
		ImList<E> NewImList = nil();
		int index = elements.length;
		return recursive_cons(index, NewImList, elements);
	}
}
