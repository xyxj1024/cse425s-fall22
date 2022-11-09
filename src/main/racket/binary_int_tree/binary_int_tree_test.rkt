#lang racket
(require "binary_int_tree.rkt")

(require rackunit)

(define contains-tests
  (test-suite
   "contains"
  
   (check-false (contains empty-tree 425))
   (check-true (contains (branch #f 425 #f) 425))
   (check-false (contains (branch #f 425 #f) 231))
   (check-true (contains (branch (branch #f 231 #f) 425 #f) 425))
   (check-true (contains (branch (branch #f 231 #f) 425 #f) 231))
   (check-false (contains (branch (branch #f 231 #f) 425 #f) 42))
   (check-true (contains (branch #f 231 (branch #f 425 #f)) 425))
   (check-true (contains (branch #f 231 (branch #f 425 #f)) 231))
   (check-false (contains (branch #f 231 (branch #f 425 #f)) 42))
  )
)

(define (fold-rnl f init tree)
  (if (branch? tree)
      (local {(define acc (fold-rnl f init (branch-right tree)))
              (define acc-prime (f (branch-x tree) acc))
              (define acc-prime-prime (fold-rnl f acc-prime (branch-left tree)))}
        acc-prime-prime)
      init))

(define (to-list tree)
  (fold-rnl cons null tree))

(define (insert-all xs)
  (foldl (lambda (x tree) (insert tree x)) empty-tree xs))

(define t (insert-all (list 8 6 7 5 3 0 9)))

(define insert-tests
  (test-suite
   "insert"
  
   (check-equal? (to-list (insert empty-tree 425)) '(425))
   (check-equal? (to-list (insert (insert empty-tree 425) 231)) '(231 425))
   (check-equal? (to-list (insert (insert (insert empty-tree 425) 231) 300)) '(231 300 425))
   (check-equal? (to-list (insert (insert (insert (insert empty-tree 425) 231) 300) 42)) '(42 231 300 425))
   (check-true (contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 425))
   (check-true (contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 231))
   (check-true (contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 300))
   (check-true (contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 42))
   (check-false (contains (insert (insert (insert (insert empty-tree 425) 231) 300) 42) 7))

   (check-equal? (to-list (insert-all '(8 6 7 5 3 0 9))) '(0 3 5 6 7 8 9))
  )
)

(define sum-tests
  (test-suite
   "sum"
  
   (check-equal? (sum empty-tree) 0)
   (check-equal? (sum (insert empty-tree 425)) 425)
   (check-equal? (sum (insert-all '(425 231))) 656)
   (check-equal? (sum (insert-all '(300 425 231))) 956)
   (check-equal? (sum (insert-all '(425 42 300 231))) 998)
   (check-equal? (sum (insert-all '(8 6 7 5 3 0 9))) 38)
   ))


(require rackunit/text-ui)

(run-tests contains-tests)
(run-tests insert-tests)
(run-tests sum-tests)
