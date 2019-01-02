;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace nil

 ;; Fonts
 doom-font (font-spec :family "Iosevka Term" :size 14)
 doom-serif-font (font-spec :family "Iosevka Term Slab" :size 14)
 doom-unicode-font (font-spec :family "Iosevka Term")
 doom-big-font (font-spec :family "Iosevka Term" :size 20)

;; theme
 doom-theme 'doom-nord
 )

(def-package! rvm
  :config
  (progn
    (rvm-use-default)))
