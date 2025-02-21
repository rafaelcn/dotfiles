;; -*- lexical-binding: t; -*-
;;
;; Utilities (configuration of emacs itself, excluding keybindings and possibly other stuff)
;;

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(eldoc-mode -1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setopt ring-bell-function 'ignore)

(setopt inhibit-startup-message t
	initial-scratch-message ";; Type me..."
	cursor-type 'box
	tab-width 4
	auto-save-default t
	auto-save-timeout 20
	auto-save-interval 200
	auto-save-visited-mode t)

(when (not (eq system-type 'darwin))
  default-frame-alist '((font . "Iosevka Fixed 10")))

(setopt backup-directory-alist '(("." . "~/.emacs.d/backup"))
	backup-by-copying t   ; don't delink hard links
	version-control t     ; use version numbers on backups
	delete-old-versions t ; automatically delete excess backups
	kept-old-versions 5
	kept-new-versions 20)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'prog-mode-hook 'eldoc-mode)

;; Smoooooooth

(use-package smooth-scrolling
  :ensure
  :config
  (smooth-scrolling-mode)
  (setq-default smooth-scroll-margin 3))

;; Org

(use-package org
  :ensure
  :config
  (setq-default org-support-shift-select t))

;; Java settings
;; Environment variables need to have an absolute path for some reason...

(when (eq system-type 'linux) 
  (setenv "JAVA_HOME" "/home/ranu/.jdks/graalvm-ce-22/")
  (setopt lsp-java-java-path "/home/ranu/.jdks/graalvm-ce-22/bin/java"
		  lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/1.36.0/jdt-language-server-1.36.0-202405301306.tar.gz"))
