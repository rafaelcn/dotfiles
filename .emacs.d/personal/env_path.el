;; File: env_path.el

;; Inits exec-path-from-shell-initialize and if it is installed, if not it
;; installs it automatically.

(if (package-installed-p 'exec-path-from-shell)
    (exec-path-from-shell-initialize)
  (package-install 'exec-path-from-shell))

;; env_path.el ends here
