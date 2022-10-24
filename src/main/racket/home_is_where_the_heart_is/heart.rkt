#lang racket
(require 2htdp/image)
(provide (all-defined-out))

; Xingjian Xuanyuan

(define (heart side-length color)
  (overlay/offset (rotate 45 (square side-length "solid" color))
                                  0 (- 16 (/ side-length 2))
                                  (overlay/offset (rotate 45 (wedge (/ side-length 2) 180 "solid" color))
                                  (/ (* (sqrt 2) side-length) 1.68) 0
                                  (rotate -45 (wedge (/ side-length 2) 180 "solid" color)))))


(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (heart 200 "red")
)
