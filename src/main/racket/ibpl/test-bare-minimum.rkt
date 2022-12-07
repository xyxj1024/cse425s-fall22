#lang racket
(require "./ast.rkt")

(require "./warmup.rkt")
(require "./eval.rkt")
(require "./programs.rkt")
(require "./unit-testing.rkt")

(assert-equal? 
    (ConsExp (IntExp 3) (ConsExp (IntExp 4) (NilExp)))
    (racket-integers->IntExps '(3 4))
   "(racket-integers->IntExps '(3 4))"
)

(assert-equal? 
    '(3 4)
    (IntExps->racket-integers (ConsExp (IntExp 3) (ConsExp (IntExp 4) (NilExp))))
   "(IntExps->racket-integers (ConsExp (IntExp 3) (ConsExp (IntExp 4) (NilExp))))"
)

(assert-equal? 
    2
    (eval-exp (IfGreaterExp (IntExp 3) (IntExp 4) (IntExp 3) (IntExp 2)))
   "(eval-exp (IfGreaterExp (IntExp 3) (IntExp 4) (IntExp 3) (IntExp 2)))"
)

(assert-equal? 
    6
    (eval-exp (LetExp "x" (IntExp 1) (AddExp (IntExp 5) (IdentifierExp "x"))))
   "(eval-exp (LetExp \"x\" (IntExp 1) (AddExp (IntExp 5) (IdentifierExp \"x\"))))"
)


(define expected_12 (cons 1 2))
(assert-equal? 
    expected_12
    (eval-exp (ConsExp (IntExp 1) (IntExp 2)))
   "(eval-exp (ConsExp (IntExp 1) (IntExp 2)))"
)

(assert-equal? 
    2
    (eval-exp (CdrOfConsExp (ConsExp (IntExp 1) (IntExp 2))))
   "(eval-exp (CdrOfConsExp (ConsExp (IntExp 1) (IntExp 2))))"
)

(assert-equal? 
    3
    (eval-exp (IbIfNil (IntExp 1) (IntExp 2) (IntExp 3)))
   "(eval-exp (IbIfNil (IntExp 1) (IntExp 2) (IntExp 3)))"
)

(assert-equal? 
    10
    (eval-exp (LetExp "x" (IntExp 10) (IdentifierExp "x")))
   "(eval-exp (LetExp \"x\" (IntExp 10) (IdentifierExp \"x\")))"
)

(assert-equal? 
    4
    (eval-exp (IbIfEq (IntExp 1) (IntExp 2) (IntExp 3) (IntExp 4)))
   "(eval-exp (IbIfEq (IntExp 1) (IntExp 2) (IntExp 3) (IntExp 4)))"
)

