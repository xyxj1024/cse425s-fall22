#lang racket
(require lang/posn)
(require 2htdp/image)
(require 2htdp/universe)
(provide (all-defined-out))

(define scene-width 800)
(define scene-height 500)

(struct state (target-location image-location) #:transparent)

(define (update-target ws)
  (let* (
         [tx (posn-x (state-image-location ws))]
         [ty (posn-y (state-image-location ws))]
         [mx (posn-x (state-target-location ws))]
         [my (posn-y (state-target-location ws))]
         [dx (- mx tx)]
         [dy (- my ty)]
         [tx-prime (+ tx (* dx 0.15))]
         [ty-prime (+ ty (* dy 0.15))]
         )
    (make-posn tx-prime ty-prime)))

(define (tick st)
  (state
   (state-target-location st)
   (update-target st)
   ))



(define (draw st) 
            (place-image (circle 24 "solid" "blue")
               (posn-x (state-image-location st)) (posn-y (state-image-location st))
               (empty-scene scene-width scene-height))) 

;   (circle 24 "solid" "blue")

(define (mouse st x y e)
  (state
   (make-posn x y)
   (state-image-location st)
   ))

(define initial-location (make-posn (* scene-width 0.5) (* scene-height 0.5)))
(big-bang (state initial-location initial-location)
  [on-tick tick]
  [to-draw draw]
  [on-mouse mouse]
  )
