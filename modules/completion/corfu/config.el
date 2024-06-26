;;; completion/corfu/config.el -*- lexical-binding: t; -*-

;; Corfu completion module

(defvar +corfu-global-capes
  '(:completion
    cape-dict)
  "A list of global capes to be available at all times.
  The key :completion is used to specify where completion candidates should be
  placed, otherwise they come first.")

(defvar +corfu-capf-hosts
  '(lsp-completion-at-point
    eglot-completion-at-point
    elisp-completion-at-point
    tags-completion-at-point-function)
  "A prioritised list of host capfs to create a super cape onto from
  `+corfu-global-capes'.")

(defun +corfu--load-capes ()
  "Load all capes specified in `+corfu-global-capes'."
  (interactive)
  (when-let ((host (cl-intersection +corfu-capf-hosts completion-at-point-functions)))
    (setq-local
     completion-at-point-functions
     (cl-substitute
      (apply #'cape-capf-super (cl-substitute (car host) :completion (cl-pushnew :completion +corfu-global-capes)))
      (car host)
      completion-at-point-functions))))

(add-hook 'lsp-mode-hook #'+corfu--load-capes)
(add-hook 'eglot-mode-hook #'+corfu--load-capes)
(add-hook 'change-major-mode-hook #'+corfu--load-capes)

(use-package! corfu
  :custom
  (corfu-separator ?\s)
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-preview-current nil) ;; Disable current candidate preview
  (corfu-on-exact-match nil)
  (corfu-quit-no-match 'separator)
  (corfu-cycle t)
  (corfu-auto-prefix 2)
  (completion-cycle-threshold 1)
  (tab-always-indent 'complete)
  (corfu-max-width 80)
  (corfu-preselect-first nil)
  :hook
  (doom-first-buffer . global-corfu-mode)
  :config
  (when (modulep! +minibuffer)
    (add-hook 'minibuffer-setup-hook #'+corfu--enable-in-minibuffer))

  ;; Dirty hack to get c completion running
  ;; Discussion in https://github.com/minad/corfu/issues/34
  (when (and (modulep! :lang cc)
             (equal tab-always-indent 'complete))
    (map! :map c-mode-base-map
          :i [remap c-indent-line-or-region] #'completion-at-point))

  ;; Reset lsp-completion provider
  (add-hook 'doom-init-modules-hook
            (lambda ()
              (after! lsp-mode
                (setq lsp-completion-provider :none))))

  ;; Set orderless filtering for LSP-mode completions
  ;; TODO: expose a Doom variable to control this part
  (add-hook 'lsp-completion-mode-hook
            (lambda ()
              (setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless flex))))))

  (defun corfu-move-to-minibuffer ()
    "Move current completions to the minibuffer"
    (interactive)
    (let ((completion-extra-properties corfu--extra)
          completion-cycle-threshold completion-cycling)
      (apply #'consult-completion-in-region completion-in-region--data)))

  (map! :map corfu-map
        "C-SPC"     #'corfu-insert-separator
        "C-n"       #'corfu-next
        "TAB"       #'corfu-next
        "<tab>"     #'corfu-next
        "C-p"       #'corfu-previous
        "S-TAB"     #'corfu-previous
        "<backtab>" #'corfu-previous
        "M-m"       #'corfu-move-to-minibuffer
        (:prefix "C-x"
                 "C-k"     #'cape-dict
                 "s"       #'cape-ispell
                 "C-n"     #'cape-keyword
                 "C-f"     #'cape-file))
  (after! evil
    (advice-add 'corfu--setup :after 'evil-normalize-keymaps)
    (advice-add 'corfu--teardown :after 'evil-normalize-keymaps)
    (evil-make-overriding-map corfu-map))

  (defadvice! +corfu--org-return (orig) :around '+org/return
    (if (and (modulep! :completion corfu)
             corfu-mode
             (>= corfu--index 0))
        (corfu-insert)
      (funcall orig)))

  ;; TODO: check how to deal with Daemon/Client workflow with that
  (unless (display-graphic-p)
    (corfu-doc-terminal-mode)
    (corfu-terminal-mode)))

(use-package! orderless
  :when (modulep! +orderless)
  :init
  (setq completion-styles '(orderless partial-completion)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package! kind-icon
  :after corfu
  :when (modulep! +icons)
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (setq kind-icon-use-icons t
        svg-lib-icons-dir (expand-file-name "svg-lib" doom-cache-dir)
        kind-icon-mapping
        '((array "a" :icon "code-brackets" :face font-lock-variable-name-face)
          (boolean "b" :icon "circle-half-full" :face font-lock-builtin-face)
          (class "c" :icon "view-grid-plus-outline" :face font-lock-type-face)
          (color "#" :icon "palette" :face success)
          (constant "co" :icon "pause-circle" :face font-lock-constant-face)
          (constructor "cn" :icon "table-column-plus-after" :face font-lock-function-name-face)
          (enum "e" :icon "format-list-bulleted-square" :face font-lock-builtin-face)
          (enum-member "em" :icon "format-list-checks" :face font-lock-builtin-face)
          (event "ev" :icon "lightning-bolt-outline" :face font-lock-warning-face)
          (field "fd" :icon "application-braces-outline" :face font-lock-variable-name-face)
          (file "f" :icon "file" :face font-lock-string-face)
          (folder "d" :icon "folder" :face font-lock-doc-face)
          (function "f" :icon "lambda" :face font-lock-function-name-face)
          (interface "if" :icon "video-input-component" :face font-lock-type-face)
          (keyword "kw" :icon "image-filter-center-focus" :face font-lock-keyword-face)
          (macro "mc" :icon "sigma" :face font-lock-keyword-face)
          (method "m" :icon "lambda" :face font-lock-function-name-face)
          (module "{" :icon "view-module" :face font-lock-preprocessor-face})
          (numeric "nu" :icon "numeric" :face font-lock-builtin-face)
          (operator "op" :icon "plus-circle-outline" :face font-lock-comment-delimiter-face)
          (param "pa" :icon "cog" :face default)
          (property "pr" :icon "tune-vertical" :face font-lock-variable-name-face)
          (reference "rf" :icon "bookmark-box-multiple" :face font-lock-variable-name-face)
          (snippet "S" :icon "text-short" :face font-lock-string-face)
          (string "s" :icon "sticker-text-outline" :face font-lock-string-face)
          (struct "%" :icon "code-braces" :face font-lock-variable-name-face)
          (t "." :icon "crosshairs-question" :face shadow)
          (text "tx" :icon "script-text-outline" :face shadow)
          (type-parameter "tp" :icon "format-list-bulleted-type" :face font-lock-type-face)
          (unit "u" :icon "ruler-square" :face shadow)
          (value "v" :icon "numeric-1-box-multiple-outline" :face font-lock-builtin-face)
          (variable "va" :icon "adjust" :face font-lock-variable-name-face)))
  (add-hook 'doom-load-theme-hook #'kind-icon-reset-cache)
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


(use-package! cape
  :defer t
  :init
  (map!
   [remap dabbrev-expand] 'cape-dabbrev)
  (add-hook! 'latex-mode-hook (defun +corfu--latex-set-capfs ()
                                (add-to-list 'completion-at-point-functions #'cape-tex)))
  (when (modulep! :checkers spell)
    (add-to-list 'completion-at-point-functions #'cape-dict)
    (add-to-list 'completion-at-point-functions #'cape-ispell))
  (add-to-list 'completion-at-point-functions #'yasnippet-capf)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword t)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev t))


(use-package! corfu-history
  :after corfu
  :hook (corfu-mode . (lambda ()
                        (corfu-history-mode 1)
                        (savehist-mode 1)
                        (add-to-list 'savehist-additional-variables 'corfu-history))))

(use-package! corfu-quick
  :after corfu
  :bind (:map corfu-map
              ("M-q" . corfu-quick-complete)
              ("C-q" . corfu-quick-insert)))

(use-package! corfu-echo
  :after corfu
  :hook (corfu-mode . corfu-echo-mode))


(use-package! corfu-info
  :after corfu)


(use-package! corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode))

(when (modulep! :editor evil +everywhere)
  (setq evil-collection-corfu-key-themes '(default magic-return)))
