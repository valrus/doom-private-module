;;; +eglot.el -*- lexical-binding: t; -*-

(use-package! eglot
  :init
  ;; https://github.com/joaotavora/eglot/discussions/776
  (defvar eglot-log-event-p nil)

  (defun jsonrpc--log-event$toggle-event-log (f &rest args)
    (when (and eglot-log-event-p
               (ignore-errors
                 (eq (type-of (car args)) 'eglot-lsp-server)))
      (apply f args)))

  (defun valrus/toggle-eglot-event-log ()
    (interactive)
    (setq eglot-log-event-p (not eglot-log-event-p))
    (message "EGLOT event log is currently: %s"
             (if eglot-log-event-p "ON" "OFF")))
  :config
  (setq-hook! '(typescript-tsx-mode-hook typescript-mode-hook) +format-with-lsp nil)
  (add-to-list 'eglot-server-programs
               '(((js-mode :language-id "javascript")
                  (js-ts-mode :language-id "javascript")
                  (tsx-ts-mode :language-id "typescriptreact")
                  (tsx-mode :language-id "typescriptreact")
                  (typescript-tsx-mode :language-id "typescriptreact")
                  (typescript-ts-mode :language-id "typescript")
                  (typescript-mode :language-id "typescript"))
                 "typescript-language-server" "--stdio"))
  (assoc-delete-all 'yaml-mode eglot-server-programs)
  (advice-add #'jsonrpc--log-event :around #'jsonrpc--log-event$toggle-event-log)

  (setq-default
   eglot-workspace-configuration
   '((pylsp
      (plugins
       (jedi_completion (fuzzy . t))
       (pycodestyle (enabled . nil)))))))
