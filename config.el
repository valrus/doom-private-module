;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name    "Ian McCowan"
      user-mail-address "imccowan@gmail.com"

      +pretty-code-enabled-modes '(emacs-lisp-mode org-mode enh-ruby-mode ruby-mode)
      display-line-numbers-type nil

      ;; native-comp settings per
      ;; https://github.com/shshkn/emacs.d/blob/master/docs/nativecomp.md
      comp-speed 3
      ;; disable this; doom has native-comp integration to handle it
      ;; comp-deferred-compilation t
      ;;
      straight-vc-git-default-protocol 'ssh
      fancy-splash-image (concat doom-private-dir "splash-images/lion-head.png"))

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
  (set-frame-parameter nil 'fullscreen 'maximized)
  ;; (load! "+fadeouts")
  )

;; Keyboard

(load! "+keyboard")

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

(use-package! ivy
  :defer t
  :config
  (setq
   ivy-dynamic-exhibit-delay-ms 400
   ivy-use-selectable-prompt t
   +ivy-buffer-preview t
   +ivy-buffer-icons t
   ;; treat space as .* rather than a literal space
   ivy-re-builders-alist '((t . ivy--regex-plus)))
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
  :after which-key
  :defer t
  :config
  (setq
   which-key-posframe-border-width 1
   which-key-posframe-poshandler #'posframe-poshandler-frame-center))

(after! which-key
  (which-key-posframe-mode t))

(use-package! company
  :defer t
  :config
  (setq
   company-idle-delay nil))

(use-package! counsel
  :defer t
  :config
  ;; (setq
  ;;  counsel-rg-base-command "rg -S --with-filename --no-heading --line-number -M 300 --color never %s || true")
  )

(use-package! deadgrep
  :defer t
  :config
  (setq-default deadgrep-project-root-function #'doom-project-root)
  (load! "bindings/+deadgrep"))

(use-package! evil-goggles
  :config
  (setq evil-goggles-pulse t))

(use-package! org-roam
  :after org
  :defer t
  :hook (org-mode . org-roam-mode)
  :custom
  (org-roam-directory (concat org-directory "roam"))
  :config
  (load! "bindings/+org-roam"))

(use-package! org-journal
  :after org
  :defer t
  :custom
  ;; Enable journal entries to work with org-roam
  (org-journal-dir (concat org-directory "roam"))
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-date-prefix "#+TITLE: ")
  (org-journal-date-format "%Y-%m-%d")
  :config
  (load! "bindings/+org-journal"))

(use-package! tree-sitter
  :demand t
  :hook
  ;; tree-sitter doesn't get confused by quotes in string interpolations
  (ruby-mode . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))

(use-package! tree-sitter-langs
  :after tree-sitter)
;;
;; Modules
;;

;; (after! gcmh-mode
;;   (setq gcmh-high-cons-threshold #x10000000)) ;; 200MB or so

;; tools/lsp

(after! lsp
  (setq-default
   lsp-modeline-diagnostics-enable t))

(after! lsp-ui
  (setq-default
   lsp-ui-sideline nil))

(after! lsp-rust
  (setq lsp-rust-server 'rust-analyzer))

(after! dumb-jump
  (setq dumb-jump-prefer-searcher 'rg))

(after! modeline
  (setq
   doom-modeline-height 29
   doom-modeline-icon t
   doom-modeline-major-mode-color-icon t))

(after! popup
  (setq-default
   +popup-defaults '(:side top :height 0.16 :width 40 :quit t :select ignore :ttl 5)))

;; app/rss
;; (add-hook! 'elfeed-show-mode-hook (text-scale-set 2))

;; tools/magit
(after! magit
  (add-hook! 'with-editor-mode-hook (progn (evil-append-line 1) (evil-insert-state)))
  (setq
   ;; magit-repository-directories '(("~/work" . 2))
   ;; magit-commit-arguments '("--gpg-sign=5F6C0EA160557395")
   ;; magit-rebase-arguments '("--autostash" "--gpg-sign=5F6C0EA160557395")
   ;; magit-pull-arguments   '("--rebase" "--autostash" "--gpg-sign=5F6C0EA160557395")
   ;; +magit-hub-features t
   git-commit-summary-max-length 80
   vc-handled-backends (delq 'Git vc-handled-backends)))

(load! "bindings/+magit")

(after! elisp-mode
  (load! "bindings/+elisp"))

(after! avy
  (setq avy-all-windows t))

(after! counsel
  (setq counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
        counsel-ag-base-command "ag -S --nocolor --nogroup %s"))

(after! flycheck
  (advice-add #'flycheck-may-check-automatically :override #'ignore)
  (setq-default
   +flycheck-on-escape nil
   flycheck-check-syntax-automatically nil
   flycheck-display-errors-delay 1))

;; Don't create new workspaces for new frames
(after! persp-mode
  (setq-default persp-interactive-init-frame-behaviour-override -1))

;; Don't autopair
(after! smartparens
  (smartparens-global-mode -1))

(after! olivetti
  (add-hook! 'markdown-mode-hook
    (olivetti-mode 1))
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
(add-hook! 'ruby-mode-hook
  (progn
    (set-fill-column 120)))


(after! rvm
  (rvm-use-default))

(after! elm
  (setq-default
   elm-format-on-save-mode t
   elm-format-on-save t))

;; (defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
;;   (rvm-activate-corresponding-ruby))

;; lang/markdown
(add-hook! 'markdown-mode-hook
  (progn
    (variable-pitch-mode t)
    (toggle-word-wrap nil)
    (auto-fill-mode -1)))

;; (after! poet
;;  (add-hook! (markdown-mode-hook org-mode-hook) (load-theme-buffer-local 'poet (current-buffer))))

;; lang/org
(after! org
  (setq
   ;; org-directory (expand-file-name "~/work/org/")
   org-agenda-files (list org-directory)
   org-use-fast-todo-selection nil
   org-ellipsis " ▼ "
   ;; org-bullets-bullet-list '("①" "②" "③" "④" "⑤" "⑥" "⑦" "⑧" "⑨" "⑩")))
   org-bullets-bullet-list '("◷" "◶" "◵" "◴" "⊚" "⊛" "⊗" "⊕" "⊘" "⊙")))

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
