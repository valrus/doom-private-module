;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name    "Ian McCowan"
      user-mail-address "imccowan@gmail.com"

      +pretty-code-enabled-modes '(emacs-lisp-mode org-mode enh-ruby-mode ruby-mode)
      display-line-numbers-type 'relative)

(global-auto-revert-mode -1)

;;
;; Host-specific config
;;

(load! "local/+default")
(load! (concat "local/" (local-config-file)))

(defun make-fancy-minibuffer ()
  (setq
   show-trailing-whitespace nil
   ;; room for icons (if not using childframes)
   ;; line-spacing 2
   )
  (set (make-local-variable 'face-remapping-alist) minibuffer-font-spec))

(add-hook! 'minibuffer-setup-hook 'make-fancy-minibuffer)

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  ;; maximize first frame
  (set-frame-parameter nil 'fullscreen 'maximized))

;;
;; Keybindings
;;

(load! "bindings/+main")
(load! "bindings/+spacemacs")

;;
;; Packages
;;

(use-package! evil
  :config
  (setq-default evil-kill-on-visual-paste nil
                evil-split-window-below t
                evil-vsplit-window-right t))

;; (use-package! moody
;;   :defer t
;;   :config
;;   (setq x-underline-at-descent-line t))

(use-package! tablature-mode
  :defer t
  :mode
  "\\.tab$"
  :config
  (load! "+tablature-mode-setup")
  t)

(use-package! ivy
  :defer t
  :config
  (setq
   ivy-dynamic-exhibit-delay-ms 100
   ivy-use-selectable-prompt t
   +ivy-buffer-icons t)
  (remove-hook 'ivy-mode-hook #'ivy-rich-mode)
  (load! "bindings/+ivy"))

(use-package! winum
  :defer t
  :init
  (setq-default
   winum-scope 'frame-local
   winum-auto-assign-0-to-minibuffer t)
  :config
  (load! "bindings/+winum"))

(use-package! which-key-posframe
  :defer t
  :config
  (which-key-posframe-enable))

(use-package! company
  :defer t
  :config
  (setq
   company-idle-delay nil)
  :when (featurep! +tng)
  :config
  (define-key! company-active-map
    "RET" #'company-complete-common
    [return] #'company-complete-common))

(use-package! counsel
  :defer t
  :config
  (setq
   counsel-rg-base-command "rg -S --no-heading --line-number -M 500 --color never %s ."))

(use-package! deadgrep
  :defer t
  :config
  (load! "bindings/+deadgrep"))

(use-package! refine
  :defer t)

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
   vc-handled-backends (delq 'Git vc-handled-backends)))

  ;; Temporary workaround for +magit/quit hang with lots of buffers
  ;; (define-key magit-status-mode-map [remap magit-mode-bury-buffer] nil))

(after! elisp-mode
  (load! "bindings/+elisp"))

(after! avy
  (setq avy-all-windows t))

(after! counsel
  (setq counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
        counsel-ag-base-command "ag -S --nocolor --nogroup %s"))

(after! flycheck
  (setq-default
   +flycheck-on-escape nil
   flycheck-check-syntax-automatically '(save))
  ;; fringe stuff - mess with later
  ;; where does fringe-helper-define come from?
  ;; (setq-default
  ;;  left-fringe-width 16
  ;;  right-fringe-width 16)

  ;; (fringe-helper-define
  ;;  'flycheck-fringe-bitmap-double-arrow 'center
  ;;  "......XX"
  ;;  ".....XXX"
  ;;  "....XXXX"
  ;;  "...XXXXX"
  ;;  "..XXXXXX"
  ;;  ".XXXXXXX"
  ;;  "XXXXXXXX"
  ;;  "XXXXXXXX"
  ;;  ".XXXXXXX"
  ;;  "..XXXXXX"
  ;;  "...XXXXX"
  ;;  "....XXXX"
  ;;  ".....XXX"
  ;;  "......XX")
  )

;; Don't create new workspaces for new frames
(after! persp-mode
  (setq-default persp-interactive-init-frame-behaviour-override -1))

;; Don't autopair
(after! smartparens
  (smartparens-global-mode -1))

(after! olivetti
  (setq-default
   olivetti-minimum-body-width 120
   olivetti-body-width 120))

(after! typo
  ;; disable smart quotes
  (define-key typo-mode-map (kbd "'") nil)
  (define-key typo-mode-map (kbd "\"") nil))

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
    (olivetti-mode 1)
    (typo-mode 1)
    (toggle-word-wrap nil)
    (auto-fill-mode -1)))

;; (after! poet
;;  (add-hook! (markdown-mode-hook org-mode-hook) (load-theme-buffer-local 'poet (current-buffer))))

;; lang/org
(after! org
  (setq
   ;; org-directory (expand-file-name "~/work/org/")
   org-agenda-files (list org-directory)
   org-ellipsis " ▼ "
   ;; org-bullets-bullet-list '("①" "②" "③" "④" "⑤" "⑥" "⑦" "⑧" "⑨" "⑩")))
   org-bullets-bullet-list '("◴" "◵" "◶" "◷" "⊚" "⊛" "⊗" "⊕" "⊘" "⊙")))

;; ui/popup

(after! popup
  (setq +popup-margin-width nil))

;; apps/irc

(after! irc
  (set-irc-server! "chat.freenode.net"
    `(:tls t
      :port 6697
      :nick "valrus"
      ;; :sasl-username "valrus"
      ;; :sasl-password "n/a"
      :channels ("#hammerspoon"))))

;; (setq lsp-print-io t)
