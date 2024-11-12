;; -*- lexical-binding: t; -*-
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

(use-package eglot
  :ensure nil
  :preface
  (defun config-c++-style()
	""
	(c-set-tyle 'stroustrup))
  :config
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook #'config-c++-style))


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
;; make sure to install ocaml-lsp-server ocamlformat (opam install ...)
;; 

(use-package merlin
  :ensure)

(use-package tuareg
  :ensure
  :config
  (add-hook 'tuareg-mode-hook #'lsp-deferred))

(let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
	;; merlin
	(add-to-list 'load-path (expand-file-name "emacs/site-list" opam-share))
	(autoload 'merlin-mode "merlin" nil t nil)
	;; start merlin in ocaml buffers
	(add-hook 'tuareg-mode-hook 'merlin-mode t)
	;; use opam switch to lookup ocamlmerlin binary
	(setq merlin-command 'opam)))
  

;; Elang

(use-package erlang
  :ensure)

;; Treesitter

(use-package treesit
  :ensure nil
  :preface
  (defun treesit-install-language-grammars()
	(interactive)
	(dolist (grammars
			 '((c          "https://github.com/tree-sitter/tree-sitter-c/" "master" "src")
			   (cpp        "https://github.com/tree-sitter/tree-sitter-cpp/" "v0.23.4" "src")
			   (glsl       "https://github.com/tree-sitter-grammars/tree-sitter-glsl")
			   (go         "https://github.com/tree-sitter/tree-sitter-go")
               (gomod      "https://github.com/camdencheek/tree-sitter-go-mod")
			   (make       "https://github.com/tree-sitter-grammars/tree-sitter-make")
			   (ocaml      "https://github.com/tree-sitter/tree-sitter-ocaml" "v0.23.2" "src")
			   (erlang     "https://github.com/WhatsApp/tree-sitter-erlang" "main" "src")))
	  (add-to-list 'treesit-language-source-alist grammars)
	  (unless (treesit-language-available-p (car grammars))
		(treesit-install-language-grammar (car grammars)))))
  :config
  (dolist (mapping '((c-mode   . c-ts-mode)
					 (c++-mode . c++-ts-mode)
					 (glsl     . glsl-ts-mode)))
	(add-to-list 'major-mode-remap-alist mapping))
  (setq treesit-font-lock-level 4))
