#lang racket
(require 2htdp/image)
(provide (all-defined-out))

; Xingjian Xuanyuan


(define (castle base-width)
  (overlay/align/offset
   "left" "bottom"
   (overlay/offset
    (overlay/align/offset
     "left" "bottom"
     (frame (rectangle (/ base-width 6) base-width "solid" "gray"))
     0 (/ base-width -1)
     (triangle (/ base-width 6) "solid" "green"))
    (/ base-width 40) (/ base-width -1.72)
    (rotate -90 (isosceles-triangle (/ base-width 20) 20 "solid" "red")))
   (/ base-width 6) 0
   (overlay/align/offset
    "left" "bottom"
    (overlay/align "middle" "bottom"
                   (overlay/offset (square (/ base-width 4) "solid" "brown")
                                   0 (/ base-width (* -4 (sqrt 2)))
                                   (wedge (/ base-width 8) 180 "solid" "brown"))
                   (frame (rectangle base-width (* base-width 0.8) "solid" "gray"))
                   (overlay/offset
                    (overlay/align/offset
                     "left" "bottom"
                     (frame (rectangle (/ base-width 6) (* base-width 1.2) "solid" "gray"))
                     0 (* base-width -1.2)
                     (triangle (/ base-width 6) "solid" "green"))
                    (/ base-width 40) (/ base-width -1.47)
                    (rotate -90 (isosceles-triangle (/ base-width 20) 20 "solid" "red"))))
    base-width 0
    (overlay/offset
     (overlay/align/offset
      "left" "bottom"
      (frame (rectangle (/ base-width 6) base-width "solid" "gray"))
      0 (/ base-width -1)
      (triangle (/ base-width 6) "solid" "green"))
     (/ base-width 40) (/ base-width -1.72)
     (rotate -90 (isosceles-triangle (/ base-width 20) 20 "solid" "red"))))))

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (castle 300)
  )
