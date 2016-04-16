% Lilypond compile server
%
% Note that this is lilypond code, not Scheme. But it is composed entirely of
% guile procedures.

\version "2.19.39"

#(begin
   ;; TCP server side of lilypond compiler server

   (use-modules (ice-9 format))
   (use-modules (ice-9 rdelim))
   (use-modules (local timing))

   (define port 12000)

   (define (main args)
     ;; tcp server
     (let ((sock-server (socket PF_INET SOCK_STREAM 0)))
       (setsockopt sock-server SOL_SOCKET SO_REUSEADDR 1)
       (bind sock-server AF_INET INADDR_ANY port)
       (listen sock-server 5)
       (format #t "lilypond compile server listening on port ~a\n" port)

       (while #t
	      (let* ((connection (accept' sock-server))
		     (sock-client (car connection))
		     (client-details (cdr connection)))

		(format #t "client connection from host: ~a\n"
			(hostent:name
			 (gethostbyaddr (sockaddr:addr client-details))))
		(fork-process-twice sock-client)
		))))

   ;; accept that handles EINTR
   (define accept'
     (lambda (sock)
       (let loop ()
	 (catch 'system-error
		(lambda () (accept sock))
		(lambda (key . parameters)
		  (begin
		    ;;(format #t "key ~a parameters ~a\n" key parameters)
		    ;; EINTR is normal and expected here
		    (loop) ;; try again after EINTR
		    ))))))

   ;; fork child. double fork to decouple fully.
   (define fork-process-twice
     (lambda (sock)
       (let* ((pid (primitive-fork)))
	 (if (zero? pid)
	     (begin
	       (let* ((pid (primitive-fork)))
		 (if (zero? pid) (child-process sock)) ;; run in grandchild
		 (primitive-exit) ;; child exit
		 ))
	     (waitpid pid)))))
   
   ;; child process to do the work
   (define child-process
     (lambda (sock)
       ;; read from the client
       ;; get file name and command line options.
       ;; set up options and get lilypond to compile the file.
       ;; ...
       (let ((filename (read-line sock 'trim))
	     (start-time (start-timer)))
	 (format #t "file: ~a\n" filename)
	 ;; lilypond outputs messages on stderr. send them to the client.
	 (redirect-port sock (current-error-port))
	 
	 (catch #t
		(lambda ()
		  (begin
		    (ly:set-option 'verbose #t)
		    ;; do the main work - compile the source file.
		    (ly:parse-file filename)
		    ))
		(lambda (key . parameters)
		  (begin
		    (format #t "caught lilypond processing error: ~a: ~a\n" key parameters)
		    (shutdown sock 1)
		    (primitive-exit 1)
		    )))
	 
	 ;; send response to client
	 (let* ((time-taken (elapsed-time start-time (stop-timer))))
	   (format sock "Compile completed in ~a\n" (format-elapsed-time time-taken)))

	 ;; exit
	 (shutdown sock 2)
	 (close-port sock)
	 (primitive-exit 0)
	 
	 )
       ))

   ;; perform wait for child process
   (define sigchld-handler
     (lambda (arg)
       (let ((return (waitpid 0)))
	 (format #t "waitpid: ~a\n" return)
	 )
       ))


   ;; testing junk

   ;; cat file
   (define cat-file
     (lambda (file port)
       (let* ((file-port (open-file file "r")))
	 (let loop ((line (read-line file-port)))
	   (if (not (eof-object? line))
	       (begin
		 (write-line line port)
		 (loop (read-line file-port)))
	       ))
	 (close-port file-port)
	 ))))

% run server
#(
  (catch #t
	 (lambda ()
	   (main port))
	 (lambda (key . parameters)
	   (begin
	     (format #t "caught error: ~a\n~a\n" key parameters)
	     (primitive-exit 1)
	     ))))

;; Local Variables:
;; mode: Scheme
;; End:
