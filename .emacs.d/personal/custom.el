;; File custom.el
;; Sets a lot of configurations that I commonly use on my emacs

;; To view the column index
(column-number-mode 1)
;; To view line numbers
(global-linum-mode 1)
;; Setting the default font
(set-frame-font "Go Mono 11" nil t)
;; Set tab width to four
(setq-default tab-width 4)
;; Org support for shift select
(setq-default org-support-shift-select 1)
;; Wakatime mode
(if (package-installed-p 'wakatime-mode)
    (progn
      (setq-default wakatime-api-key "<your api key here>")
      (global-wakatime-mode))
  (package-install 'wakatime-mode))

;; Setting default style for c/c++ programming languages
(setq-default c-default-style "stroustrup")
(setq-default c++-default-style "stroustrup")

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; to avoid scale problems
(with-eval-after-load 'linum
  (set-face-attribute 'linum nil :height 100))

;; company-irony configuration
(if (package-installed-p 'company)
    (progn
      (eval-after-load 'company
        '(add-to-list 'company-backends 'company-irony))

      (add-hook 'c++-mode-hook 'irony-mode)
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'objc-mode-hook 'irony-mode)

      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
  (package-install 'company))

;; toc-org stuff
(if (package-installed-p 'toc-org)
    (if (require 'toc-org nil t)
        (add-hook 'org-mode-hook 'toc-org-enable)
      (warn "toc-org not found"))
  (package-install 'toc-org))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode erlang slime dart-mode lua-mode meson-mode flycheck-pyflakes org-make-toc markdown-mode org-toodledo cmake-mode exec-path-from-shell flycheck-ocaml merlin utop tuareg haskell-mode gotest go-projectile go-eldoc company-go go-mode geiser company-anaconda anaconda-mode rainbow-mode elisp-slime-nav rainbow-delimiters company helm-ag helm-descbinds helm-projectile helm smex ido-completing-read+ flx-ido zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens operate-on-number move-text magit projectile imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; custom.el ends here
