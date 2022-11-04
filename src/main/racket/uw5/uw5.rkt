;; Programming Languages, Homework 5, MUPL ("Made Up Programming Language")
; Replace ocurrences of "CHANGE" to complete the problems.
; Do not use any mutation (set!, set-mcar!, etc.) anywhere in the assignment.

;; A MUPL value is a MUPL integer constant, a MUPL closure, a MUPL aunit,
; or a MUPL pair of MUPL values. A MUPL list is nested pair values that
; end with a MUPL aunit.

; Notes taken from class on Wed Nov. 2:
;; Compilers translate a program to another language while interpreters
; evaluate a program. In practice, languages whose default runtime
; implementation is an interpreter tend to be more flexible; compilers
; tend to compile a program into assembly language.
;; Lisp 1962 bootstrapping
;; Kotlin generates to Java bytecode
;; You have to decide what your language will support when implementing it,
; as well as how will the programmer express these things in your language.
;; The evaluation of a function is a value with two parts: 1) the code itself
; 2) the lexical scope environment.

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

(define (racketlist->mupllist rl)
  (cond
    [(null? rl) (aunit)] ; (aunit) is a MUPL expression but aunit is not
    [#t (apair (first rl) (racketlist->mupllist (list-tail rl 1)))]))

(define (mupllist->racketlist ml)
  (cond
    [(aunit? ml) '()]
    [#t (cons (apair-e1 ml) (mupllist->racketlist (apair-e2 ml)))]))

; Xingjian Xuanyuan


;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

; CSE 425 utility
(define (mupl-value? value)
  (let ([reg (and (not (int? value))
                  (not (closure? value))
                  (not (aunit? value))
                  (not (apair? value)))])
    (not reg)))

; CSE 425 utility
(define (expand-environment name value env)
  (cond
    [(not (string? name)) (error (string-append "illegal name: " (~a name)))]
    [(not (mupl-value? value)) (error (string-append "illegal value: " (~a value)))]
    [#t (cons (cons name value) env)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(int? e) e] ; this is trivial
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; CHANGE add more cases here
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater comparing non-numbers")))]
        [(fun? e) (closure env e)] ; this is trivial
        [(call? e)
         (let ([v1 (eval-under-env (call-funexp e) env)]
               [v2 (eval-under-env (call-actual e) env)])
           (if (not (closure? v1))
               (error "MUPL call-funexp not a closure")
               (let ([function-name (fun-nameopt (closure-fun v1))])
                 (if (not function-name) ; the first argument is #f
                     (eval-under-env (fun-body (closure-fun v1))
                                     (expand-environment (fun-formal (closure-fun v1))
                                                         v2
                                                         (closure-env v1)))
                     (eval-under-env (fun-body (closure-fun v1))
                                     (expand-environment (fun-formal (closure-fun v1))
                                                         v2
                                                         (expand-environment function-name
                                                                             v1
                                                                             (closure-env v1))))))))]
        [(mlet? e)
         (let ([v (eval-under-env (mlet-e e) env)])
           (eval-under-env (mlet-body e) (expand-environment (mlet-var e) v env)))]
        [(apair? e)
         (let ([v1 (eval-under-env (apair-e1 e) env)]
               [v2 (eval-under-env (apair-e2 e) env)])
           (apair v1 v2))]
        [(fst? e)
         (let ([v (eval-under-env (fst-e e) env)])
           (if (apair? v)
               (apair-e1 v)
               (error "MUPL fst applied to non-pair")))]
        [(snd? e)
         (let ([v (eval-under-env (snd-e e) env)])
           (if (apair? v)
               (apair-e2 v)
               (error "MUPL snd applied to non-pair")))]
        [(aunit? e) e] ; this is trivial
        [(isaunit? e)
         (let ([v (eval-under-env (isaunit-e e) env)])
           (if (aunit? v) (int 1) (int 0)))]
        [(closure? e) e] ; this is trivial
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Function eval-exp takes a MUPL expression e and either
;; returns the MUPL value that e evaluates to under the empty environment or
;; calls Racket's error if evaluation encounters a run-time MUPL type error
;; or unbound UPL variable.
;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3
;; Do not use closure and eval-exp.

(define (ifaunit e1 e2 e3)
  (ifgreater (isaunit e1) (int 0) e2 e3)) 

;; Function mlet* takes a Racket list of Racket pairs, where
;; the first component is a Racket string and the second component
;; is a MUPL expression, and a final MUPL expression; returns a
;; MUPL expression whose value is evaluated in an environment defined
;; by the list of (name . value) pairs.
(define (mlet* lstlst e2)
  (cond
    [(null? lstlst) e2]
    [else
     (let ([v (first lstlst)])
       (mlet (car v) (cdr v) (mlet* (list-tail lstlst 1) e2)))]))

;; Function ifeq acts like ifgreater except e3 is evaluated if and only if
;; e1 and e2 are equal integers.
;(define (ifeq e1 e2 e3 e4)
;(if (and (int? e1)
;(int? e2)
;(equal? (int-num e1) (int-num e2)))
;e3
;e4))
(define (ifeq e1 e2 e3 e4)
  (mlet* (list (cons "_x" e1) (cons "_y" e2))
         (ifgreater (var "_x")
                    (var "_y")
                    e4
                    (ifgreater (var "_y") (var "_x") e4 e3))))

;; Problem 4

; Complete WashU MUPL Programs Studio Below

;; For your MUPL programs you should be constructing MUPL abstract
; syntax trees out of the MUPL structs provided by Professor Grossman.
; The result of each program is a MUPL function comprised of MUPL
; expressions and the occasional string, int, and boolean constant
; (e.g., "fred", 42, #f) which the MUPL structs require.

; racket version for reference
(define (racket-double n) (+ n n))
; CSE 425 MUPL Program
; mupl-double return a mupl-function (closure) which doubles its mupl-int argument
(define mupl-double
  (closure '() (fun #f "x" (add (var "x") (var "x")))))

; racket version for reference
(define (racket-sum-curry a) (lambda (b) (+ a b)))
; CSE 425 MUPL Program
; mupl-sum-curry return a mupl-function which returns a mupl-function which adds the two mupl-function's mupl-int arguments together
(define mupl-sum-curry
  (closure '() (fun #f "b" (fun #f "a" (add (var "a") (var "b"))))))

; racket version for reference
(define (racket-map-one proc) (proc 1))
; CSE 425 MUPL Program
; mupl-map-one: return a mupl-function that invokes the mupl-function passed in with the mupl-int argument 1
(define mupl-map-one
  (closure '() (fun #f "proc" (call (var "proc") (int 1))))) 

; UW HW4 Continues Below

;; Function mupl-map takes a MUPL function and returns a MUPL function
; that takes a MUPL list and applies the function to every element of
; the list returning a new MUPL list.
(define mupl-map
  (closure '()
           (fun "map" "f"
                (fun "rmap" "l"
                     (ifaunit (var "l")
                              (aunit)
                              (apair (call (var "f") (fst (var "l")))
                                     (call (var "rmap") (snd (var "l")))))))))

;; Function mupl-mapAddN takes an MUPL integer i and returns a MUPL function
; that takes a MUPL list of MUPL integers and returns a new MUPL list of
; MUPL integers that adds i to every element of the list.
(define mupl-mapAddN 
  (mlet "map" mupl-map
        (fun "f-int" "i"
             (fun "f-list" "is"
                  (call (call (var "map") (fun "add-i" "x" (add (var "i") (var "x"))))
                        (var "is")))))) 

;; Challenge Problem

;; Store freevars as a Racket set of Racket strings
(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; Function compute-free-vars takes an expression and returns a
; different expression that uses fun-challenge everywhere in place
; of fun.
(define (compute-free-vars e)
  (letrec
      ([f
        (lambda (e)
          (cond
            [(var? e) (cons e (set (var-string e)))]
            [(int? e) (cons e (set))]
            [(add? e) (let ([v1 (car (f (add-e1 e)))]
                            [v2 (cdr (f (add-e1 e)))]
                            [v3 (car (f (add-e2 e)))]
                            [v4 (cdr (f (add-e2 e)))])
                        (cons (add v1 v3) (set-union v2 v4)))]
            [(ifgreater? e) (let ([v1 (car (f (ifgreater-e1 e)))]
                                  [v2 (car (f (ifgreater-e2 e)))]
                                  [v3 (car (f (ifgreater-e3 e)))]
                                  [v4 (car (f (ifgreater-e4 e)))]
                                  [v5 (cdr (f (ifgreater-e1 e)))]
                                  [v6 (cdr (f (ifgreater-e2 e)))]
                                  [v7 (cdr (f (ifgreater-e3 e)))]
                                  [v8 (cdr (f (ifgreater-e4 e)))])
                              (cons (ifgreater v1 v2 v3 v4) (set-union (v5 v6 v7 v8))))]
            [(fun? e) (let* ([body (f (fun-body e))]
                             [fvar (set-remove (cdr body) (fun-formal e))]
                             [fvar (if (fun-nameopt e)
                                       (set-remove fvar (fun-nameopt e))
                                       fvar)])
                        (cons (fun-challenge (fun-nameopt e)
                                             (fun-formal e)
                                             (car body)
                                             fvar)))]
            [(call? e) (let ([v1 (f (call-funexp e))]
                             [v2 (f (call-actual e))])
                         (cons (call (car v1) (car v2)) (set-union (cdr v1) (cdr v2))))]
            [(mlet? e) (let* ([v1 (car (f (mlet-e e)))]
                              [v2 (car (f (mlet-body e)))]
                              [v3 (cdr (f (mlet-e e)))]
                              [v4 (cdr (f (mlet-body e)))])
                         (cons (mlet (mlet-var e) v1 v2) (set-union v3 (set-remove v4 (mlet-var e)))))]
            [(apair? e) (let ([v1 (f (apair-e1 e))]
                              [v2 (f (apair-e2 e))])
                          (cons (apair (car v1) (car v2)) (set-union (cdr v1) (cdr v2))))]
            [(fst? e) (let ([v1 (car (f (fst-e e)))]
                            [v2 (cdr (f (fst-e e)))])
                        (cons (fst v1) v2))]
            [(snd? e) (let ([v1 (car (f (snd-e e)))]
                            [v2 (cdr (f (snd-e e)))])
                        (cons (snd v1) v2))]
            [(aunit? e) (cons e (set))]
            [(isaunit? e) (let ([v1 (car (f (isaunit-e e)))]
                                [v2 (cdr (f (isaunit-e e)))])
                            (cons (isaunit v1) v2))]))])
    (car (f e)))) 

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
;; This version builds closures with smaller environments:
; when building a closure, it uses an environment that is like the
; current environment but holds only variables that are free variables
; in the function part of the closure. (A free variable is a variable
; that appears in the function without being under some shadowing
; binding for the same variable.)
(define (eval-under-env-c e env)
  (cond
    [(fun-challenge? e) (closure (set-map (fun-challenge-freevars e)
                                          (lambda (s)
                                            (cons s (envlookup env s))))
                                 e)]
    [(var? e) 
     (envlookup env (var-string e))]
    [(int? e) e] ; this is trivial
    [(add? e) 
     (let ([v1 (eval-under-env (add-e1 e) env)]
           [v2 (eval-under-env (add-e2 e) env)])
       (if (and (int? v1)
                (int? v2))
           (int (+ (int-num v1) 
                   (int-num v2)))
           (error "MUPL addition applied to non-number")))]
    ;; CHANGE add more cases here
    [(ifgreater? e)
     (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
           [v2 (eval-under-env (ifgreater-e2 e) env)])
       (if (and (int? v1) (int? v2))
           (if (> (int-num v1) (int-num v2))
               (eval-under-env (ifgreater-e3 e) env)
               (eval-under-env (ifgreater-e4 e) env))
           (error "MUPL ifgreater comparing non-numbers")))]
    [(call? e)
     (let ([v1 (eval-under-env (call-funexp e) env)]
           [v2 (eval-under-env (call-actual e) env)])
       (if (not (closure? v1))
           (error "MUPL call-funexp not a closure")
           (let ([function-name (fun-challenge-nameopt (closure-fun v1))])
             (if (not function-name) ; the first argument is #f
                 (eval-under-env (fun-challenge-body (closure-fun v1))
                                 (expand-environment (fun-challenge-formal (closure-fun v1))
                                                     v2
                                                     (closure-env v1)))
                 (eval-under-env (fun-challenge-body (closure-fun v1))
                                 (expand-environment (fun-challenge-formal (closure-fun v1))
                                                     v2
                                                     (expand-environment function-name
                                                                         v1
                                                                         (closure-env v1))))))))]
    [(mlet? e)
     (let ([v (eval-under-env (mlet-e e) env)])
       (eval-under-env (mlet-body e) (expand-environment (mlet-var e) v env)))]
    [(apair? e)
     (let ([v1 (eval-under-env (apair-e1 e) env)]
           [v2 (eval-under-env (apair-e2 e) env)])
       (apair v1 v2))]
    [(fst? e)
     (let ([v (eval-under-env (fst-e e) env)])
       (if (apair? v)
           (apair-e1 v)
           (error "MUPL fst applied to non-pair")))]
    [(snd? e)
     (let ([v (eval-under-env (snd-e e) env)])
       (if (apair? v)
           (apair-e2 v)
           (error "MUPL snd applied to non-pair")))]
    [(aunit? e) e] ; this is trivial
    [(isaunit? e)
     (let ([v (eval-under-env (isaunit-e e) env)])
       (if (aunit? v) (int 1) (int 0)))]
    [(closure? e) e] ; this is trivial
    [#t (error (format "bad MUPL expression: ~v" e))]))


;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
