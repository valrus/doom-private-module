;;; Code:

;; don't wait for tab-mode activation to create the mode-map
(tab-make-mode-map)

;; import tablature-mode maps suitable for normal mode
(cl-loop for (key . action) in tab-normal-mode-map-alist
         do (map! :map tab-mode-map :n key action))

(map!
   (:map tab-mode-map
     (:leader
       (:prefix ("c" . "chord")
         :desc "Analyze chord" :n "a" #'tab-analyze-chord
         :desc "Label chord" :n "p" #'tab-label-chord
         :desc "Delete chord label" :n "d" #'tab-delete-chord-label
         :desc "Goto chord label" :n "g" #'tab-goto-chord-label)

       (:prefix ("l" . "lyrics")
         :desc "Toggle lyric line" :n "l" #'tab-toggle-lyric-line)

       (:prefix ("t" . "tuning")
         :desc "Retune string" :n "r" #'tab-retune-string))

     :ni (kbd "<left>") #'tab-backward-char
     :ni (kbd "<right>") #'tab-forward-char
     :ni (kbd "<down>") #'evil-next-line
     :ni (kbd "<up>") #'evil-previous-line

     :i " " #'tab-insert

      :n "h" #'tab-backward-char
      :n "j" #'tab-down-string
      :n "k" #'tab-up-string
      :n "l" #'tab-forward-char

      :n "H" #'tab-backward-barline
      :n "J" #'tab-down-staff
      :n "K" #'tab-up-staff
      :n "L" #'tab-forward-barline

      :n "C-j" #'tab-lower-string
      :n "C-k" #'tab-higher-string
      :n "C-l" #'tab-toggle-lyric-line

      :n "o" #'tab-make-staff

      :n "w" #'tab-forward-barline
      :n "b" #'tab-backward-barline

      ;; Not sure what I#'m going to do with these yet
      ;; (evil-define-key #'normal tab-mode-map "{" #'chord-mode
      ;; (evil-define-key #'normal tab-mode-map "}" #'lead-mode

      :n "<S-left>" #'tab-backward-char
      :n "<S-right>" #'tab-forward-char
      :n "<S-down>" #'tab-down-staff
      :n "<S-up>" #'tab-up-staff

      :n "x" #'tab-delete-current-note
      :n "X" #'tab-delete-chord-forward

      :n "dc" #'tab-delete-chord-forward

      :n "|" #'tab-barline-in-place

      ; Visual mode bindings
      :v "+" #'tab-transpose))

(def-modeline-segment! +tablature-minor-mode
  "Lead/chord mode indicator for tablature mode."
  (format "%s : %d" (if lead-mode "Lead" "Chord") tab-position-as-string))

(if (featurep! :ui modeline)
    (def-modeline-format! '+tablature
      '(+mode-line-bar " " +mode-line-buffer-id "  " +tablature-minor-mode))
  (def-modeline! '+tablature
    '(bar matches " " buffer-info "  " +tablature-minor-mode)))

;; Defunct: normal mode-line for non-Doom
;; (defun tablature/setup-normal-mode-line ()
;;   (setq mode-line-format
;;         (list ""
;;               'mode-line-modified
;;               'mode-line-buffer-identification
;;               "   "
;;               'global-mode-string
;;               "   %[("
;;               'mode-name
;;               'minor-mode-alist
;;               "--"
;;               'tab-position-as-string
;;               'tab-pending-embellishment
;;               "%n"
;;               'mode-line-process
;;               ")%]----"
;;               '(line-number-mode "L%l--")
;;               '(-3 . "%p")
;;               "-%-")))

;; Defunct: spaceline mode-line
;; (defun tablature/post-init-spaceline ()
;;   (spaceline-define-segment tablature
;;     (when (equal major-mode 'tab-mode)
;;       (list
;;        (if lead-mode "Lead" "Chord")
;;        tab-position-as-string
;;        ))
;;     :separator ":")

;;   (spaceline-spacemacs-theme 'tablature))

(defun +tablature-mode|init-modeline ()
  (funcall (if (featurep! :ui modeline)
               #'set-modeline!
             #'doom-set-modeline)
           '+tablature))
(add-hook 'tab-mode-hook tablature/tab-mode-settings)

(defun tablature/tab-mode-line ()
  (if (not (configuration-layer/package-usedp 'spaceline))
      (tablature/setup-normal-mode-line)
    (progn
      (setq-local spaceline-line-column-p nil))))

(defun tablature/tab-mode-settings ()
  (tablature/tab-mode-line)
  (chord-mode)
  (setq-local indent-tabs-mode t)
  (setq-local tab-width 4)
  (+tablature-mode|init-modeline))



;;; packages.el ends here
