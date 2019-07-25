;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name    "Ian McCowan"
      user-mail-address "imccowan@gmail.com"

      +pretty-code-enabled-modes '(emacs-lisp-mode org-mode enh-ruby-mode))

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))

(global-auto-revert-mode t)

;;
;; Host-specific config
;;

(load! "+default-settings")

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

(defun make-fancy-minibuffer ()
  (setq
   show-trailing-whitespace nil
   ;; room for icons
   line-spacing 1)
  (set (make-local-variable 'face-remapping-alist) minibuffer-font-spec))

(add-hook! 'minibuffer-setup-hook 'make-fancy-minibuffer)

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  ;; (add-to-list 'default-frame-alist '(ns-appearance . dark))
  ;; maximize first frame
  (set-frame-parameter nil 'fullscreen 'maximized)
  (mac-auto-operator-composition-mode))

;;
;; Keybindings
;;

(load! "bindings/+main")
(load! "bindings/+spacemacs")

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
  :requires
  inflections
  :config
  (projectile-rails-global-mode)
  ;; (load! "+projectile-rails-bindings")
  t)

(def-package! haml-mode
  :mode
  "\\.haml$")

(def-package! web-mode
  :mode
  "\\.erb")

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
  (remove-hook 'ivy-mode-hook #'ivy-rich-mode)
  (load! "bindings/+ivy.el"))

(def-package! winum
  ;; :init
  ;; (setq-default
  ;;  winum-format "[%s]"
  ;;  winum-scope 'frame-local
  ;;  winum-auto-setup-mode-line nil)
  :config
  ;; (winum-mode)
  (load! "bindings/+winum"))

;; (def-package! which-key-posframe
;;   :config
;;   (which-key-posframe-mode))

(def-package! company
  :config
  (setq-default
   company-idle-delay nil))

(def-package! deadgrep
  :config
  (load! "bindings/+deadgrep"))

;;
;; Modules
;;

;; tools/lsp

(after! lsp-ui
  (setq-default lsp-ui-sideline nil))

(after! dumb-jump
  (setq dumb-jump-prefer-searcher 'rg))

;; default modeline
;; (after! doom-modeline
;;   (def-modeline-format! 'main
;;     '(bar window-number matches buffer-info remote-host buffer-position selection-info)
;;     '(misc-info persp-name irc mu4e github debug input-method buffer-encoding lsp major-mode process vcs checker)))

(after! doom-modeline
  (def-modeline-format! 'main
    '(bar window-number modals buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info persp-name irc mu4e github debug input-method lsp major-mode process vcs checker))
  (setq
   doom-modeline-icon t
   doom-modeline-major-mode-color-icon t))

;; app/rss
;; (add-hook! 'elfeed-show-mode-hook (text-scale-set 2))

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
  (load! "bindings/+elisp"))

(after! avy
  (setq avy-all-windows t))

(after! counsel
  (setq counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
        counsel-ag-base-command "ag -S --nocolor --nogroup %s"))

(after! ivy
  (load! "bindings/+ivy"))

(after! flycheck
  (setq-default
   +flycheck-on-escape nil
   flycheck-check-syntax-automatically '(save mode-enable)))

;; Don't create new workspaces for new frames
(after! persp-mode
  (setq-default persp-interactive-init-frame-behaviour-override -1))

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
