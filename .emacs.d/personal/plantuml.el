(org-babel-do-load-languages
 'org-babel-load-languages
 '( ;; any other babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/Downloads/plantuml.jar"))
