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
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-eldoc-hook t)
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-signature-auto-activate t)
  (setq lsp-inlay-hint-enable t)
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
  (setq lsp-inlay-hint-enable t)
  (setq lsp-eldoc-hook nil)
  
  (progn
	(setq gofmt-command "goimports")                ; goimports imports missing deps and formats your code
	(add-hook 'before-save-hook 'gofmt-before-save) ; it uses the gofmt-before-save command from gomode
	(add-hook 'go-mode-hook #'lsp-deferred)))



