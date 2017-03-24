;;
;; Author: Rafael Campos Nunes
;; Email: <rafaelnunes at engineer dot com>

;; Add MELPA repository
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Disabling tool-bar-mode
(tool-bar-mode 0)
;; To view the column index
(column-number-mode 1)
;; To view line numbers
(global-linum-mode 1)

;; Wakatime configuration
(setq wakatime-api-key "<your-api-key>")
(setq wakatime-python-bin "/usr/bin/python3")

(global-wakatime-mode 1)

;; Better keys for split/delete windows
(global-set-key (kbd "M-3") 'delete-other-windows)
(global-set-key (kbd "M-4") 'split-window-below)
(global-set-key (kbd "M-$") 'split-window-right)
(global-set-key (kbd "M-RET") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)

;; irony configuration
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; company-irony mode
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay              nil
  company-minimum-prefix-length   2
  company-show-numbers            t
  company-tooltip-limit           20
  company-dabbrev-downcase        nil
  company-backends                '((company-irony company-gtags)))

;; company autocomplete trigger
(global-set-key (kbd "C-;") 'company-complete-common)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(lisp-indent-offset 2)
 '(wakatime-cli-path "/usr/local/bin/wakatime"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
