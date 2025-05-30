;; -*- lexical-binding: t; -*-
;;
;; system.el
;;
;; This file contains configuration regarding a specific system.

(when (eq system-type 'darwin)
  (use-package exec-path-from-shell
	:init
	(exec-path-from-shell-initialize)
	(exec-path-from-shell-copy-envs '("LIBRARY_PATH" "INFOPATH" "CPATH" "MANPATH" "GOPATH"))))
