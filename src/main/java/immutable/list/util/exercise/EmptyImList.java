package immutable.list.util.exercise;

import java.util.Iterator;
import java.util.NoSuchElementException;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import immutable.list.util.core.ImList;

/**
 * @author __STUDENT_NAME__
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
/* package-private */ enum EmptyImList implements ImList<Object> {
	SINGLETON;

	@SuppressWarnings("unchecked")
	/* package-private */ static <T> ImList<T> getSingleton() {
		return (ImList<T>) SINGLETON;
	}

	private EmptyImList() {

		throw new NotYetImplementedException();

	}

	@Override
	public boolean isEmpty() {

		throw new NotYetImplementedException();

	}

	@Override
	public Object head() {

		throw new NotYetImplementedException();

	}

	@Override
	public ImList<Object> tail() {

		throw new NotYetImplementedException();

	}

	@Override
	public Iterator<Object> iterator() {

		throw new NotYetImplementedException();

	}

	@Override
	public String toString() {
		return "[]";
	}
}
