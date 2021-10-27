;;; ~/.doom.d/local/+work.el -*- lexical-binding: t; -*-

(setq
 so-long-threshold 500

 ;; theme
 doom-theme 'modus-operandi
 require-final-newline nil)

(add-hook! doom-load-theme
  (set-face-attribute 'mode-line nil :box nil)
  (set-face-attribute 'mode-line-inactive nil :box nil))

(add-hook 'python-mode-hook #'format-all-mode)
(add-hook 'rjsx-mode-hook #'format-all-mode)
(add-hook 'js2-mode-hook #'format-all-mode)

(add-to-list 'safe-local-variable-values
 '(lsp-python-ms-extra-paths . "/Users/ianmccowan/Code/external-api/thrift/out/gen-py"))

;; Some files have a LOT of errors; use a less resource-intensive highlight mode
(use-package! flycheck
  :defer t
  :config
  (setq-default
   flycheck-error-list-highlight-overlays t
   flycheck-highlighting-mode 'symbols
   flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

;; emacs-mac-port only
;; (mac-auto-operator-composition-mode t)
