#lang racket
(provide (all-defined-out))
(require "./ast.rkt")

; the inspiration for this assignment is MUPL
; https://drive.google.com/drive/u/1/folders/19cTksNZz470tYjIXzAiTURXiwi4N4DPG
; credit goes to Dan Grossman https://homes.cs.washington.edu/~djg/
; and his team at UW


(define (IbIfNil exp then_body_exp else_body_exp)
        (error 'not-yet-implemented)) 


(struct binding (name exp) #:transparent)

(define (IbLet* bindings body_exp) 
        (error 'not-yet-implemented)) 

(define (IbIfEq left_exp right_exp then_body_exp else_body_exp) 
        (error 'not-yet-implemented)) 


; racket version for reference
(define (racket-double n) (+ n n))

; mupl-double return a mupl-function which doubles its mupl-int argument
(define ib-double 
        'not-yet-implemented) 

; racket version for reference
(define (racket-sum-curry a) (lambda (b) (+ a b)))

; mupl-sum-curry return a mupl-function which returns a mupl-function which adds the two mupl-function's mupl-int arguments together
(define ib-sum-curry
        'not-yet-implemented) 

; racket version for reference
(define (racket-map-one proc) (proc 1))
; mupl-map-one: return a mupl-function that invoks the mupl-function passed in with the mupl-int argument 1
(define ib-map-one
        'not-yet-implemented) 

(define ib-map 
        'not-yet-implemented) 

(define ib-mapAddN 
  (LetExp "map" ib-map
                'not-yet-implemented-notice-map-is-now-in-IBPL-scope)) 
