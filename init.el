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
(setq wakatime-api-key "{your_api_key}")
(setq wakatime-python-bin "{your_python_bin}")

(global-wakatime-mode 1)

;; Better keys for split/delete windows
(global-set-key (kbd "M-3") 'delete-other-windows)
(global-set-key (kbd "M-4") 'split-window-below)
(global-set-key (kbd "M-$") 'split-window-right)
(global-set-key (kbd "M-RET") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)

(custom-set-variables
 '(custom-enabled-themes (quote (tsdh-dark))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
