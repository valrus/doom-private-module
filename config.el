;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name    "Ian McCowan"
      user-mail-address "imccowan@gmail.com"

      ;; doom-variable-pitch-font (font-spec :family "Fira Sans")
      ;; doom-unicode-font (font-spec :family "Input Mono Narrow" :size 12)
      doom-big-font (font-spec :family "Iosevka Slab" :size 18)

      +pretty-code-enabled-modes '(emacs-lisp-mode org-mode))

(setq-hook! 'minibuffer-setup-hook show-trailing-whitespace nil)

;; load heavy packages all sneaky breeky like
(defun auto-require-packages (packages)
  (let* ((reqs (cl-remove-if #'featurep packages))
         (req (pop reqs)))
    (when req
      (require req)
      (when reqs
        (run-with-idle-timer 1 nil #'auto-require-packages reqs)))))

(run-with-idle-timer 1 nil #'auto-require-packages
                     '(calendar find-func format-spec org-macs org-compat
                       org-faces org-entities org-list org-pcomplete org-src
                       org-footnote org-macro ob org org-clock org-agenda
                       org-capture with-editor git-commit package magit))

(after! 'doom-themes
(doom/switch-theme 'doom-nord-light))


;;
;; Host-specific config
;;

(pcase (system-name)
  ("iMac.local"
   (setq
    show-trailing-whitespace t
    ivy-height 12
    ivy-posframe-font (font-spec :family "Iosevka Slab" :size 14)
    doom-font (font-spec :family "Iosevka" :size 12)))
  (_
   (setq
    ivy-posframe-font (font-spec :family "Iosevka" :size 18)
    doom-font (font-spec :family "Iosevka" :size 12 :weight 'semi-light))))

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  ;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  ;; (add-to-list 'default-frame-alist '(ns-appearance . dark))
  ;; maximize first frame
  (set-frame-parameter nil 'fullscreen 'maximized))


;;
;; Keybindings
;;

(map!
 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

 ;; Import Spacemacs bindings
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
   )

 ;; Replace or add Doom bindings
 (:leader
   (:prefix "o"
     :desc "Open directory browser" :n "b" #'treemacs
     )
   )
 )

;;
;; Packages
;;

(def-package! linum-relative
  :config
  (progn
  	(setq linum-relative-backend 'display-line-numbers-mode)
    (linum-relative-on))
  :hook
  (fundamental-mode . linum-relative-mode))

;;
;; Modules
;;

;; app/rss
;; (add-hook! 'elfeed-show-mode-hook (text-scale-set 2))

;; emacs/eshell
;; (after! eshell
;;   (set-eshell-alias!
;;    "f"   "find-file $1"
;;    "l"   "ls -lh"
;;    "d"   "dired $1"
;;    "gl"  "(call-interactively 'magit-log-current)"
;;    "gs"  "magit-status"
;;    "gc"  "magit-commit"
;;    "rg"  "rg --color=always $*"))

;; tools/magit
(setq
 ;; magit-repository-directories '(("~/work" . 2))
 ;; magit-commit-arguments '("--gpg-sign=5F6C0EA160557395")
 ;; magit-rebase-arguments '("--autostash" "--gpg-sign=5F6C0EA160557395")
 ;; magit-pull-arguments   '("--rebase" "--autostash" "--gpg-sign=5F6C0EA160557395")
 +magit-hub-features t)

;;(after! magit
  ;; Add gpg-sign to rebasing by default
;;   (magit-define-popup-option 'magit-rebase-popup
;;     ?S "Sign using gpg" "--gpg-sign=" #'magit-read-gpg-secret-key))

;; lang/org
(setq
 ;; org-directory (expand-file-name "~/work/org/")
 org-agenda-files (list org-directory)
 org-ellipsis " ▼ "

 ;; The standard unicode characters are usually misaligned depending on the
 ;; font. This bugs me. Personally, markdown #-marks for headlines are more
 ;; elegant.
 org-bullets-bullet-list '("#"))
