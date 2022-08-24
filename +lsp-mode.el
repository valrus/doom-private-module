;;; +lsp-mode.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :custom
  (lsp-modeline-diagnostics-enable t)
  (lsp-idle-delay 2.0)
  :config
  (setq-hook! 'rjsx-mode-hook +format-with-lsp t)
  (setq-default
   lsp-client-packages (remove 'lsp-steep lsp-client-packages)
   lsp-eslint-format t
   lsp-eslint-auto-fix-on-save nil))

;; workaround for unpinned lsp change, Doom issues #5904
(after! lsp-mode
  (advice-remove #'lsp #'+lsp-dont-prompt-to-install-servers-maybe-a))

(use-package! lsp-ui
  ;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
  :init
  (setq-default
   lsp-ui-sideline-show-code-actions nil
   lsp-ui-doc-enable nil))
