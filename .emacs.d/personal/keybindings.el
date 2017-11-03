;; Author: Rafael Campos Nunes
;; Some useful keybindings of my own


;; Window's shortcuts
(global-set-key (kbd "M-4") 'split-window-right)
(global-set-key (kbd "M-$") 'split-window-below)
(global-set-key (kbd "M-2") 'delete-other-windows)
(global-set-key (kbd "M-0") 'delete-window)


(with-eval-after-load 'company
  ;; company autocomplete trigger
  (define-key company-mode-map (kbd "<C-return>") 'company-complete))
