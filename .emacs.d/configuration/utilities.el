;;
;; Utilities (configuration of emacs itself, excluding keybindings and possibly other stuff)
;;

;; user interface improvements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-message t
      initial-scratch-message "Type me..."
      cursor-type 'bar
      tab-width 4)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t   ; don't delink hard links
      version-control t     ; use version numbers on backups
      delete-old-versions t ; automatically delete excess backups
      kept-old-versions 5
      kept-new-versions 20)


(set-frame-font "Noto Sans Mono 10" nil t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

