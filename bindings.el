;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(map!
 :desc "Redo" :n "U" #'undo-tree-redo

 ;; Comma for mode-local shortcut
 :n "," (λ! (push (cons t ?m) unread-command-events)
            (push (cons t 32) unread-command-events))

 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

 (:after helm
   (:map helm-find-files-map
     :desc "Up one directory" "C-h" #'helm-find-files-up-one-level
     ))

 (:leader
   (:prefix "o"
     :desc "Open directory browser" :n "b" #'treemacs
     )
   (:prefix "w"
     :desc "Maximize frame" :n "M" #'toggle-frame-maximized
     :desc "ace-window" :n "w" #'ace-window
     )
   (:prefix "/"
     :desc "Find in project" :n "/" #'+helm/project-search
     )
   )
 )
