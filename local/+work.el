;;; ~/.doom.d/local/+work.el -*- lexical-binding: t; -*-

(def-package! enh-ruby-mode
  :init
  (setq-default
   enh-ruby-add-encoding-comment-on-save nil
   enh-ruby-deep-indent-paren nil
   enh-ruby-deep-indent-construct nil)
  t)

(def-package! projectile-rails
  :requires
  inflections
  :config
  (projectile-rails-global-mode)
  ;; (load! "+projectile-rails-bindings")
  t)

(def-package! haml-mode
  :mode
  "\\.haml$")
