;;
;; Packages related configuration
;;

(require 'smooth-scrolling)
(require 'helm)
(require 'helm-autoloads)
(require 'lsp-mode)
(require 'flycheck)
(require 'dap-mode)
(require 'wakatime-mode)

(global-wakatime-mode)

(add-to-list 'load-path "~/Documents/Github/helm")

(smooth-scrolling-mode 1)
(setq
 smooth-scroll-margin 2)

;; Company

(use-package company
  :ensure t
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

(helm-mode 1)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

;; Flycheck

(use-package flycheck
  :ensure t)
