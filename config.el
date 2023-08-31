;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq
 user-full-name    "Ian McCowan"
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
(custom-set-variables '(tool-bar-mode nil))
(global-eldoc-mode -1)
(setq-default tool-bar-mode nil)
(setq-default enable-local-variables t)
(defcustom home-row-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o)
  "Characters in the keyboard home row, for alternate layouts.")

;; Temp workaround
(defun lsp-deferred () (eglot-ensure))

(if (>= emacs-major-version 29)
    (pixel-scroll-precision-mode)
  (add-to-list 'default-frame-alist '(undecorated-round . t)))

;;
;; Host-specific config
;;

(load! "local/+default")
(load! (concat "local/" (local-config-file)))

(defun make-fancy-minibuffer ()
  (setq
   show-trailing-whitespace nil
   truncate-lines nil
   ;; room for icons (if not using childframes)
   line-spacing 2)
  (set (make-local-variable 'face-remapping-alist) minibuffer-font-spec))

(add-hook! 'minibuffer-setup-hook 'make-fancy-minibuffer)

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  ;; maximize first frame
  (set-frame-parameter nil 'fullscreen 'maximized)
  ;; (load! "+fadeouts")
  )

;; Keyboard

;; (load! "+keyboard")

;;
;; Keybindings
;;

(load! "bindings/+main")
(load! "bindings/+code")
(load! "bindings/+spacemacs")

;;
;; Packages
;;

(use-package! ace-window
  :custom
  (aw-keys (remove ?m home-row-keys))
  (aw-dispatch-always t))

(after! anaconda-mode
  (remove-hook 'anaconda-mode-hook #'anaconda-eldoc-mode))

;; add formatters
;;; this is configured to lazy load automatically
(use-package! apheleia
  :hook ((tsx-mode
          typescript-mode
          js-mode
          json-mode
          css-mode
          scss-mode). apheleia-mode)
  :defer t
  :config
  (apheleia-global-mode +1)
  (push '(tsx-mode . prettier) apheleia-mode-alist)
  (push '(scss-mode . prettier) apheleia-mode-alist)
  (push '(css-mode . prettier) apheleia-mode-alist))

(map!
 :after apheleia
 :leader
 :prefix "c"
 "f" #'apheleia-format-buffer)

(use-package! avy
  :custom
  (avy-keys home-row-keys))

(after! avy
  (setq avy-all-windows t))

(use-package! chatgpt-shell
  :defer t
  :config
  (setq chatgpt-shell-openai-key
        (auth-source-pick-first-password :host "api.openai.com")))

(use-package! company
  :defer t
  :config
  (setq
   ;; no auto-popups
   company-idle-delay nil)
  (when (modulep! :completion company +tng)
    (add-to-list 'company-frontends 'company-tng-frontend))
  (when (modulep! :completion company +childframe)
    (add-to-list 'company-frontends 'company-box-frontend)))

(use-package! consult
  :defer t
  :config
  (load! "bindings/+consult.el"))

(after! counsel
  (setq counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
        counsel-ag-base-command "ag -S --nocolor --nogroup %s"))

(defun cae-copilot-clear-overlay-h ()
  "Like `copilot-clear-overlay', but returns `t' if the overlay was visible."
  (when (copilot--overlay-visible)
    (copilot-clear-overlay) t))

;; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/#restricting-when-to-show-completions
(defun valrus/no-copilot-mode ()
  "Helper for `valrus/no-copilot-modes'."
  (copilot-mode -1))

(defvar valrus/no-copilot-modes '(shell-mode
                                  inferior-python-mode
                                  eshell-mode
                                  term-mode
                                  vterm-mode
                                  comint-mode
                                  compilation-mode
                                  debugger-mode
                                  dired-mode-hook
                                  compilation-mode-hook
                                  minibuffer-mode-hook)
  "Modes in which copilot is inconvenient.")

(defun valrus/copilot-disable-predicate ()
  "When copilot should not automatically show completions."
  (or valrus/copilot-manual-mode
      (member major-mode valrus/no-copilot-modes)
      (company--active-p)))

(defvar valrus/copilot-manual-mode nil
  "When `t' will only show completions when manually triggered.")

(use-package! copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :config
  (add-to-list 'copilot-disable-predicates #'valrus/copilot-disable-predicate))

(after! copilot
  (add-hook! 'doom-escape-hook #'cae-copilot-clear-overlay-h))

(use-package! deadgrep
  :defer t
  :config
  (setq-default deadgrep-project-root-function #'doom-project-root)
  (load! "bindings/+deadgrep"))

(after! dumb-jump
  (setq dumb-jump-prefer-searcher 'rg))

(use-package! eldoc
  :config
  (global-eldoc-mode -1)
  (setq eldoc-idle-delay 5.0))

(after! eldoc
  (setq python-eldoc-get-doc nil)
  (eldoc-mode -1))

(after! elisp-mode
  (load! "bindings/+elisp"))

(use-package! evil
  :config
  (setq-default evil-kill-on-visual-paste nil
                evil-split-window-below t
                evil-vsplit-window-right t
                evil-want-Y-yank-to-eol t)
  ;; scroll to center after quick find commands
  (advice-add #'evil-ex-search-word-forward :after 'evil-scroll-line-to-center)
  (advice-add #'evil-ex-search-word-backward :after 'evil-scroll-line-to-center)
  (advice-add #'evil-ex-search-next :after 'evil-scroll-line-to-center)
  (advice-add #'evil-ex-search-previous :after 'evil-scroll-line-to-center))

(when (modulep! :editor evil)
  (use-package! evil-goggles
    :config
    (setq evil-goggles-pulse t))

  (use-package! evil-easymotion
    :custom
    (evilem-keys home-row-keys)
    :config
    (load! "bindings/+easymotion"))

  (add-hook! 'python-mode-hook (modify-syntax-entry ?_ "w"))

  (use-package! evil-text-object-python
    :hook (python-mode . evil-text-object-python-add-bindings)))

(after! flycheck
  ;; (advice-add #'flycheck-may-check-automatically :override #'ignore)
  (setq-default
   +flycheck-on-escape nil
   flycheck-check-syntax-automatically '(save idle-change mode-enabled)
   flycheck-display-errors-delay 1))

(use-package! flymake
  :custom
  (flymake-no-changes-timeout 3.0))

(use-package! format-all
  :config
  (set-formatter!
    'js-prettier
    "yarn prettier"
    :modes
    '(typescript-tsx-mode typescript-mode rjsx-mode))
  (setq +format-on-save-enabled-modes
        '(python-mode
          ;; rjsx-mode
          typescript-tsx-mode
          typescript-mode)))

(after! irc
  (set-irc-server! "chat.freenode.net"
    `(:tls t
      :port 6697
      :nick "valrus"
      ;; :sasl-username "valrus"
      ;; :sasl-password "n/a"
      :channels ("#hammerspoon"))))

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
  ;; (remove-hook 'ivy-mode-hook #'ivy-rich-mode)
  (load! "bindings/+ivy"))

(add-hook! 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))

;; tools/magit
(use-package! magit
  :config
  ;; https://jakemccrary.com/blog/2020/11/14/speeding-up-magit/
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
  ;; (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
  (load! "bindings/+magit")
  :custom
  (magit-git-executable "/usr/bin/git")
  :hook
  (with-editor-mode . (lambda ()
                        (evil-append-line 1)
                        (evil-insert-state))))

(use-package! markdown-mode
  :hook
  (markdown-mode . (lambda ()
                     (variable-pitch-mode t)
                     (toggle-word-wrap nil)
                     (auto-fill-mode -1))))

(after! modeline
  (setq
   doom-modeline-height 29
   doom-modeline-icon t
   doom-modeline-major-mode-color-icon t))

;; lang/org
(use-package! org
  :config
  (setq
   ;; org-directory (expand-file-name "~/work/org/")
   org-agenda-files (list org-directory)
   org-use-fast-todo-selection nil
   org-ellipsis " ▼ "
   org-superstar-headline-bullets-list '("◷" "◶" "◵" "◴" "⊚" "⊛" "⊗" "⊕" "⊘" "⊙")
   org-superstar-item-bullet-alist '(("*" . "•") ("+" . "‣") ("-" . "⁃"))))

(when (modulep! :lang org +journal)
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
    (load! "bindings/+org-journal")))

(when (modulep! :lang org +roam2)
  (use-package! org-roam
    :after org
    :defer t
    :custom
    (org-roam-directory (concat org-directory "roam"))
    (org-roam-buffer-position 'top)
    (org-roam-buffer-height 0.15)
    :config
    (load! "bindings/+org-roam")))

;; Don't create new workspaces for new frames
(after! persp-mode
  (setq-default persp-interactive-init-frame-behaviour-override -1))

(use-package! pipenv
  :config
  (setq pipenv-with-projectile t))

(after! popup
  (setq +popup-margin-width nil)
  (setq-default
   +popup-defaults '(:side top :height 0.16 :width 40 :quit t :select ignore :ttl 5)))

(use-package! refine
  :config
  (map!
   (:leader
    (:prefix "h"
     :desc "Set variable with refine" :n "C-v" #'refine))))

(use-package! rjsx-mode
  :config
  (setq auto-mode-alist (delete '("\\.tsx\\'" . typescript-mode) auto-mode-alist))
  (setq sgml-basic-offset 4)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . rjsx-mode)))

(use-package! ruby-mode
  :hook
  (ruby-mode . (lambda () (set-fill-column 120))))

(after! rvm
  (rvm-use-default))

(when (doom-module-p :tools 'lsp)
  (if (modulep! :tools lsp +eglot)
      (load! "+eglot.el")
    (load! "+lsp-mode.el")))

;; Don't autopair
(after! smartparens
  (smartparens-global-mode -1))

(after! typo
  ;; disable smart quotes
  (define-key typo-mode-map (kbd "'") nil)
  (define-key typo-mode-map (kbd "\"") nil))

(use-package! vertico
  :config
  (setq vertico-multiline (cons "\n" "…")))

(use-package! vimish-fold
  :config
  (setq-default vimish-fold-include-last-empty-line t))

(use-package! which-key-posframe
  :after which-key
  :defer t
  :config
  (setq
   which-key-posframe-border-width 1
   which-key-posframe-poshandler #'posframe-poshandler-frame-center))

;; (after! which-key
;;   (which-key-posframe-mode t))

(use-package! winum
  :defer t
  :init
  (setq-default
   winum-scope 'frame-local
   winum-auto-assign-0-to-minibuffer t))
