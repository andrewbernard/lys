;; Path utilities
;;
;; acb

(define-module (local path))
(export
 realpath)

;; not in POSIX

(define realpath
  (lambda(filename)
    (let* ((dir (dirname filename))
	   (base (basename filename))
	   (original-dir (getcwd)))
      (chdir dir)
      (let* ((full-dir (getcwd)))
	(chdir original-dir)
	(format #f "~a/~a" full-dir base)
	))))


















