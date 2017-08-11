;;; mmf.el --- Macros and useful functions I use.

;; Author: Rafael Campos Nunes
;; Date: 03/07/2017

;;; Code:

(defmacro try-quote (symbol)
  "Quote the SYMBOL if is not quoted.
SYMBOL is any datum."
  (or (and (consp symbol)
           (eq (car symbol) 'quote)
           symbol)
      `(quote ,symbol)))

(defmacro when-system (system &rest body)
  "Only eval BODY when SYSTEM is the name/alias of the running system.
SYSTEM can be a unquoted symbol designing a `system-type'
or one of its alias: linux, windows and mac-os.
BODY is the rest of eval forms to be executed when SYSTEM is equal
to `system-type'."
  (let ((system-alist (make-symbol "system-key-alist"))
        (system-symbol (make-symbol "system-symbol"))
        (quoted-system (make-symbol "quoted-system")))
    `(let* ((,system-alist '((linux gnu/linux)
                             (mac-os darwin)
                             (windows windowws-nt)))
            (,quoted-system (try-completion-quote ,system))
            (,system-symbol (or (second (assoc ,quoted-system ,system-alist))
                                ,quoted-system)))
       (when (eq system-type ,system-symbol)
         ,@body))))



