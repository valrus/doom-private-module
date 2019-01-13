;;; Code:

(map!
 (:after tablature-mode
   (:map tab-mode-map
     (:leader
       (:prefix "c"
         :desc "Analyze chord" :n "a" #'tab-analyze-chord
         :desc "Label chord" :n "p" #'tab-label-chord
         :desc "Delete chord label" :n "d" #'tab-delete-chord-label
         :desc "Goto chord label" :n "g" #'tab-goto-chord-label)

       (:prefix "l"
         :desc "Toggle lyric line" :n "l" #'tab-toggle-lyric-line)

       (:prefix "t"
         :desc "Retune string" :n "r" #'tab-retune-string))
     )
   )
 )

(defun tablature/init-tablature-mode ()
  (use-package tablature-mode
    :init
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'tab-mode
        "ca" 'tab-analyze-chord
        "cp" 'tab-label-chord
        "cd" 'tab-delete-chord-label
        "cg" 'tab-goto-chord-label
        "ll" 'tab-toggle-lyric-line
        "tr" 'tab-retune-string)

      (spacemacs/declare-prefix-for-mode 'tab-mode "mc" "chord")
      (spacemacs/declare-prefix-for-mode 'tab-mode "ml" "lyrics")
      (spacemacs/declare-prefix-for-mode 'tab-mode "mt" "tuning"))

    :config
    (progn
      ;; don't wait for tab-mode activation to create the mode-map
      (tab-make-mode-map)

      ;; import tablature-mode maps suitable for normal mode
      (cl-loop for (key . action) in tab-normal-mode-map-alist
            do (evil-define-key 'normal tab-mode-map key action))

      ;; Any mode bindings
      (dolist (mode '(normal insert))
        (evil-define-key mode tab-mode-map (kbd "<left>") 'tab-backward-char)
        (evil-define-key mode tab-mode-map (kbd "<right>") 'tab-forward-char)
        (evil-define-key mode tab-mode-map (kbd "<down>") 'evil-next-line)
        (evil-define-key mode tab-mode-map (kbd "<up>") 'evil-previous-line))

      ;; Insert mode bindings
      (evil-define-key 'insert tab-mode-map " " 'tab-insert)

      ;; Normal mode bindings
      (evil-define-key 'normal tab-mode-map "h" 'tab-backward-char)
      (evil-define-key 'normal tab-mode-map "j" 'tab-down-string)
      (evil-define-key 'normal tab-mode-map "k" 'tab-up-string)
      (evil-define-key 'normal tab-mode-map "l" 'tab-forward-char)

      (evil-define-key 'normal tab-mode-map "H" 'tab-backward-barline)
      (evil-define-key 'normal tab-mode-map "J" 'tab-down-staff)
      (evil-define-key 'normal tab-mode-map "K" 'tab-up-staff)
      (evil-define-key 'normal tab-mode-map "L" 'tab-forward-barline)

      (evil-define-key 'normal tab-mode-map (kbd "C-j") 'tab-lower-string)
      (evil-define-key 'normal tab-mode-map (kbd "C-k") 'tab-higher-string)
      (evil-define-key 'normal tab-mode-map (kbd "C-l") 'tab-toggle-lyric-line)

      (evil-define-key 'normal tab-mode-map "o" 'tab-make-staff)

      (evil-define-key 'normal tab-mode-map "w" 'tab-forward-barline)
      (evil-define-key 'normal tab-mode-map "b" 'tab-backward-barline)

      ;; Not sure what I'm going to do with these yet
      ;; (evil-define-key 'normal tab-mode-map "{" 'chord-mode)
      ;; (evil-define-key 'normal tab-mode-map "}" 'lead-mode)

      (evil-define-key 'normal tab-mode-map (kbd "<S-left>") 'tab-backward-char)
      (evil-define-key 'normal tab-mode-map (kbd "<S-right>") 'tab-forward-char)
      (evil-define-key 'normal tab-mode-map (kbd "<S-down>") 'tab-down-staff)
      (evil-define-key 'normal tab-mode-map (kbd "<S-up>") 'tab-up-staff)

      (evil-define-key 'normal tab-mode-map "x" 'tab-delete-current-note)
      (evil-define-key 'normal tab-mode-map "X" 'tab-delete-chord-forward)

      (evil-define-key 'normal tab-mode-map "dc" 'tab-delete-chord-forward)

      (evil-define-key 'normal tab-mode-map "|" 'tab-barline-in-place)

      ; Visual mode bindings
      (evil-define-key 'visual tab-mode-map "+" 'tab-transpose))))


(defun tablature/setup-normal-mode-line ()
  (setq mode-line-format
        (list ""
              'mode-line-modified
              'mode-line-buffer-identification
              "   "
              'global-mode-string
              "   %[("
              'mode-name
              'minor-mode-alist
              "--"
              'tab-position-as-string
              'tab-pending-embellishment
              "%n"
              'mode-line-process
              ")%]----"
              '(line-number-mode "L%l--")
              '(-3 . "%p")
              "-%-")))


(defun tablature/post-init-spaceline ()
  (spaceline-define-segment tablature
    (when (equal major-mode 'tab-mode)
      (list
       (if lead-mode "Lead" "Chord")
       tab-position-as-string
       ))
    :separator ":")

  (spaceline-toggle-tablature-on)
  (spaceline-spacemacs-theme 'tablature))


(defun tablature/tab-mode-line ()
  (if (not (configuration-layer/package-usedp 'spaceline))
      (tablature/setup-normal-mode-line)
    (progn
      (setq-local spaceline-line-column-p nil))))


(defun tablature/tab-mode-settings ()
  (tablature/tab-mode-line)
  (chord-mode)
  (setq-local evil-insert-state-cursor '("chartreuse3" box))
  (setq-local evil-move-cursor-back nil)
  (setq-local indent-tabs-mode t)
  (setq-local tab-width 4))


(defun tablature/post-init-tablature-mode ()
  (add-hook 'tab-mode-hook 'tablature/tab-mode-settings))


;;; packages.el ends here
