;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace nil

 ;; Fonts
 doom-font (font-spec :family "Iosevka" :size 10 :weight 'semi-light)
 doom-unicode-font (font-spec :family "Iosevka")
 doom-big-font (font-spec :family "Iosevka" :size 18)
 doom-variable-pitch-font (font-spec :family "Input Sans Condensed")

;; theme
 doom-theme 'doom-nord-light
 )

(def-package! rvm
  :config
  (progn
    (rvm-use-default)))
