;;
;; Packages related configuration
;;

;; DAP mode

(use-package dap-mode
  :ensure
  :after lsp-mode
  :functions dap-hydra/nil
  :config
  (dap-auto-configure-mode)
  (require 'dap-java)
  :bind (:map lsp-mode-map
			  ("<f5>" . dap-debug)
			  ("M-<f5>" . dap-hydra))
  :hook ((dap-mode . dap-ui-mode)
		 (dap-session-created . (lambda (&_rest) (dap-hydra)))
		 (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))))
  

(use-package dap-java
  :ensure nil)

;; Wakatime

(use-package wakatime-mode
  :ensure
  :config (global-wakatime-mode))

;; Company

(use-package company
  :ensure
  :custom (company-idle-delay 0.10)
  :config (global-company-mode)
  :bind (:map company-active-map
			  ("C-n". company-select-next)
			  ("C-p". company-select-previous)
			  ("C-F". company-select-first)
			  ("C-L". company-select-last)))

;; Helm

(use-package helm
  :ensure
  :config (helm-mode)
  :bind (:map helm-map
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

;; Orderless

(use-package orderless
  :ensure
  :custom
  (completion--styles '(orderless basic))
  (completion--category-override '((file (styles basic partial-completion)))))
