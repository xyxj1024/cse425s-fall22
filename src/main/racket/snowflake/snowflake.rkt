#lang racket
(require 2htdp/image)
(provide (all-defined-out))

; __STUDENT_NAME__
(define (snowflake len iter is-flipped) 
        (raise (error 'not-yet-implemented))) 

(define (snowflake-symmetric len iter)
  (snowflake len iter #f))

(define (snowflake-flipped len iter)
  (snowflake len iter #t))

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (for-each
   displayln
   (local
     ([define length 400])
     (append
      (for/list ([iter (in-range 5)])
        (snowflake-symmetric length iter))
      (for/list ([iter (in-range 5)])
        (snowflake-flipped length iter))))))
