;;; Code:

;; don't wait for tablature-mode activation to create the mode-map
(tablature-make-mode-map)

;; import tablature-mode maps suitable for normal mode
(cl-loop for (key . action) in tablature-normal-mode-map-alist
         do (map! :map tablature-mode-map :n key action))

(map! (:map tablature-mode-map :i "SPC" #'tablature-advance))

(map!
   (:map tablature-mode-map
     (:localleader
       (:prefix ("c" . "chord")
         :desc "Analyze chord" :n "a" #'tablature-analyze-chord
         :desc "Label chord" :n "p" #'tablature-label-chord
         :desc "Delete chord label" :n "d" #'tablature-delete-chord-label
         :desc "Goto chord label" :n "g" #'tablature-goto-chord-label)

       (:prefix ("l" . "lyrics")
         :desc "Toggle lyric line" :n "l" #'tablature-toggle-lyric-line)

       (:prefix ("t" . "tuning")
         :desc "Retune string" :n "r" #'tablature-retune-string))

     :ni (kbd "<left>") #'tablature-backward-char
     :ni (kbd "<right>") #'tablature-forward-char
     :ni (kbd "<down>") #'evil-next-line
     :ni (kbd "<up>") #'evil-previous-line

     :i "SPC" #'tablature-advance

     :n "h" #'tablature-backward-char
     :n "j" #'tablature-down-string
     :n "k" #'tablature-up-string
     :n "l" #'tablature-forward-char

     :n "H" #'tablature-backward-barline
     :n "J" #'tablature-down-staff
     :n "K" #'tablature-up-staff
     :n "L" #'tablature-forward-barline

     :n "C-j" #'tablature-lower-string
     :n "C-k" #'tablature-higher-string
     :n "C-l" #'tablature-toggle-lyric-line

     :n "o" #'tablature-make-staff

     :n "w" #'tablature-forward-barline
     :n "b" #'tablature-backward-barline

     ;; Not sure what I'm going to do with these yet
     ;; (evil-define-key 'normal tablature-mode-map "{" #'chord-mode
     ;; (evil-define-key 'normal tablature-mode-map "}" #'lead-mode
     :n "{" #'ensure-chord-mode
     :n "}" #'ensure-lead-mode

     :n "<S-left>" #'tablature-backward-char
     :n "<S-right>" #'tablature-forward-char
     :n "<S-down>" #'tablature-down-staff
     :n "<S-up>" #'tablature-up-staff

     :ni "-" #'tablature-delete-note
     :n "x" #'tablature-delete-current-note
     :n "X" #'tablature-delete-chord-forward

     :n "dc" #'tablature-delete-chord-forward

     :n "|" #'tablature-barline-in-place

     ;; Visual mode bindings
     :v "+" #'tablature-transpose))

;; TODO
;; * fix RETURN in insert mode

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
;;               'tablature-position-as-string
;;               'tablature-pending-embellishment
;;               "%n"
;;               'mode-line-process
;;               ")%]----"
;;               '(line-number-mode "L%l--")
;;               '(-3 . "%p")
;;               "-%-")))

;; Defunct: spaceline mode-line
;; (defun tablature/post-init-spaceline ()
;;   (spaceline-define-segment tablature
;;     (when (equal major-mode 'tablature-mode)
;;       (list
;;        (if lead-mode "Lead" "Chord")
;;        tablature-position-as-string
;;        ))
;;     :separator ":")

;;   (spaceline-spacemacs-theme 'tablature))


;; Comment from Henrik about modeline:
;; The simplest way is to add the segments to global-mode-string variable (accepts anything you'd put in mode-line-format).
;; Otherwise, you may want to look at the documentation for def-modeline-format! (for defining preset modelines out of segments),
;; def-modeline-segment! for defining the parts, and set-modeline! for activating modelines.
;; I guess there's no better example than those calls at the bottom of ui/modeline/config.el.

(defun tablature-modeline-info ()
  (format "%s : %d" (if lead-mode "Lead" "Chord") tablature-position))

(defun +tablature-mode|tablature-mode-settings ()
  (chord-mode)
  (setq-local indent-tabs-mode t)
  (setq-local tablature-width 4))

(add-to-list 'global-mode-string '(:eval (when (eq major-mode 'tablature-mode) (tablature-modeline-info))))

(progn
(setq tablature-mode-hook nil)
(setq lead-mode-hook nil)
(setq chord-mode-hook nil)
(add-hook! tablature-mode '+tablature-mode|tablature-mode-settings))

;;; packages.el ends here
