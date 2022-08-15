;;; ~/.doom.d/local/+home.el -*- lexical-binding: t; -*-

(setq
 doom-theme 'modus-vivendi)

(after! lsp-rust
  (setq lsp-rust-server 'rust-analyzer))

(after! olivetti
  (setq-default
  olivetti-minimum-body-width 70
  olivetti-body-width 100))
