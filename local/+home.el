;;; ~/.doom.d/local/+home.el -*- lexical-binding: t; -*-

(setq
 doom-theme 'modus-vivendi)

(setq-hook! 'rjsx-mode-hook
  js-indent-level 4)

(after! elm
  (setq-default
   elm-format-on-save-mode t
   elm-format-on-save t))

;; web mode formatter doesn't play nice with jinja templates
(setq-hook! 'web-mode-hook +format-with :none)

(after! lsp-rust
  (setq lsp-rust-server 'rust-analyzer))

(after! olivetti
  (setq-default
  olivetti-minimum-body-width 70
  olivetti-body-width 100))
