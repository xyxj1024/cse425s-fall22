#lang racket
(require 2htdp/image)
(require "spacer.rkt")
(provide (all-defined-out))

; __STUDENT_NAME__
(define (sierpinski-triangle side-length n)
        (error 'not-yet-implemented)) 

(define (sierpinski-carpet side-length n)
        (error 'not-yet-implemented)) 


(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (sierpinski-triangle 400 0)
  (sierpinski-triangle 400 1)
  (sierpinski-triangle 400 2)
  (sierpinski-triangle 400 3)
  (sierpinski-triangle 400 4)

  (sierpinski-carpet 400 0)
  (sierpinski-carpet 400 1)
  (sierpinski-carpet 400 2)
  (sierpinski-carpet 400 3)
  (sierpinski-carpet 400 4)
)
