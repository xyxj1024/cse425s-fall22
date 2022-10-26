#lang racket
(require "uw4.rkt")
(require rackunit)
(require rackunit/text-ui)

(define thunk-via-lambda (lambda () 4))
(define (thunk-via-parens) 66)
(define thunk-via-thunk (thunk 99))
(define not-a-thunk-value 231)
(define (not-a-thunk-function-arity x) (* x x))

(define thunk?-and-dethunk-that-tests
  (test-suite
   "thunk? and dethunk-that"

   (check-true (thunk? thunk-via-lambda))
   (check-eq? (dethunk-that thunk-via-lambda) 4)

   (check-true (thunk? thunk-via-parens))
   (check-eq? (dethunk-that thunk-via-parens) 66)

   (check-true (thunk? thunk-via-thunk))
   (check-eq? (dethunk-that thunk-via-thunk) 99)

   (check-false (thunk? not-a-thunk-value))
   (check-exn exn:fail? (lambda () (dethunk-that not-a-thunk-value)))

   (check-false (thunk? not-a-thunk-function-arity))
   (check-exn exn:fail? (lambda () (dethunk-that not-a-thunk-function-arity)))
   ))

(define expected-false (thunk? 1)) ; trip raised error if not yet implemented
(define expected-4 (dethunk-that thunk-via-lambda)) ; trip raised error if not yet implemented

(println thunk?-and-dethunk-that-tests)
(run-tests thunk?-and-dethunk-that-tests 'verbose)

(define thunk-via-thunk-that (thunk-that 425))
(define thunk-that-poison (thunk-that (raise (error "poison"))))

(define thunk-that-tests
  (test-suite
   "thunk-that"

   (check-true (procedure? thunk-via-thunk-that))
   (check-eq? (procedure-arity thunk-via-thunk-that) 0)
   (check-true (thunk? thunk-via-thunk-that))
   (check-eq? (thunk-via-thunk-that) 425)
   (check-eq? (dethunk-that thunk-via-thunk-that) 425)

   (check-true (procedure? thunk-that-poison))
   (check-eq? (procedure-arity thunk-that-poison) 0)
   (check-true (thunk? thunk-that-poison))

   (check-exn exn:fail? (lambda () (dethunk-that thunk-that-poison)))
   ))

(println thunk-that-tests)
(run-tests thunk-that-tests 'verbose)
