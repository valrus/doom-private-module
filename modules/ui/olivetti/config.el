;;; ui/olivetti/config.el -*- lexical-binding: t; -*-

(use-package! olivetti
  :hook
  (markdown-mode . (lambda () (olivetti-mode 1)))
  :config
  (setq-default
   olivetti-minimum-body-width 120
   olivetti-body-width 120))
