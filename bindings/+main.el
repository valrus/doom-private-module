;;; ~/.doom.d/bindings/+main.el -*- lexical-binding: t; -*-


(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))

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

 (:after evil
  (:map evil-insert-state-map
   "C-u" nil))

 (:leader
  :desc "Enter command" :n "SPC" #'counsel-M-x
  (:prefix "h"
   :desc "Toggle profiler" :n "t" #'doom/toggle-profiler))

 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

 (:after ivy
  (:leader
   (:prefix "/"
    :desc "Search all buffers" :n "a" #'swiper-all
    :desc "Search project" :n "/" #'+ivy/project-search)))

 (:after helm
  (:leader
   (:prefix "/"
    :desc "Search project" :n "/" #'+helm/project-search)))

 (:after helm-files
   (:map helm-find-files-map
     :desc "Up one directory" "C-h" #'helm-find-files-up-one-level))

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

 (:after refine
   (:leader
     (:prefix "h"
       (:prefix "C-v"
         :desc "Set variable with refine" :n #'refine))))

  (:after olivetti
    (:leader
      (:prefix "w"
        (:prefix "m"
          :desc "Olivetti mode" :n "o" #'olivetti-mode))))

 (:map smerge-mode-map
   (:leader
     :desc "Smerge hydra" :n "=" #'+vc/smerge-hydra/body))

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
       :desc "Open todo file" :n "t" #'popup-todo-file))

   (:prefix "TAB"
     :desc "Switch workspace" :n "SPC" #'+workspace/switch-to
     :desc "Create workspace" :n "c" #'+workspace/new)

   (:prefix "w"
     :desc "Maximize frame" :n "M" #'toggle-frame-maximized)))
