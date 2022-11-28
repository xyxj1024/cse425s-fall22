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

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Iterator;
import java.util.NoSuchElementException;

import org.junit.Test;

import immutable.list.util.core.ImList;

/**
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public class IteratorMethodThrowsNoSuchElementExceptionTest {
	@Test(expected = NoSuchElementException.class)
	public void testEmpty() {
		ImList<String> empty = ImLists.nil();
		Iterator<String> emptyIterator = empty.iterator();
		assertNotNull(emptyIterator);
		assertFalse(emptyIterator.hasNext());
		emptyIterator.next();
	}

	@Test(expected = NoSuchElementException.class)
	public void testABC() {
		ImList<String> abc = ImLists.brackets("A", "B", "C");
		Iterator<String> abcIterator = abc.iterator();
		assertNotNull(abcIterator);
		assertTrue(abcIterator.hasNext());
		assertEquals("A", abcIterator.next());
		assertTrue(abcIterator.hasNext());
		assertEquals("B", abcIterator.next());
		assertTrue(abcIterator.hasNext());
		assertEquals("C", abcIterator.next());
		assertFalse(abcIterator.hasNext());
		abcIterator.next();
	}
}
