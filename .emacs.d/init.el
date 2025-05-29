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
 '(custom-safe-themes
   '("0407bc59241a431e71d639f8fe8049f2490428a4c073b657edf5f5f915ae2aa0"
	 "f1c8202c772d1de83eda4765fe21429a528a4fb350a28394d3705fe9678ed1f9"
	 "ad7d874d137291e09fe2963babc33d381d087fa14928cb9d34350b67b6556b6d"
	 default))
 '(package-selected-packages
   '(act-mode company dockerfile-mode erlang exec-path-from-shell
			  exotica-theme flymake-json go-mode jsonian leuven
			  lsp-java lsp-metals lsp-ui magit merlin org-roam
			  org-roam-ui projectile rustic sbt-mode smooth-scrolling
			  tuareg vertico wakatime-mode web-mode yaml-mode))
 '(warning-suppress-types '((comp) (comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load user defined stuff (me me me) (it is ordered for a reason!!!)


(setq debug-on-error t)
(setq server-log t)
(setq server-verbose t)

(load-file "~/.emacs.d/configuration/system.el")
(load-file "~/.emacs.d/configuration/packages.el")
(load-file "~/.emacs.d/configuration/defaults.el")
(load-file "~/.emacs.d/configuration/theme.el")
(load-file "~/.emacs.d/configuration/keybindings.el")
(load-file "~/.emacs.d/configuration/languages.el")

