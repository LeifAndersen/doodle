#lang info
(define collection "doodle")
(define deps '("base"
               "rackunit-lib"
               "scribble-lib"
               "pict-lib"
               "draw-lib"))
(define build-deps '("scribble-lib" "racket-doc"))
(define scribblings '(("scribblings/doodle.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(leif))
(define raco-commands '(("doodle" (submod doodle main) "run Doodle" #f)))
