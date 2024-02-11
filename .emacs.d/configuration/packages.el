;;
;; Packages related configuration
;;

;; DAP mode

(use-package dap-mode
  :ensure
  :after
  lsp-mode
  :config
  (dap-auto-configure-mode))

(use-package dap-java
  :ensure nil)

;; Wakatime

(use-package wakatime-mode
  :ensure
  :config
  (global-wakatime-mode))

;; Company

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.10)
  :config
  (global-company-mode)
  :bind
  (:map company-active-map
		("C-n". company-select-next)
		("C-p". company-select-previous)
		("C-F". company-select-first)
		("C-L". company-select-last)))

;; Helm

(use-package helm
  :ensure
  :config
  (helm-mode)
  :bind
  (:map helm-map
		("<tab>". helm-execute-persistent-action)))

(add-to-list 'load-path "~/Documents/Github/helm")

(require 'helm-autoloads) ;; check this (unavailable from MELPA (maybe within the source itself)

;; LSP

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  (lsp-enable-snippet nil)
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.20)
  :config
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
