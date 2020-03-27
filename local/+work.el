;;; ~/.doom.d/local/+work.el -*- lexical-binding: t; -*-

;; enh-ruby-mode is intolerably slow on some buffers
(advice-add #'+ruby-init-h :override #'ruby-mode)

(setq
 so-long-threshold 500
 doom-gc-cons-threshold 4194304

 ;; theme
 doom-theme 'modus-operandi)

(use-package! ruby-mode
  :defer t
  :init
  (setq-default
   ruby-align-to-stmt-keywords t
   ruby-deep-arglist nil
   ruby-deep-indent-paren nil
   ruby-insert-encoding-magic-comment nil))

(use-package! enh-ruby-mode
  :defer t
  :init
  (setq-default
   enh-ruby-add-encoding-comment-on-save nil
   enh-ruby-deep-indent-paren nil
   enh-ruby-deep-indent-construct nil)
  t)

(use-package! projectile-rails
  :defer t
  :requires
  inflections
  :config
  (projectile-rails-global-mode)
  ;; (load! "+projectile-rails-bindings")
  t)

;; Some files have a LOT of errors; use a less resource-intensive highlight mode
(use-package! flycheck
  :defer t
  :config
  (setq-default
   flycheck-error-list-highlight-overlays t
   flycheck-highlighting-mode nil
   flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(after! flycheck
  (add-hook! '(ruby-mode-hook enh-ruby-mode)
    (setq flycheck-command-wrapper-function
          (lambda (command)
            (append '("bundle" "exec") command)))))

;; emacs-mac-port only
;; (mac-auto-operator-composition-mode t)
