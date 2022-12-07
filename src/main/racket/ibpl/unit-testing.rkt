#lang racket
(provide (all-defined-out))
(require rackunit)

(define (assert-equal? expected actual message)
  (begin
    (if (equal? expected actual)
        (displayln (string-append "success assert-equal?\n    case: " message "\nexpected: " (~v expected) "\n  actual: " (~v actual) "\n"))
        (begin
          (displayln (string-append "FAILURE! assert-equal?\n    case: " message "\nexpected: " (~v expected) "\n  actual: " (~v actual) "\n") (current-error-port))
          (error (string-append "expected: " (~v expected) "; actual: " (~v actual)))
          
          )
        )
    )
  )
