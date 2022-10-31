#lang racket
(require 2htdp/image)
(require 2htdp/universe)
(provide (all-defined-out))

; Xingjian Xuanyuan

(define scene-width 800)
(define scene-height 500)

(struct state () #:transparent)

(define (tick st)
  st)

(define (draw st)
  (empty-scene scene-width scene-height))

(define (mouse st x y e)
  st)

(big-bang (state)
  [on-tick tick]
  [to-draw draw]
  [on-mouse mouse]
  )
