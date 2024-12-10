;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq
 user-full-name    "Ian McCowan"
 user-mail-address "imccowan@gmail.com"

 display-line-numbers-type nil

 ;; native-comp settings per
 ;; https://github.com/shshkn/emacs.d/blob/master/docs/nativecomp.md
 ;; native-comp-speed 3
 ;; disable this; doom has native-comp integration to handle it
 ;; comp-deferred-compilation t
 ;;
 fancy-splash-image (concat doom-private-dir "splash-images/lion-head.png"))

(global-auto-revert-mode -1)
(custom-set-variables '(tool-bar-mode nil))
(global-eldoc-mode -1)
(setq-default tool-bar-mode nil)
(setq-default enable-local-variables t)
(defcustom home-row-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i ?o)
  "Characters in the keyboard home row, for alternate layouts."
  :type '(repeat character))

;; Temp workaround
(defun lsp-deferred () (eglot-ensure))

(if (>= emacs-major-version 29)
    (pixel-scroll-precision-mode 0)
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
  :custom
  (apheleia-log-only-errors nil)
  :config
  (apheleia-global-mode +1)
  ;; .dir-locals.el example for ruff:
  ;; ((python-mode . ((apheleia-formatter . (ruff-format ruff-fix)))))
  ;;
  ;; ruff format $(modules)
  ;; ruff check --fix-only $(modules)
  (setf (alist-get 'ruff-format apheleia-formatters)
        '("ruff" "format" "--silent" "--stdin-filename" filepath "-"))
  (setf (alist-get 'ruff-fix apheleia-formatters)
        '("ruff" "check" "--fix-only" "--silent" "--stdin-filename" filepath "-"))
  ;; (setf (alist-get 'yarn-prettier apheleia-formatters)
  ;;       '("apheleia-npx" "prettier" "--loglevel" "silent" "--stdin-filepath" filepath))
  ;; (setf (alist-get 'eslint-d apheleia-formatters)
  ;;       '("eslint_d" "--fix-to-stdout" "--stdin" "--stdin-filepath" filepath))

  (setf (alist-get 'python-mode apheleia-mode-alist)
        '(black isort))
  (setf (alist-get 'tsx-ts-mode apheleia-mode-alist)
        '(prettier))
  (setf (alist-get 'typescript-ts-mode apheleia-mode-alist)
        '(prettier))
  (setf (alist-get 'typescript-mode apheleia-mode-alist)
        '(prettier))
  (setf (alist-get 'rjsx-mode apheleia-mode-alist)
        '(prettier))
  (setf (alist-get 'scss-mode apheleia-mode-alist)
        'yarn-stylelint)
  (setf (alist-get 'css-mode apheleia-mode-alist)
        'yarn-stylelint))

;; $ apheleia-npx --silent prettier --loglevel silent --stdin-filepath /Users/ianmccowan/Code/external-web/packages/admin-app/src/components/tickets/templates/Escalation/index.test.tsx

;; /Users/ianmccowan/.config/emacs/.local/straight/repos/apheleia/scripts/formatters/apheleia-npx: line 71: exec: --: invalid option
;; exec: usage: exec [-cl] [-a name] file [redirection ...]

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
        ;; To set this up, add this to ~/.authinfo:
        ;;  machine api.openai.com password OPENAI_KEY
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

(when (local-config-work-p)
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
                                    text-mode
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

  (defvar valrus/copilot-manual-mode t
    "When `t' will only show completions when manually triggered.")


  (use-package! copilot
    :ensure t
    :hook (prog-mode . copilot-mode)
    :custom
    (copilot-max-char -1)
    (copilot-indent-offset-warning-disable t)
    :config
    (add-to-list 'copilot-disable-predicates #'valrus/copilot-disable-predicate))

  (after! copilot
    (add-hook! 'doom-escape-hook #'cae-copilot-clear-overlay-h)))

(use-package! dash-docs
  :defer t
  :config
  (setq-default dash-docs-docsets-path "~/.config/dash"))

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
  (advice-add #'evil-ex-search-word-forward :after (lambda (&rest _) (evil-scroll-line-to-center nil)))
  (advice-add #'evil-ex-search-word-backward :after (lambda (&rest _) (evil-scroll-line-to-center nil)))
  (advice-add #'evil-ex-search-next :after (lambda (&rest _) (evil-scroll-line-to-center nil)))
  (advice-add #'evil-ex-search-previous :after (lambda (&rest _) (evil-scroll-line-to-center nil))))

(when (modulep! :editor evil)
  (use-package! evil-goggles
    :config
    (setq evil-goggles-pulse t))

  (use-package! evil-easymotion
    :custom
    (evilem-keys home-row-keys)
    :config
    (load! "bindings/+easymotion"))

  (use-package! evil-text-object-python
    :hook (python-mode . evil-text-object-python-add-bindings))

  (use-package! evil-surround
    :hook (python-mode . (lambda () (push '(?~ . ("\"\"\"" . "\"\"\"")) evil-surround-pairs-alist)))))

(after! flycheck
  (setq-default
   +flycheck-on-escape nil
   flycheck-check-syntax-automatically '(save idle-change mode-enabled)
   flycheck-display-errors-delay 1))

;; (use-package! format-all
;;   :config
;;   (set-formatter!
;;     'js-prettier
;;     "yarn prettier"
;;     :modes
;;     '(typescript-tsx-mode typescript-mode rjsx-mode))
;;   (setq +format-on-save-enabled-modes
;;         '(python-mode
;;           ;; rjsx-mode
;;           typescript-tsx-mode
;;           typescript-mode)))

(use-package! flymake
  :custom
  (flymake-popon-delay 3)
  (flymake-start-on-save-buffer nil))

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

(when (modulep! :tools lsp)
  (if (modulep! :tools lsp +eglot)
      (load! "+eglot.el")
    (load! "+lsp-mode.el")))

;; Don't autopair
(after! smartparens
  (smartparens-global-mode -1))

(after! tree-sitter
  (setq treesit-language-source-alist
        '((bash "https://github.com/tree-sitter/tree-sitter-bash")
          (cmake "https://github.com/uyha/tree-sitter-cmake")
          (css "https://github.com/tree-sitter/tree-sitter-css")
          (elisp "https://github.com/Wilfred/tree-sitter-elisp")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (html "https://github.com/tree-sitter/tree-sitter-html")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (json "https://github.com/tree-sitter/tree-sitter-json")
          (make "https://github.com/alemuller/tree-sitter-make")
          (markdown "https://github.com/ikatyang/tree-sitter-markdown")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (toml "https://github.com/tree-sitter/tree-sitter-toml")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
          (yaml "https://github.com/ikatyang/tree-sitter-yaml"))))

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
  :config
  (setq
   ;; no auto-popups
   company-idle-delay nil)
  (when (modulep! :completion company +tng)
    (add-to-list 'company-frontends 'company-tng-frontend))
  (when (modulep! :completion company +childframe)
    (add-to-list 'company-frontends 'company-box-frontend)))

;; accept completion from copilot and fallback to company
(if (local-config-work-p)
    (use-package! copilot
      :hook (prog-mode . copilot-mode)
      :bind (:map copilot-completion-map
                  ("<tab>" . 'copilot-accept-completion)
                  ("TAB" . 'copilot-accept-completion)
                  ("C-TAB" . 'copilot-accept-completion-by-word)
                  ("C-<tab>" . 'copilot-accept-completion-by-word))))

(use-package! deadgrep
  :defer t
  :config
  (setq-default deadgrep-project-root-function #'doom-project-root)
  (load! "bindings/+deadgrep"))

(use-package! evil-goggles
  :config
  (setq evil-goggles-pulse t))

(use-package! evil-easymotion
  :custom
  (evilem-keys home-row-keys)
  :config
  (load! "bindings/+easymotion"))

(use-package! org-roam
  :after org
  :defer t
  :custom
  (org-roam-directory (concat org-directory "roam"))
  (org-roam-buffer-position 'top)
  (org-roam-buffer-height 0.15)
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

(use-package! pipenv
  :config
  ;; +workspaces-switch-project-function #'ignore
  ;; condition-case: Error in a Doom startup hook: projectile-after-switch-project-hook, #[0 "^H \207" [pipenv-projectile-after-switch-function] 1], (wrong-type-argument stringp nil)
  (setq pipenv-with-projectile t))

(use-package! refine
  :config
  (map!
   (:leader
    (:prefix "h"
     :desc "Set variable with refine" :n "C-v" #'refine))))

(use-package! evil-text-object-python
  :defer t
  :hook (python-mode . evil-text-object-python-add-bindings))

;; (use-package! tree-sitter
;;   :demand t
;;   :hook
;;   ;; tree-sitter doesn't get confused by quotes in string interpolations
;;   (ruby-mode . tree-sitter-hl-mode)
;;   (enh-ruby-mode . tree-sitter-hl-mode)
;;   (python-mode . tree-sitter-hl-mode)
;;   :config
;;   (global-tree-sitter-mode))

(use-package! ace-window
  :custom
  (aw-keys (remove ?m home-row-keys))
  (aw-dispatch-always t))

(use-package! avy
  :custom
  (avy-keys home-row-keys))

(use-package! flymake
  :custom
  (flymake-no-changes-timeout 3.0))

(when (local-config-work-p)
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
            typescript-mode))))

(use-package! rjsx-mode
  :config
  (setq auto-mode-alist (delete '("\\.tsx\\'" . typescript-mode) auto-mode-alist))
  (setq sgml-basic-offset 4)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . rjsx-mode)))

;;
;; Modules
;;

;; (after! gcmh-mode
;;   (setq gcmh-high-cons-threshold #x10000000)) ;; 200MB or so

(after! dumb-jump
  (setq dumb-jump-prefer-searcher 'rg))

(after! modeline
  (setq
   doom-modeline-height 29
   doom-modeline-icon t
   doom-modeline-major-mode-color-icon t))

(after! popup
  (setq-default
   winum-scope 'frame-local
   winum-auto-assign-0-to-minibuffer t))
