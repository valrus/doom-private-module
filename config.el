;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name    "Ian McCowan"
      user-mail-address "imccowan@gmail.com"

      +pretty-code-enabled-modes '(emacs-lisp-mode org-mode enh-ruby-mode))

(setq-hook! 'minibuffer-setup-hook
  show-trailing-whitespace nil
  ;; room for icons
  line-spacing 1)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))

;; seems slow, barely works
;; (global-auto-revert-mode)

;;
;; Host-specific config
;;

(pcase (system-name)
  ("iMac.local"
   (pcase (user-login-name)
     ("ianbonanza"
      (load! "+imac-work-settings"))
     (_
      (load! "+imac-home-settings"))))
  ("Ians-MBP"
   (load! "+mbp-settings"))
  ("galliumos"
   (load! "+gallium-settings"))
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

(def-package! evil
  :config
  (setq-default evil-kill-on-visual-paste nil))

(def-package! linum-relative
  :config
  (setq linum-relative-backend 'display-line-numbers-mode)
  (linum-relative-global-mode))

;; (def-package! evil-escape
;;   :config
;;   (global-set-key (kbd "ESC") 'evil-escape)
;;   nil)

(def-package! enh-ruby-mode
  :init
  (setq-default
   enh-ruby-add-encoding-comment-on-save nil
   enh-ruby-deep-indent-paren nil
   enh-ruby-deep-indent-construct nil)
  t)

(def-package! projectile-rails
  :config
  (projectile-rails-global-mode)
  (load! "+projectile-rails-bindings")
  t)

(def-package! haml-mode
  :mode
  "\\.haml$")

(def-package! web-mode
  :mode
  "\\.erb")

(add-to-list 'auto-mode-alist '("\\.log\\'" . display-ansi-colors))

(def-package! tablature-mode
  :mode
  "\\.tab$"
  :config
  (load! "+tablature-mode-setup")
  t)

(def-package! ivy
  :config
  (setq
   ivy-use-selectable-prompt t
   +ivy-buffer-icons t)
  (remove-hook 'ivy-mode-hook #'ivy-rich-mode))

(def-package! winum
  :init
  (setq-default
   winum-format "[%s]"
   winum-scope 'frame-local
   winum-auto-setup-mode-line nil)
  :config
  (winum-mode)
  (load! "+winum-bindings"))

;; (def-package! ivy-prescient
;;   :config
;;   (ivy-prescient-mode))

;; (def-package! which-key-posframe
;;   :config
;;   (which-key-posframe-mode))

(def-package! company
  :config
  (setq-default
   company-idle-delay nil))

;;
;; Modules
;;

;; tools/lsp

(after! lsp-ui
  (setq-default lsp-ui-sideline nil))

;; Temporary - allow minibuffer in helm childframe
;; (after! helm
;;   (remove-hook 'helm-minibuffer-set-up-hook #'+helm*hide-minibuffer-maybe))

(after! dumb-jump
  (setq dumb-jump-prefer-searcher 'rg))

(after! doom-modeline
  (def-modeline-format! 'main
    '(bar window-number matches buffer-info remote-host buffer-position selection-info)
    '(misc-info persp-name irc mu4e github debug input-method buffer-encoding lsp major-mode process vcs checker)))

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
   git-commit-summary-max-length 80
   vc-handled-backends (delq 'Git vc-handled-backends))

  ;; Temporary workaround for +magit/quit hang with lots of buffers
  (define-key magit-status-mode-map [remap magit-mode-bury-buffer] nil))

(after! elisp-mode
  (map!
   :localleader
   :map emacs-lisp-mode-map
   "e" nil
   :nv "x" #'macrostep-expand
   (:prefix "e"
     :nv "e" #'eval-last-sexp)))

(after! avy
  (setq avy-all-windows t))

(after! counsel
  (setq counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
        counsel-ag-base-command "ag -S --nocolor --nogroup %s"))

(after! ivy
  (map!
   :map ivy-minibuffer-map
   "C-d" #'ivy-kill-line))

(after! flycheck
  (setq-default
   +flycheck-on-escape nil
   flycheck-check-syntax-automatically '(save mode-enable)))

;;(after! magit
  ;; Add gpg-sign to rebasing by default
;;   (magit-define-popup-option 'magit-rebase-popup
;;     ?S "Sign using gpg" "--gpg-sign=" #'magit-read-gpg-secret-key))

;; lang/ruby
;; (add-hook! 'ruby-mode-hook
;;   (progn
;;     (set-fill-column 120)
;;     ))
;;

(after! rvm
  (rvm-use-default))

;; (defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
;;   (rvm-activate-corresponding-ruby))

;; lang/markdown
(add-hook! 'markdown-mode-hook
  (progn
    (toggle-word-wrap nil)
    (auto-fill-mode -1)))

;; lang/org
(setq
 ;; org-directory (expand-file-name "~/work/org/")
 org-agenda-files (list org-directory)
 org-ellipsis " ▼ "

 ;; The standard unicode characters are usually misaligned depending on the
 ;; font. This bugs me. Personally, markdown #-marks for headlines are more
 ;; elegant.
 org-bullets-bullet-list '("#"))

;; (setq lsp-print-io t)
