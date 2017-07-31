(defvar gud-gud-gdb-history nil)

(defun setup-c-and-cpp-compiler-with-gdb ()
  (interactive)
  "Generate strings for 'compile and 'gud-gdb commands on C/C++ mode"
  (define-key (current-local-map) (kbd "C-x c") 'compile)
  (define-key (current-local-map) (kbd "<M-f9>") 'gud-gdb)
  (when buffer-file-name
    (let* ((file (file-name-nondirectory buffer-file-name))
	   (file-basename (file-name-sans-extension file))
	   (extension (if (eq system-type 'windows-nt) "exe" "out")))
      (unless (or (file-exists-p "Makefile") (file-exists-p "makefile"))
        (set (make-local-variable 'compile-command)
	     ;; emulate make's .c.o implicit pattern rule, but with
	     ;; different defaults for the CC, CPPFLAGS, and CFLAGS
	     ;; variables:
	     ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
	     (format "%s -o %s.%s %s %s %s"
		     (or (getenv "CC") (if c-buffer-is-cc-mode
					   "g++ -std=c++11"
					 "gcc"))
		     file-basename extension
		     (or (getenv "CPPFLAGS") "-DDEBUG=9")
		     (or (getenv "CFLAGS") "-pedantic -Wall -g")
		     file))
        (push (format "gdb --fullname %s.%s" file-basename extension)
	      gud-gud-gdb-history)
        (set (make-local-variable 'gud-gdb-command-name)
	     (format "gdb -i=mi %s.%s" file-basename extension))))))

;; add commands for build and debug to C++ and C
(add-hook 'c-mode-common-hook 'setup-c-and-cpp-compiler-with-gdb)
