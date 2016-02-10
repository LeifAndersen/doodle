#lang racket

(provide (all-defined-out))

(define (exact . items)
  (make-element (make-style "identity" '(exact-chars))
                items))

(define (m . items)
  (make-element (make-style "identity" '(exact-chars))
                `("$" ,@items "$")))

(define (mm . items)
  (make-element (make-style "identify" '(exact-chars))
                `("\\[" ,@items "\\]")))

(define at-char "@")
