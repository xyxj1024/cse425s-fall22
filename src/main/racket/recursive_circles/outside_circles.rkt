#lang racket
(require 2htdp/image)
(provide outside-circles)

(define base-case-color (make-color 144 0 0))
(define recursive-case-color (make-color 0 109 219))

; Xingjian Xuanyuan
(define (outside-circles radius n)
  (cond
    [(zero? n) (circle radius "solid" base-case-color)]
    [else (local [(define newn (- n 1))
                  (define newr (/ (* radius 3) 4))
                  (define cent (circle newr "outline" recursive-case-color))
                  (define peri (outside-circles (/ newr 3) newn))]
            (beside peri
                     (above peri cent peri)
                     peri))]))

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (displayln 0)
  (outside-circles 128 0)
  (displayln "\n\n1")
  (outside-circles 128 1)
  (displayln "\n\n2")
  (outside-circles 128 2)
  (displayln "\n\n3")
  (outside-circles 128 3)
  )
