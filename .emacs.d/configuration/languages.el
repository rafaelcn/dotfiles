;;
;; Language related settings (hooks, definitions etc)
;;

;; Rust

(add-hook 'rust-mode-hook 'eglot-ensure)

(use-package rustic
  :ensure
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
  ;; uncomment for less flashiness
  (setq lsp-eldoc-hook nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

;; Go

(global-set-key (kbd "C-.")
				'godef-jump)

(global-set-key (kbd "C-,")
				'godef-jump-other-window)

(progn
  (setq gofmt-command "goimports")                ; goimports imports missing deps and formats your code
  (add-hook 'before-save-hook 'gofmt-before-save) ; it uses the gofmt-before-save command from gomode
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'go-mode-hook 'display-line-numbers-mode))
