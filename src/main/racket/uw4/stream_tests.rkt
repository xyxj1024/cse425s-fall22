#lang racket
(require "uw4.rkt")
(require rackunit)
(require rackunit/text-ui)

(define not-a-thunk-value 231)
(define (not-a-thunk-function-arity x) (* x x))

(define powers-of-two-stream
  (letrec ([f (lambda (x)
                (cons-with-thunk-check-on-next-stream x (thunk-that (f (* x 2)))))])
    (thunk-that (f 1))))

(define (pair-to-values pair)
  (if (pair? pair)
      (values (car pair) (cdr pair))
      (raise-argument-error "pair" "pair?" pair)))

(define-values (should-be-1 next-stream) (pair-to-values (destream powers-of-two-stream)))
(define-values (should-be-2 next-next-stream) (pair-to-values (destream next-stream)))
(define-values (should-be-4 next-next-next-stream) (pair-to-values (destream next-next-stream)))
(define-values (should-be-8 next-next-next-next-stream) (pair-to-values(destream next-next-next-stream)))

(define stream-tests
  (test-suite
   "stream"

   (check-eq? 1 should-be-1)
   (check-eq? 2 should-be-2)
   (check-eq? 4 should-be-4)
   (check-eq? 8 should-be-8)

   (check-exn exn:fail? (lambda () (destream (dethunk-that powers-of-two-stream))))

   (check-exn exn:fail? (lambda () (destream (thunk-that (cons "ignored" not-a-thunk-value)))))
   (check-exn exn:fail? (lambda () (destream (thunk-that (cons "ignored" not-a-thunk-function-arity)))))

   (check-exn exn:fail? (lambda () (cons-with-thunk-check-on-next-stream "ignored" not-a-thunk-value)))
   (check-exn exn:fail? (lambda () (cons-with-thunk-check-on-next-stream "ignored" not-a-thunk-function-arity)))
   )
  )

(println stream-tests)
(run-tests stream-tests 'verbose)
