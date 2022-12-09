package immutable.list.util.exercise;

import java.util.Iterator;
import java.util.NoSuchElementException;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import immutable.list.util.core.ImList;

/**
 * @author Xingjian Xuanyuan
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
/* package-private */ enum EmptyImList implements ImList<Object> {
	SINGLETON;

	@SuppressWarnings("unchecked")
	/* package-private */ static <T> ImList<T> getSingleton() {
		return (ImList<T>) SINGLETON;
	}

	private EmptyImList() {
	}

	@Override
	public boolean isEmpty() {
		return true;
	}

	@Override
	public Object head() {

		throw new NoSuchElementException();

	}

	@Override
	public ImList<Object> tail() {

		throw new NoSuchElementException();

	}

	@Override
	public Iterator<Object> iterator() {
		
		/* return an Iterator for the EmptyImList */
		return new Iterator<Object> () {
			public boolean hasNext() {
				return false;
			}
			public Object next() {
				throw new NoSuchElementException();
			}
		};
		
	}

	@Override
	public String toString() {
		return "[]";
	}
}
