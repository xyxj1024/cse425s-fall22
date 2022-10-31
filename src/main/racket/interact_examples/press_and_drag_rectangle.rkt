#lang racket
(require lang/posn)
(require 2htdp/image)
(require 2htdp/universe)
(provide (all-defined-out))

(define scene-width 800)
(define scene-height 500)

(struct state (press drag) #:transparent)

(define (draw st)
  (local ((define (center-x st)
            (* (+ (posn-x (state-press st)) (posn-x (state-drag st))) 0.5))

          (define (center-y st)
            (* (+ (posn-y (state-press st)) (posn-y (state-drag st))) 0.5))

          (define (width st)
            (abs (- (posn-x (state-press st)) (posn-x (state-drag st)))))

          (define (height st)
            (abs (- (posn-y (state-press st)) (posn-y (state-drag st))))))
    
    (place-image 
           (rectangle (width st) (height st) "solid" "blue") 
     (center-x st) (center-y st)
     (empty-scene scene-width scene-height))))

(define (mouse st x y e)
  (local ((define (update-press-and-drag x y)
            (state
             (make-posn x y)
             (make-posn x y)))

          (define (update-drag st x y)
            (state
             (state-press st)
             (make-posn x y))))
    (cond [(equal? e "button-down") (update-press-and-drag x y)]
          [(equal? e "drag") (update-drag st x y)]
          [else st]
          )))

(big-bang (state (make-posn 0 0) (make-posn 0 0))
  [to-draw draw]
  [on-mouse mouse]
  )
