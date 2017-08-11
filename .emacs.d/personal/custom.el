;; To view the column index
(column-number-mode 1)
;; To view line numbers
(global-linum-mode 1)
;; Setting the default font
(set-frame-font "Ubuntu Mono 11" nil t)
;; Org support for shift select
(setq org-support-shift-select 1)
;; Wakatime mode
(if (package-installed-p 'wakatime-mode)
    ;;(when-system linux
    (setq wakatime-api-key "<your-api-key>"))

(if (package-installed-p 'wakatime-mode)
    (global-wakatime-mode 1))

;; Setting default style for c/c++ programming languages
(setq c-default-style "stroustrup")
(setq c++-default-style "stroustrup")

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; to avoid scale problems
(with-eval-after-load 'linum
  (set-face-attribute 'linum nil :height 100))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((flycheck-disabled-checkers emacs-lisp-checkdoc)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
