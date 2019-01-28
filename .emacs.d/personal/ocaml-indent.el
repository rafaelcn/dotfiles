;; File: ocaml-indent.el
;;

(setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
(load-file (concat opam-share "/emacs/site-lisp/ocp-indent.el"))
