;; Timing procedures.
;; For guile interpreter timing.

(define-module (local timing))
(export
 start-timer
 stop-timer
 elapsed-time
 format-elapsed-time
 )

(use-modules (ice-9 format))
(use-modules (local round))

;; Start timer.
;; to make code independent of timing method
(define start-timer
  (lambda ()
    (get-internal-real-time)))

;; Stop timer.
;; to make code independent of timing method
(define stop-timer
  (lambda ()
    (get-internal-real-time)))

;; Time difference in seconds.
(define elapsed-time
  (lambda (t1 t2)
    "docstring info here"
    (exact->inexact (/ (- t2 t1) internal-time-units-per-second))))

;; Show time interval as minutes and seconds.
;; OK, does not do hours yet.
(define format-elapsed-time
  (lambda (t)
    (cond
     ((> t 60)
      (let* ((mins (int-part (/ t 60.0)))
	     (secs (- t mins)))
	(format #f "~a' ~,2f\"" mins secs)))
     (else (format #f "~,2f\"" t)))))
