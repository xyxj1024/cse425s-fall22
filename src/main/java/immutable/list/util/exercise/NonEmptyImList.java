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

import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Objects;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import immutable.list.util.core.ImList;

/**
 * @author Xingjian Xuanyuan
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
/* package-private */ final class NonEmptyImList<E> implements ImList<E> {
	private final E head;
	private final ImList<E> tail;

	/* package-private */ NonEmptyImList(E head, ImList<E> tail) {
		this.head = head;
		this.tail = tail;
	}

	@Override
	public E head() {
		return head;
	}

	@Override
	public ImList<E> tail() {
		return tail;
	}

	@Override
	public boolean isEmpty() {
		if (head() == null) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Iterator<E> iterator() {
		/* return an iterator for this instance of NonEmptyImList */
		return new Iterator<E> () {
			private ImList<E> elements = NonEmptyImList.this;
			
			public boolean hasNext() {
				if (elements.isEmpty()) {
					return false;
				} else {
					return true;
				}
			}
			
			public E next() {
				if (elements.isEmpty()) {
					throw new NoSuchElementException();
				} else {
					E item = elements.head();
					elements = elements.tail();
					return item;
				}
			}
		};
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null) {
			return false;
		}
		if (o instanceof ImList) {
			ImList<?> that = (ImList<?>) o;
			if (that.isEmpty()) {
				return false;
			} else {
				return Objects.equals(head(), that.head()) && Objects.equals(tail(), that.tail());
			}
		} else {
			return false;
		}
	}

	@Override
	public String toString() {
		if (isEmpty()) {
			return "[]";
		} else {
			return head() + "::" + tail().toString();
		}
	}
}
