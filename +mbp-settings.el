;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace nil
 ivy-height 12
 ivy-posframe-font (font-spec :family "Iosevka Slab" :size 12)
 doom-font (font-spec :family "Iosevka" :size 10))

(def-package! rvm
  :config
  (progn
    (rvm-use-default)))
