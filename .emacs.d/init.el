;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm-autoloads helm smooth-scrolling company-racer rust-mode company zweilight-theme twilight-anti-bright-theme twilight-bright-theme twilight-theme vegetative-theme magit popup wakatime-mode flyaacheck-ocaml flycheck-rust flymake-go flymake-go-staticcheck lsp-mode lsp-ui lua-mode go-mode exotica-theme use-package))
 '(warning-suppress-types '((comp) (comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load user defined stuff (me me me) (it is ordered for a reason!!!)

(load-file "~/.emacs.d/configuration/packages.el")
(load-file "~/.emacs.d/configuration/utilities.el")
(load-file "~/.emacs.d/configuration/theme.el")
(load-file "~/.emacs.d/configuration/keybindings.el")
(load-file "~/.emacs.d/configuration/languages.el")

