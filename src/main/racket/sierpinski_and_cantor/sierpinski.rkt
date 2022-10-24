#lang racket
(require 2htdp/image)
(require "spacer.rkt")
(provide (all-defined-out))

; Xingjian Xuanyuan
(define (sierpinski-triangle side-length n)
  (if
   (zero? n)
   (triangle side-length "solid" "blue")
   (above (sierpinski-triangle (/ side-length 2) (sub1 n))
          (beside
           (sierpinski-triangle (/ side-length 2) (sub1 n))
           (sierpinski-triangle (/ side-length 2) (sub1 n))))))

(define (sierpinski-carpet side-length n)
  (if
   (zero? n)
   (square side-length "solid" "orange")
   (local [(define fs (sierpinski-carpet (/ side-length 3) (sub1 n))) ; filled square
           (define es (square (/ side-length 3) "solid" "white"))]    ; empty square
     (above
      (beside fs fs fs)
      (beside fs es fs)
      (beside fs fs fs)))))


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
  