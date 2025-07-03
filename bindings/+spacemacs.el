;;; ~/.doom.d/bindings/+spacemacs.el -*- lexical-binding: t; -*-

(map!
 ;; Comma for shortcut to local-leader
 :nv "," (λ! (push (cons t ?m) unread-command-events)
             (push (cons t 32) unread-command-events))

 ;; Use C-a as the window operations prefix for when I accidentally think I'm in tmux
 :n "C-a" (λ! (push (cons t ?w) unread-command-events)
              (push (cons t 32) unread-command-events))

 ;; Free up / to use it as a leader for search
 (:leader
  "/" nil)

 :leader "/" doom-leader-search-map

 (:leader
  (:prefix "/"
   :desc "Search project" :n "/" #'+default/search-project)
  (:prefix "f"
   :desc "Save file (Spacemacs)" :n "s" #'save-buffer
   :desc "Find file (Spacemacs)" :n "f" #'find-file)
  (:prefix "b"
   :desc "Switch buffer (Spacemacs)" :n "b" #'switch-to-buffer)
  (:prefix "w"
   :desc "Vertical split (Spacemacs)" :n "|" #'evil-window-vsplit
   :desc "Horizontal split (Spacemacs)" :n "_" #'evil-window-split
   :desc "New frame (Spacemacs)" :n "F" #'make-frame
   :desc "Next frame (Spacemacs)" :n "o" #'other-frame
   :desc "Delete window (Spacemacs)" :n "d" #'evil-quit

   ;; Displaced by other-frame keybinding
   :desc "Window enlargen" :n "O" #'doom/window-enlargen)
  (:prefix "p"
   :desc "Find project file (Spacemacs)" :n "f" #'projectile-find-file)))
