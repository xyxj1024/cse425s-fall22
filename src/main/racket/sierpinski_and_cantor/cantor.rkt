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

; Xingjian Xuanyuan
(define (cantor-stool width height n)
  (if
   (zero? n)
   (brick width height)
   (local [(define upper_fs (brick width (/ height 2)))
           (define side_fs (cantor-stool (/ width 3) (/ height 2) (sub1 n)))
           (define side_es (rectangle (/ width 3) (/ height 2) "solid" "white"))]
     (above upper_fs
      (beside side_fs side_es side_fs))))) 

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (cantor-stool 400 400 0)
  (cantor-stool 400 400 1)
  (cantor-stool 400 400 2)
  (cantor-stool 400 400 3)
  (cantor-stool 400 400 4)
  )