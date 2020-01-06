;;; ~/.doom.d/bindings/+main.el -*- lexical-binding: t; -*-


(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))

(map!
 :desc "Redo" :n "U" #'undo-tree-redo
 :desc "Page up" :nvi "C-k" #'evil-scroll-page-up
 :desc "Page down" :nvi "C-j" #'evil-scroll-page-down

 (:leader
   (:prefix "h"
     :desc "Toggle profiler" :n "t" #'doom/toggle-profiler))

 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

 (:after ivy
   (:leader
     (:prefix "/"
       :desc "Search project" :n "/" #'+default/search-project
       :desc "Find with deadgrep" :n "p" #'deadgrep)))

 (:after helm
   (:leader
     (:prefix "/"
     :desc "Find in project" :n "/" #'+helm/project-search)))

 (:after helm-files
   (:map helm-find-files-map
     :desc "Up one directory" "C-h" #'helm-find-files-up-one-level))

 (:after projectile-rails
   (:map enh-ruby-mode-map
     (:localleader
       (:prefix "r"
         (:prefix ("f" . "find")
           :desc "Find view" :n "v" #'projectile-rails-find-view)))))

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
     :desc "Revert buffer" :n "v" (lambda! (revert-buffer t t)))

   (:prefix "o"
     (:prefix ("o" . "open org file")
       :desc "Open work notes" :n "w" #'popup-work-notes
       :desc "Open todo file" :n "t" #'popup-todo-file))

   (:prefix "TAB"
     :desc "Create workspace" :n "c" #'+workspace/new)

   (:prefix "w"
     :desc "Maximize frame" :n "M" #'toggle-frame-maximized)))
