;; -*- lexical-binding: t; -*-
;;
;; packages.el
;;
;; General packages that are not exactly language support, those are inside the
;; languages.el file.
;;


;; Magit
;;
;; The belle of the ball

(use-package magit
  :ensure)


;; DAP mode
;;
;; define keybindings for the following functions:
;;  - dap-step-in
;;  - dap-step-out
;;  - dap-breakpoint-add
;;  - dap-breakpoint-delete

(use-package dap-mode
  :ensure
  :after lsp-mode
  :functions dap-hydra/nil
  :config
  (dap-auto-configure-mode)
  (require 'dap-java)
  (require 'dap-dlv-go)
  :bind (:map lsp-mode-map
			  ("<f5>" . dap-debug)
			  ("M-<f5>" . dap-hydra)
			  ("M-<f6>" . dap-breakpoint-toggle))
  :hook ((dap-mode . dap-ui-mode)
		 (dap-session-created . (lambda (&_rest) (dap-hydra)))
		 (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))))

;; Wakatime

(use-package wakatime-mode
  :ensure)

(if (not (eq system-type 'darwin))
	(global-wakatime-mode))

;; Company

(use-package company
  :ensure
  :custom (company-idle-delay 0.2)
  :config
  (add-hook 'eglot-managed-mode-hook 'company-mode)
  (global-company-mode)
  :bind (:map company-active-map
			  ("C-n". company-select-next)
			  ("C-p". company-select-previous)
			  ("C-F". company-select-first)
			  ("C-L". company-select-last)))

;; Helm

;; (use-package helm
;;   :ensure
;;   :config (helm-mode)
;;   :bind (:map helm-map
;; 			  ("<tab>". helm-execute-persistent-action)))

;;(require 'helm-autoloads) ;; check this (unavailable from MELPA (maybe within the source itself)

;; Vertico

(use-package vertico
  :ensure
  :config (vertico-mode))

;; LSP

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  (lsp-enable-snippet nil)
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.20)
  :config
  (setq lsp-keep-workspace-alive nil)
  
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show nil)
  (lsp-ui-sideline-show-hover nil)

  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-use-plists t)
  (setq lsp-idle-delay 0.10)
  
  (lsp-ui-doc-enable nil))

;; Flycheck

(use-package flycheck
  :ensure
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; Flymake JSON

(use-package flymake-json
  :ensure)

;; JSON

(use-package jsonian
  :ensure)

;; Projectile

(use-package projectile
  :ensure
  :init (projectile-mode)
  :bind (:map projectile-mode-map
			  ("C-c p" . projectile-command-map))
  :config
  (setq projectile-project-root-files '("go.mod")))


;; ORG Roam

(use-package org-roam
  :ensure
  :config
  (setq org-roam-directory (file-truename "~/.emacs.d/org")))
