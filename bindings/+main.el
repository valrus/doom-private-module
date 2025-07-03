;;; ~/.doom.d/bindings/+main.el -*- lexical-binding: t; -*-


(map!
 :desc "Redo" :n "U" #'undo-fu-only-redo
 :desc "Page up" :nvi "C-k" #'evil-scroll-page-up
 :desc "Page down" :nvi "C-j" #'evil-scroll-page-down
 :desc "Beginning of line" :n "gh" #'evil-beginning-of-line
 :desc "End of line" :n "gl" #'evil-end-of-line
 :desc "Beginning of line" :n "H" #'evil-first-non-blank
 :desc "End of line" :n "L" #'evil-end-of-line

 ;; Unmap this undo
 "C-x u" nil

 ;; Unmap these un-leaderish workspace creators
 "s-t" nil
 :gn "C-t" nil

 (:after evil
         (:map evil-insert-state-map
               "C-u" nil))

 (:leader
  :desc "Enter command" :n "SPC" #'execute-extended-command
  (:prefix "h"
   :desc "Toggle profiler" :n "t" #'doom/toggle-profiler))

 (:after projectile-rails
         (:map enh-ruby-mode-map
               (:localleader
                (:prefix "r"
                         (:prefix ("f" . "find")
                          :desc "Find view" :n "v" #'projectile-rails-find-view)))))

 (:after org
         (:map org-mode-map
               (:localleader
                (:prefix ("c" . "controls")
                 :desc "Org C-c C-c" :n "c" #'org-ctrl-c-ctrl-c))))

 ;; (:map smerge-mode-map
 ;;       (:leader
 ;;        :desc "Smerge hydra" :n "=" #'+vc/smerge-hydra/body))

 ;; global bindings
 (:leader
  (:prefix "b"
   :desc "Rename buffer" :n "R" #'rename-buffer
   :desc "Kill buffer" :n "d" #'kill-this-buffer ; consistency with `SPC w d'
   :desc "Revert buffer" :n "v" (cmd! (revert-buffer t t))
   :desc "Flycheck buffer" :n "c" #'flycheck-buffer)

  (:prefix "o"
           (:prefix ("o" . "open org file")
            :desc "Open work notes" :n "w" #'popup-work-notes
            :desc "Open journal for today" :n "j" #'org-journal-new-entry
            :desc "Open todo file" :n "t" #'popup-todo-file))

  (:prefix "TAB"
   :desc "Switch workspace" :n "SPC" #'+workspace/switch-to
   :desc "Create workspace" :n "c" #'+workspace/new)

  ;; window navigation
  (:prefix "w"
   :desc "Ace-window" :n "SPC" #'ace-window
   :desc "Maximize frame" :n "M" #'toggle-frame-maximized
   :desc "Window left" :n [left] #'evil-window-left
   :desc "Window down" :n [down] #'evil-window-down
   :desc "Window up" :n [up] #'evil-window-up
   :desc "Window up" :n [right] #'evil-window-right
   :desc "Other window prefix" :n "o" #'other-window-prefix)

  (:prefix "W"
   :desc "Other frame" :n "w" #'other-frame)))
