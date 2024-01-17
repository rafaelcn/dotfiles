;;
;; Utilities (configuration of emacs itself, excluding keybindings and possibly other stuff)
;;

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-message t
      initial-scratch-message "Type me..."
      cursor-type 'bar)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t   ; don't delink hard links
      version-control t     ; use version numbers on backups
      delete-old-versions t ; automatically delete excess backups
      kept-old-versions 5
      kept-new-versions 20)

(setq-default tab-width 4
			  auto-save-default t)

(setq default-frame-alist '((font . "Noto Sans Mono 10")))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'flycheck-mode)

;; Smoooooooth

(use-package smooth-scrolling
  :ensure
  :config
  (progn
	(smooth-scrolling-mode 1)
	(setq smooth-scroll-margin 2)))

