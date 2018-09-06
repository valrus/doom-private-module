;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace nil

 ;; Fonts
 doom-font (font-spec :family "Iosevka" :size 10)
 doom-unicode-font (font-spec :family "Iosevka Slab")
 doom-big-font (font-spec :family "Iosevka Slab" :size 18)
 doom-variable-pitch-font (font-spec :family "Input Sans Condensed")

;; theme
 doom-theme 'doom-nord-light
 )

(def-package! rvm
  :config
  (progn
    (rvm-use-default)))
