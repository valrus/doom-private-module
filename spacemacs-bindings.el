;;; ~/.doom.d/spacemacs-bindings.el -*- lexical-binding: t; -*-

(map!
 (:after magit
   (:map with-editor-mode-map
     (:prefix ","
       :desc "Commit" :n "c" #'with-editor-finish
       :desc "Commit" :n "a" #'with-editor-finish
       )))

 (:leader
   (:prefix "f"
     :desc "Save file (Spacemacs)" :n "s" #'save-buffer
     :desc "Find file (Spacemacs)" :n "f" #'find-file
     )
   (:prefix "b"
     :desc "Previous buffer (Spacemacs)" :n "p" #'previous-buffer
     :desc "Next buffer (Spacemacs)" :n "n" #'next-buffer
     :desc "Switch buffer (Spacemacs)" :n "b" #'helm-buffers-list
     )
   (:prefix "w"
     :desc "Vertical split (Spacemacs)" :n "|" #'evil-window-vsplit
     :desc "Horizontal split (Spacemacs)" :n "-" #'evil-window-split
     :desc "New frame (Spacemacs)" :n "F" #'make-frame
     :desc "Next frame (Spacemacs)" :n "o" #'other-frame
     :desc "Window enlargen" :n "O" #'doom/window-enlargen
     )
   (:prefix "p"
     :desc "Find project file (Spacemacs)" :n "f" #'projectile-find-file
     )
   )
 )
