;; Adapted from:
;; https://www.manueluberti.eu/emacs/2018/02/17/magit-bury-buffer/
(defun valrus-magit-kill-buffers ()
  "Kill all Magit buffers."
  (interactive)
  (let ((buffers (magit-mode-get-buffers)))
    (mapc #'kill-buffer buffers)))

;; From https://emacs.stackexchange.com/a/30496
(defun valrus-magit-yank-current-branch ()
  "Show the current branch in the echo-area and add it to the `kill-ring'."
  (interactive)
  (let ((branch (magit-get-current-branch)))
    (if branch
        (progn (kill-new branch)
               (message "%s" branch))
      (user-error "There is not current branch"))))

(map!
 (:after magit
         (:map with-editor-mode-map
               ;; Use gk and gj for these
               ;; :desc "Previous comment" "C-S-k" #'log-edit-previous-comment
               ;; :desc "Next comment" "C-S-j" #'log-edit-next-comment
               (:localleader
                :desc "Commit" :n "c" #'with-editor-finish
                :desc "Abort commit" :n "a" #'with-editor-cancel))

         (:map magit-status-mode-map
          :desc "Quit" :n "q" #'valrus-magit-kill-buffers
          (:localleader
           :desc "Yank current branch" :n "y" #'valrus-magit-yank-current-branch))))
