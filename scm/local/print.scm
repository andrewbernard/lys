;; Print procedure similar to R7RS
;;
;; acb

(define-module (local print))
(export prnt)

;; Namde prnt to avoid clash with lilypond print function
(define (prnt . args)
  "Simple print."
  (cond
   ((not (null? args))
    (display (car args))
    (display " ")
    (apply prnt (cdr args)))
   (else (newline))))

