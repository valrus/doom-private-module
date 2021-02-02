;; Adapted from:
;; https://www.manueluberti.eu/emacs/2018/02/17/magit-bury-buffer/
(defun valrus-magit-kill-buffers ()
  "Kill all Magit buffers."
  (interactive)
  (let ((buffers (magit-mode-get-buffers)))
    (mapc #'kill-buffer buffers)))

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
   :desc "Quit" :n "q" #'valrus-magit-kill-buffers)))
