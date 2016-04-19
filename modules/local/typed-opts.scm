;; Typed command line options data structure procedures
;;
;; The typed option alist data structure supports keys with values which are
;; comprised of the value for the option and the named type for the
;; option. Each item also has a state flag, initially #f, indicating if the
;; option has been set or not. If the option has been set, the flag should be
;; set to the value #t.
;;
;; Example:
;;
;; (define opts '((includes () std #f)
;; 	       (dbackend "pdf" minus-d #f)
;; 	       (loglevel 0 std #f)))
;;
;; Author
;; acb
;;
;; Notes
;; This could also be done with records. This code is nearly that
;; anyway. Anyway, this is easy to extend to larger numbers of fields, and
;; simple enough.

(define-module (local typed-opts))
(export
 get-typed-option-field
 set-typed-option-field!
 get-typed-options-by-field
 opt-val
 opt-type
 opt-state
 )
 
;; alist values names (list indexes)
(define opt-val 1)
(define opt-type 2)
(define opt-state 3)

;; Get the value of a field of the values for the key.
;; Pass the field that is wanted of the value for the given key.
;; Returns field value, or #f if no such key.
(define get-typed-option-field
  (lambda (alist key field)
    (let ((val (assq key alist)))
      (if (not val)
	  #f ;; no such key
	  (list-ref val field)))))

;; Set the value of a field of the option.
;; Returns the updated alist.
(define set-typed-option-field!
  (lambda (alist key field value)
    (let* ((val (assq key alist)))
      (if (not val)
	  ;; throw, i think is best. this will be rare in normal context.
	  (throw 'no-such-key key)
	  (list-set! val field value))
      alist)))

;; Return all elements of typed options alist for the specified value of the
;; option value field.
;; Returns a new alist.
(define get-typed-options-by-field
  (lambda (alist field val)
    (let* ((alist-new '()))
      (for-each (lambda (elem)
		    (if (eq? (list-ref elem field) val)
			  (set! alist-new (append `(,elem) alist-new))))
		alist)
      alist-new)))
