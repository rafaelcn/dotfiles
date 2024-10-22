;;
;; Language related settings (hooks, definitions etc)
;;

;; Rust

(use-package rustic
  :ensure
  :init
  (setq rustic-lsp-client 'lsp-mode)
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (setopt lsp-rust-analyzer-cargo-watch-command "clippy")
  (setopt lsp-eldoc-hook t)
  (setopt lsp-enable-symbol-highlighting t)
  (setopt lsp-signature-auto-activate t)
  (setopt lsp-inlay-hint-enable t)
  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)

  ;; issues with magit and non saved files
  (add-hook 'rustic-mode-hook 'rustic-save-hook))

(defun rustic-save-hook ()
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))


;; Go

(use-package go-mode
  :ensure
  :config
  (setopt lsp-inlay-hint-enable t)
  (setopt lsp-eldoc-hook nil)
  (setopt gofmt-command "goimports") ; goimports imports missing deps and formats your code
  
  (add-hook 'before-save-hook 'gofmt-before-save) ; it uses the gofmt-before-save command from gomode
  (add-hook 'go-mode-hook #'lsp-deferred))


;; Java

(use-package lsp-java
  :ensure
  :config
  (add-hook 'java-mode-hook #'lsp)
  (add-hook 'java-mode-hook #'lsp-lens-mode)
  (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode))


;; C/C++
;; make sure irony-server is correctly set up after installation (compile it)

(use-package irony
  :ensure
  :config
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
  

;; Scala

(use-package scala-mode
  :ensure
  :interpreter ("scala" . scala-mode)
  :config
  (add-hook 'scala-mode-hook #'lsp)
  (add-hook 'scala-mode-hook #'lsp-lens-mode))

(use-package sbt-mode
  :ensure
  :commands sbt-start sbt-command
  :config
  ;; setting to allow spacing in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-metals
  :ensure)

;; OCaml
;; make sure to install ocaml-lsp-server ocamlformat

(use-package merlin
  :ensure)

(use-package tuareg
  :ensure
  :hook
  (tuareg-mode . lsp)
  :config
  (let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share")))))
	(when (and opam-share (file-directory-p opam-share))
	  ;; merlin
	  (add-to-list 'load-path (expand-file-name "emacs/site-list" opam-share))
	  (autoload 'merlin-mode "merlin" nil t nil)
	  ;; start merlin in ocaml buffers
	  (add-hook 'tuareg-mode-hook 'merlin-mode t)
	  ;; use opam switch to lookup ocamlmerlin binary
	  (setq merlin-command 'opam))))
  
