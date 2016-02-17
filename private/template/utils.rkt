#lang racket

(provide (all-defined-out))
(require scribble/core
         racket/draw
         (only-in pict bitmap))

(define (exact . items)
  (make-element (make-style "identity" '(exact-chars))
                items))

(define (m . items)
  (make-element (make-style "identity" '(exact-chars))
                `("$" ,@items "$")))

(define (mm . items)
  (make-element (make-style "identity" '(exact-chars))
                `("\\[" ,@items "\\]")))

(define at-char "@")

(define dot (find-executable-path "dot"))

(define (dot->pict . graph)
  (define-values (in out) (make-pipe))
  (with-input-from-string (apply string-append graph)
    (λ () (parameterize ([current-output-port out])
            (system* dot "-Tpng"))))
  (define b (make-object bitmap% 1 1))
  (send b load-file in)
  (bitmap b))