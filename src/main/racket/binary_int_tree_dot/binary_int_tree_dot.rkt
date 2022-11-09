#lang racket

(require "../binary_int_tree/binary_int_tree.rkt")

(define (to-dot root)
  (local {(define (node-to-dot bl bx br)
            (string-append "\t" (~a bx) " [label= \"{ " (~a bx) " | { " (if bl "<child_left>" "&bull;") " | " (if bl "<child_right>" "&bull;") " } }\"]" ))
          (define (nodes-to-dot tree)
            (if (branch? tree)
                (local {(define bl (branch-left tree))
                        (define bx (branch-x tree))
                        (define br (branch-right tree))}
                  (string-append (node-to-dot bl bx br) "\n" (nodes-to-dot bl) "\n" (nodes-to-dot br)))
                ""))
          (define (edge-to-dot node parent tag)
            (if parent
                (string-append "\t" (~a parent) tag " -> " (~a node))
                ""
                ))
          (define (edges-to-dot tree parent tag)
             (if (branch? tree)
                (local {(define bl (branch-left tree))
                        (define bx (branch-x tree))
                        (define br (branch-right tree))}
                  (string-append (edge-to-dot bx parent tag) "\n" (edges-to-dot bl bx ":child_left:center") "\n" (edges-to-dot br bx ":child_right:center")))
                ""))}
          (string-append "digraph g {\n\n\tnode [\n\t\tshape = record\n\t]\n\n\tedge [\n\t\ttailclip=false,\n\t\tarrowhead=vee,\n\t\tarrowtail=dot,\n\t\tdir=both\n\t]\n\n" (nodes-to-dot root) (edges-to-dot root #f "") "\n}\n")))


(define (insert-all xs)
  (foldl (lambda (x tree) (insert tree x)) empty-tree xs))

(define t (insert-all (list 8 6 7 5 3 0 9)))

(define out (open-output-file "binary_int_tree.dot" #:exists 'replace))
(display (to-dot t) out)
(close-output-port out)