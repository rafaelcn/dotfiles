;; -*- lexical-binding: t; -*-
;;
;; theme.el
;; 
;; Configuration of the used themes. The behaviour of a theme might be
;; controlled by what's defined in the keybindings.el file.
;;

(use-package exotica-theme
  :defer t
  :config (load-theme 'exotica t t))

(use-package ample-theme
  :ensure
  :defer t
  :init (progn (load-theme 'ample t t)
			   (load-theme 'ample-flat t t)
			   (load-theme 'ample-light t t)
			   (enable-theme 'ample-flat)))
