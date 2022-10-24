#lang racket
(require 2htdp/image)
(require "spacer.rkt")
(provide (all-defined-out))

(define (brick w h)
  (overlay
   (rectangle w h "outline" "blue")
   (rectangle w h "solid" "red")
   )
  )

; __STUDENT_NAME__
(define (cantor-stool width height n)
        (error 'not-yet-implemented)) 

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (cantor-stool 400 400 0)
  (cantor-stool 400 400 1)
  (cantor-stool 400 400 2)
  (cantor-stool 400 400 3)
  (cantor-stool 400 400 4)
)