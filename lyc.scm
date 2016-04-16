#!/usr/bin/guile1 \
-e main -s
!#

;; TCP client for lilypond compile server

(use-modules (ice-9 format))
(use-modules (ice-9 rdelim))

(define port 12000)

(define (main args)

  ;; get info
  ;;(format #t "pid = ~a\n" (getpid))
  ;;(format #t "ppid = ~a\n" (getppid))
  ;;(format #t "pgrp = ~a\n" (getpgrp))

  ;; tcp client
  (let ((sock (socket PF_INET SOCK_STREAM 0)))
    (connect sock AF_INET (inet-aton "127.0.0.1") port)

    ;; write
    ;; send command line args to server
    (write-line (cadr args) sock)
    ;; indicate done writing without closing socket.
    ;; a simple protocol. single blank line indicates end of write.

    ;; read
    ;; get server response
    (let loop ((line (read-line sock)))
      (if (not (eof-object? line))
	  (begin
	    (format #t "~a\n" line)
	  (loop (read-line sock)))))

    ;; finish
    (shutdown sock 2)
    (close-port sock)))
