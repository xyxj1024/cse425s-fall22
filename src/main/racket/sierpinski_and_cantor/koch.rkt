#lang racket
(require 2htdp/image 2htdp/universe)
(require "spacer.rkt")
(provide (all-defined-out))

; Xingjian Xuanyuan
; https://docs.racket-lang.org/teachpack/2htdpimage-guide.html
(define (koch-curve side-length n)
  (cond
    [(zero? n) (triangle side-length "solid" "black")]
    [else
     (local [(define smaller (koch-curve (/ side-length 3) (- n 1)))]
       (beside/align "bottom"
                     smaller
                     (rotate 60 smaller)
                     (rotate -60 smaller)
                     smaller))]))
    
(define (koch-snowflake side-length n)
  (cond
    [(zero? n) (triangle side-length "solid" "black")]
    [else
     (local [(define c (koch-curve (/ side-length 3) n))]
       (above
        (beside
         (rotate 60 c)
         (rotate -60 c))
        (flip-vertical c)))]))

; https://course.ccs.neu.edu/cs2500f14/
(define PI (* 4.0 (atan 1.0)))

(define SCN_WIDTH 500)
(define SCN_HEIGHT 500)
(define base-scene (empty-scene SCN_WIDTH SCN_HEIGHT))

(struct posn (x y))

; Given a position, put a single dot into the scene
(define (put-dot scn p)
  (place-image (circle 3 "solid" "blue")
               (posn-x p) (posn-y p)
               scn))

; Given a list of positions, draw the dots
(define (draw-dots ps)
  (cond [(empty? ps) base-scene]
        [else (put-dot (draw-dots (rest ps)) (first ps))]))

; Put a line in the scene starting at (x, y) len distance in the given
; direction with the given color
(define (put-line x y ang len color scn)
  (place-image (line (* (cos ang) len)
                     (* (sin ang) len) color)
               (+ x (* (cos ang) (/ len 2)))
               (+ y (* (sin ang) (/ len 2))) scn))

; TODO: fractal-tree, fractal-snowflake, draw to scene

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (koch-curve 400 3)
  (koch-curve 400 4)
  (koch-curve 400 5)
  (koch-curve 400 6)
  (koch-curve 400 7)

  (koch-snowflake 400 3)
  (koch-snowflake 400 4)
  (koch-snowflake 400 5)
  (koch-snowflake 400 6)
  (koch-snowflake 400 7)
  )