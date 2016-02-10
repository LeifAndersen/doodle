#lang racket/base

(require racket/cmdline
         scribble/render
         scribble/pdf-render
         raco/command-name
         racket/runtime-path
         racket/file)

(define (scribble->tex input-file style-file)
  (define doc (dynamic-require input-file 'doc))
  (render (list doc)
          (list input-file)
          #:render-mixin render-mixin
          #:style-extra-files (list style-file)))

(define-runtime-path base-project-path "./private/template")
(define input-file (make-parameter "paper.scrbl"))
(define style-file (make-parameter "texstyle.tex"))
(define new-project (make-parameter #f))

(module+ main
  (define args
    (command-line
     #:program (short-program+command-name)
     #:once-any
     [("-s" "--style") s
      "Set the style file"
      (style-file s)]
     [("-n" "--new") name
      "Create a new project"
      (new-project name)]
     #:args ([input-file "paper.scrbl"])
     input-file))

  (input-file args)

  (cond [(new-project)
         (unless (directory-exists? (new-project))
           (make-directory (new-project)))
         (copy-file (build-path base-project-path "paper.scrbl") (build-path (new-project) "paper.scrbl"))
         (copy-file (build-path base-project-path "texstyle.tex") (build-path (new-project) "texstyle.tex"))
         (copy-file (build-path base-project-path "utils.rkt") (build-path (new-project) "utils.rkt"))]
        [else
         (scribble->tex (input-file) (style-file))]))
