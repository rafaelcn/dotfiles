;;
;; Package related configuration
;;

(global-wakatime-mode)

(add-to-list 'load-path "~/Documents/Github/helm")

(require 'smooth-scrolling)
(require 'helm)
(require 'helm-autoloads)
(require 'lsp-mode)

(smooth-scrolling-mode 1)
(setq
 smooth-scroll-margin 2)

(helm-mode 1)

(use-package company
  :ensure t
  :config
  (progn
    (add-hook 'after-initial-hook 'global-company-mode)))

(progn
  (setq gofmt-command "goimports")                ; goimports imports missing deps and formats your code
  (add-hook 'before-save-hook 'gofmt-before-save) ; it uses the gofmt-before-save command from gomode
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'go-mode-hook 'display-line-numbers-mode))






