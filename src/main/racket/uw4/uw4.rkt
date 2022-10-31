#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

; Author: Xingjian Xuanyuan

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
  (let ([res (dethunk-that stream)])
    (if (pair? res)
        (if (thunk? (cdr res)) res
            (error "Wrong next-stream"))
        (error "Failed dethunking stream"))))

; CSE 425 Utility Function
(define (cons-with-thunk-check-on-next-stream element next-stream)
  (cond
    [(thunk? next-stream) (cons element next-stream)]
    [else
     (raise-argument-error "next-stream" "thunk?" next-stream)]))

; Complete UW HW4 Below
; Function sequence(low, high, stride) returns a list of numbers
; from low to high separated by stride in sorted order.
(define (sequence low high stride)
  (if (< high low) '()
      (cons low (sequence (+ low stride) high stride))))

; Function string-append-map returns a list of strings, each element
; of which is the corresponding element of the input string list
; appended with suffix.
(define (string-append-map string-list suffix)
  (map (lambda (e)
         (string-append e suffix))
       string-list))

; Function list-nth-mod returns the (n mod length of xs)-th element
; of xs.
(define (list-nth-mod xs n)
  (cond
    [(< n 0) (error "list-nth-mod: negative number")]
    [(empty? xs) (error "list-nth-mod: empty list")]
    [#t
     (let ([rem (remainder n (length xs))])
       (list-ref xs rem))]))
;
; Sample solution:
; (define (list-nth-mod xs n)
;    (cond [(< n 0) (error "list-nth-mod: n must be non-negative")]
;          [(null? xs) (error "list-nth-mod: list must be non-empty")]
;          [#t (let* ([len (length xs)]
;                     [posn (remainder n len)])
;                (car (list-tail xs posn)))]))

; Function stream-for-n-steps returns a list holding the first n
; values produced by s in order.
(define (stream-for-n-steps s n)
  (cond
    [(zero? n) '()]
    [else (let ([p (destream s)])
            (cons (car p) (stream-for-n-steps (cdr p) (- n 1))))]))
;
; Sample solution:
; (define (stream-for-n-steps s n)
;   (if (= n 0)
;       null
;       (let ([next (s)]) ; Each thunk in the stream is evaluated at most once
;             (cons (car next) (stream-for-n-steps (cdr next) (- n 1))))))

; Function funny-number-stream
(define funny-number-stream
  (letrec ([f (lambda (x)
                (cons x (lambda ()
                          (if (= (remainder (+ x 1) 5) 0)
                              (f (- 0 (+ x 1)))
                              (f (+ (abs x) 1))))))])
    (lambda () (f 1))))
;
; Sample solution:
; (define funny-number-stream
;   (letrec ([f (lambda (n) (cons (if (= (remainder n 5) 0) (- n) n)
;                                 (lambda () (f (+ n 1)))))])
;     (lambda () (f 1))))

; Function dan-then-dog
(define dan-then-dog
  (letrec
      ([f (lambda (str ctr)
            (cons str
                  (lambda () (let ([new-ctr (+ ctr 1)])
                               (if (= (remainder new-ctr 2) 0)
                                   (f "dog.jpg" new-ctr)
                                   (f "dan.jpg" new-ctr))))))])
    (lambda () (f "dan.jpg" 1))))
;
; Sample solution:
; (define dan-then-dog
;   (letrec ([dan-st (lambda () (cons "dan.jpg" dog-st))]
;            [dog-st (lambda () (cons "dog.jpg" dan-st))])
;     dan-st))
;
; or
;
; (define (dan-then-dog)
;   (cons "dan.jpg"
;         (lambda () (cons "dog.jpg" dan-then-dog))))

; Function stream-add-zero
(define (stream-add-zero s)
  (letrec ([f (lambda (s)
                (let ([p (destream s)])
                  (cons-with-thunk-check-on-next-stream (cons 0 (car p))
                                                        (stream-add-zero (cdr p)))))])
    (lambda () (f s))))
;
; Sample solution:
; (define (stream-add-zero s)
;   (lambda ()
;     (let ([next (s)])
;       (cons (cons 0 (car next)) (stream-add-zero (cdr next))))))
    

; Function cycle-lists takes two lists xs and ys, and
; returns a stream.
(define (cycle-lists xs ys)
  (letrec
      ([f (lambda (n)
            (cons (cons (list-nth-mod xs n)
                        (list-nth-mod ys n))
                  (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

; Function vector-assoc takes a value and a vector and
; returns false if no vector element is a pair with a
; car field equal to value, else returns the first pair
; with an equal car field.
(define (vector-assoc v vec)
  (letrec
      ([f (lambda (n)
            (cond
              [(= n (vector-length vec)) #f]
              [else
               (let ([p (vector-ref vec n)])
                 (cond
                   [(pair? p) (if (equal? v (car p)) p (f (+ n 1)))]
                   [else (f (+ n 1))]))]))])
    (f 0)))
;
; Sample solution
; (define (vector-assoc v vec)
;   (letrec ([loop (lambda (i)
;                    (if (= i (vector-length vec))
;                        #f
;                        (let ([x (vector-ref vec i)])
;                          (if (and (cons? x) (equal? (car x) v))
;                              x
;                              (loop (+ i 1))))))])
;     (loop 0)))

; Function cached-assoc
(define (cached-assoc-mine xs n) ; cache slot 1 should be used for the 2 cache miss in a cache of size 3
  (letrec ([cache (make-vector n #f)]
           [ctr 0])
    (lambda (v)
      (cond
        [(vector-assoc v cache) (vector-assoc v cache)]
        [#t (let ([e (assoc v xs)])
              (if e ((lambda ()
                       (vector-set! cache ctr e)
                       (if (= ctr (- (vector-length cache) 1))
                           (set! ctr 0)
                           (+ ctr 1))
                       e))
                  #f))]))))
;
; Sample solution
(define (cached-assoc lst n)
  (let ([cache (make-vector n #f)]
        [next-to-replace 0])
    (lambda (v)
      (or (vector-assoc v cache)
          (let ([ans (assoc v lst)])
            (and ans
                 (begin (vector-set! cache next-to-replace ans)
                        (set! next-to-replace 
                              (if (= (+ next-to-replace 1) n)
                                  0
                                  (+ next-to-replace 1)))
                        ans)))))))

; Function while-less
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (let ([condition e1])
       (letrec ([loop (lambda ()
                        (let ([body e2])
                          (if (or (not (number? body)) (>= body condition))
                              #t
                              (loop))))])
         (loop)))]))