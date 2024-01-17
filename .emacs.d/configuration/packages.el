;;
;; Packages related configuration
;;

;; DAP mode

(use-package dap-mode
  :ensure)

;; Wakatime

(use-package wakatime-mode
  :ensure
  :config
  (progn
	(add-hook 'after-initial-hook 'global-wakatime-mode)))

;; Company

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.10)
  :config
  (progn
    (add-hook 'after-initial-hook 'global-company-mode))
  :bind
  (:map company-active-map
		("C-n". company-select-next)
		("C-p". company-select-previous)
		("M-<". company-select-first)
		("M->". company-select-last)))

;; Helm

(use-package helm
  :ensure
  :config
  (progn
	(add-hook 'after-initial-hook 'helm-mode)))

(require 'helm-autoloads) ;; check this (unavailable from MELPA (maybe within the source itself)

(add-to-list 'load-path "~/Documents/Github/helm")

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

;; LSP

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  (lsp-eldoc-render-all nil)
  (lsp-idle-delay 0.30)
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
  :ensure)
