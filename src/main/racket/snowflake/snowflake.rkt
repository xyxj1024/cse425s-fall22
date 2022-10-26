#lang racket
(require 2htdp/image)
(provide (all-defined-out))

; Xingjian Xuanyuan
(define (partial-snowflake len iter is-flipped)
  (cond
    [(zero? iter) (line len 0 "blue")]
    [else
     (local [(define smaller (partial-snowflake (/ len 3) (- iter 1) is-flipped))]
       (beside/align "bottom"
                     smaller
                     (rotate 60 smaller)
                     (if is-flipped
                         (rotate 120 smaller)
                         (rotate -60 smaller))
                     smaller))]))

(define (snowflake len iter is-flipped) 
        (cond
          [(zero? iter) (line len 0 "blue")]
          [else
           (local [(define c (partial-snowflake (/ len 3) (- iter 1) is-flipped))]
             (above
              (beside
               (rotate 60 c)
               (rotate -60 c))
              (flip-vertical c)))])) 

(define (snowflake-symmetric len iter)
  (snowflake len iter #f))

(define (snowflake-flipped len iter)
  (snowflake len iter #t))

(module+ main ; evualated when enclosing module is run directly (that is: not via require)
  (for-each
   displayln
   (local
     ([define length 400])
     (append
      (for/list ([iter (in-range 5)])
        (partial-snowflake length iter #f))
      (for/list ([iter (in-range 5)])
        (snowflake-symmetric length iter))
      (for/list ([iter (in-range 5)])
        (partial-snowflake length iter #t))
      (for/list ([iter (in-range 5)])
        (snowflake-flipped length iter))))))
