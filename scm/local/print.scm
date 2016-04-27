;; Print procedure similar to R7RS
;;
;; acb

(define-module (local print))
(export print)

(define (print . args)
  "Simple print."
  (cond
   ((not (null? args))
    (display (car args))
    (display " ")
    (apply print (cdr args)))
   (else (newline))
   ))
