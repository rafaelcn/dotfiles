(when (eq system-type 'darwin)
  (setq server-use-tcp nil)
  (use-package exec-path-from-shell
	:init
	(exec-path-from-shell-initialize)
	(exec-path-from-shell-copy-envs '("LIBRARY_PATH" "INFOPATH" "CPATH" "MANPATH"))))
