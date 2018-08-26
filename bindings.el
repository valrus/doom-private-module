;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(map!
 :desc "Redo" :n "U" #'undo-tree-redo

 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

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
