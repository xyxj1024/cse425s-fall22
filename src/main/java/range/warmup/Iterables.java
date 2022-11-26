/*******************************************************************************
 * Copyright (C) 2016-2019 Dennis Cosgrove
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
package range.warmup;

import java.util.Iterator;

import edu.wustl.cse.cosgroved.NotYetImplementedException;

/**
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public class Iterables {
	private static class IntegerRangeIterator implements Iterator<Integer> {

		public IntegerRangeIterator(int min, int maxExclusive, int step) {

			throw new NotYetImplementedException();

		}

		@Override
		public boolean hasNext() {

			throw new NotYetImplementedException();

		}

		@Override
		public Integer next() {

			throw new NotYetImplementedException();

		}
	}

	private static class IntegerRangeIterable implements Iterable<Integer> {

		public IntegerRangeIterable(int min, int maxExclusive, int step) {

			throw new NotYetImplementedException();

		}

		@Override
		public Iterator<Integer> iterator() {

			throw new NotYetImplementedException();

		}
	}

	public static Iterable<Integer> range(int min, int maxExclusive, int step) {

		throw new NotYetImplementedException();

	}

	public static Iterable<Integer> range(int min, int maxExclusive) {

		throw new NotYetImplementedException();

	}

	public static Iterable<Double> range(double min, double maxExclusive, double step) {

		throw new NotYetImplementedException();

	}

	public static Iterable<Double> range(double min, double maxExclusive) {

		throw new NotYetImplementedException();

	}
}
