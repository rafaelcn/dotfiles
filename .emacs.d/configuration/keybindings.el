;;
;; Personal keymap
;;
;; This is general stuff, there might be other keybindings defined in other files,
;; particularly the languages.el file.
;;

(global-set-key (kbd "M-<right>") 'split-window-horizontally)
(global-set-key (kbd "M-<down>") 'split-window-vertically)

(global-set-key (kbd "C-t") 'term)
(global-set-key (kbd "C-x e") 'eval-buffer)

;; (keymap-global-set "C-<up>" ')
;; (keymap-global-set "C-<down>" ')
;; (keymap-global-set "C-<left>" ')
;; (keymap-global-set "C-<right>" ')

(global-set-key (kbd "C-<f1>")
		(lambda () (interactive)
		  (disable-theme 'exotica)
		  (enable-theme 'zweilight t)))


(global-set-key (kbd "C-<f2>")
		(lambda () (interactive)
		  (disable-theme 'zweilight)
		  (enable-theme 'exotica)))

(global-set-key (kbd "C-/")
				'comment-region)

(global-set-key (kbd "C-?")
				'uncomment-region)

