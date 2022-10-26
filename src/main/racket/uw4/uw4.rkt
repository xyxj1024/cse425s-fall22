
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; Xingjian Xuanyuan

; Complete WashU Thunk and Stream WarmUp Below

; CSE 425 Utility Function
(define (thunk? th)
  (if (and (procedure? th) (zero? (procedure-arity th))) #t #f))

; CSE 425 Utility Macro
; NOTE: macros use define-syntax-rule
(define-syntax-rule (thunk-that e)
  (lambda () e))

; CSE 425 Utility Function
(define (dethunk-that thunk)
  (thunk))

; CSE 425 Utility Function
(define (destream stream)
  (stream)) 

; CSE 425 Utility Function
(define (cons-with-thunk-check-on-next-stream element next-stream)
  (next-stream)) 

; Complete UW HW4 Below


