;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name    "Ian McCowan"
      user-mail-address "imccowan@gmail.com"

      +pretty-code-enabled-modes '(emacs-lisp-mode org-mode))

(setq-hook! 'minibuffer-setup-hook show-trailing-whitespace nil)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))

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

;;
;; Host-specific config
;;

(pcase (system-name)
  ("iMac.local"
   (load! "+imac-settings"))
  ("Ians-MBP"
   (load! "+mbp-settings"))
  (_
   (setq
    doom-font (font-spec :family "Iosevka" :size 12 :weight 'semi-light))))

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  ;; (add-to-list 'default-frame-alist '(ns-appearance . dark))
  ;; maximize first frame
  (set-frame-parameter nil 'fullscreen 'maximized))

;;
;; Keybindings
;;

(load! "+bindings")
(load! "+spacemacs-bindings")

;;
;; Packages
;;

(def-package! linum-relative
  :config
  (setq linum-relative-backend 'display-line-numbers-mode)
  (linum-relative-global-mode))

(def-package! evil-escape
  :config
  (global-set-key (kbd "ESC") 'evil-escape)
  nil)

;;
;; Modules
;;

;; Temporary - allow minibuffer in helm childframe
(after! helm
  (remove-hook 'helm-minibuffer-set-up-hook #'+helm*hide-minibuffer-maybe))

(after! dumb-jump
  (setq dumb-jump-prefer-searcher 'rg))

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
(after! magit
  (setq
   ;; magit-repository-directories '(("~/work" . 2))
   ;; magit-commit-arguments '("--gpg-sign=5F6C0EA160557395")
   ;; magit-rebase-arguments '("--autostash" "--gpg-sign=5F6C0EA160557395")
   ;; magit-pull-arguments   '("--rebase" "--autostash" "--gpg-sign=5F6C0EA160557395")
   +magit-hub-features t
   vc-handled-backends (delq 'Git vc-handled-backends)))

;;(after! magit
  ;; Add gpg-sign to rebasing by default
;;   (magit-define-popup-option 'magit-rebase-popup
;;     ?S "Sign using gpg" "--gpg-sign=" #'magit-read-gpg-secret-key))

;; lang/ruby
(add-hook! 'ruby-mode-hook
  (progn
    ;; (set-fill-column 120)
    ))

;; lang/markdown
(add-hook! 'markdown-mode-hook
  (progn
    (toggle-word-wrap nil)
    (auto-fill-mode -1)
  ))

;; lang/org
(setq
 ;; org-directory (expand-file-name "~/work/org/")
 org-agenda-files (list org-directory)
 org-ellipsis " ▼ "

 ;; The standard unicode characters are usually misaligned depending on the
 ;; font. This bugs me. Personally, markdown #-marks for headlines are more
 ;; elegant.
 org-bullets-bullet-list '("#"))
