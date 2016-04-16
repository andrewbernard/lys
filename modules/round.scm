;; Rounding and numerical procedures

(define-module (local round))
(export
 round-to-n-places
 int-part
 frac-part
 )

;; Round a number x to n decimal places.
;;
;; Avoid floating point errors by scaling.
;; Scale up. Fix rounding, Scale down.
;;
;; Note that (round 2.1234 0) will return 2.0 not 2.
(define round-to-n-places
  (lambda (x n)
    (let ((scale (expt 10 n)))
      (/ (truncate (+ (* x scale) 0.5)) scale))))

;; Integer part of a number.
(define int-part
  (lambda (x)
    (inexact->exact (truncate x))))

;; Fractional part of a number.
;; note that there are different ways of defining this for negative numbers.
(define frac-part
  (lambda (x)
    (- x (floor x))))
