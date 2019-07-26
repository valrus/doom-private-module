;;; ~/.doom.d/bindings/+main.el -*- lexical-binding: t; -*-

(map!
 :desc "Redo" :n "U" #'undo-tree-redo

 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

 (:after ivy
   (:leader
     (:prefix "/"
       :desc "Search project" :n "/" #'+default/search-project
       :desc "Find with deadgrep" :n "p" #'deadgrep)))

 ;; (:after helm
 ;;   (:leader
 ;;     (:prefix "/"
 ;;     :desc "Find in project" :n "/" #'+helm/project-search)))
 ;;
 ;; (:after helm-files
 ;;   (:map helm-find-files-map
 ;;     :desc "Up one directory" "C-h" #'helm-find-files-up-one-level))

 (:after projectile-rails
   (:map enh-ruby-mode-map
     (:localleader
       (:prefix "r"
         (:prefix ("f" . "find")
           :desc "Find view" :n "v" #'projectile-rails-find-view)))))

 (:map smerge-mode-map
   (:leader
     :desc "Smerge hydra" :n "=" #'+vc/smerge-hydra/body))

 (:leader
   (:prefix "b"
     :desc "Rename buffer" :n "R" #'rename-buffer
     :desc "Kill buffer" :n "d" #'kill-this-buffer ; consistency with `SPC w d'
     :desc "Revert buffer" :n "v" (lambda! (revert-buffer t t))
     )
   (:prefix "o"
     ;; :desc "Open directory browser" :n "b" #'treemacs
     (:prefix "a"
       :desc "Open todo file" :n "f" #'popup-todo-file))
   (:prefix "w"
     :desc "Maximize frame" :n "M" #'toggle-frame-maximized)))
