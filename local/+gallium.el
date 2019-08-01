;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace nil

 ;; Fonts
 doom-font (font-spec :family "Iosevka Term" :size 14)
 doom-serif-font (font-spec :family "Iosevka Term Slab" :size 14)
 doom-unicode-font (font-spec :family "Iosevka Term")
 doom-big-font (font-spec :family "Iosevka Term" :size 20)
 minibuffer-font-spec '((default :family "Iosevka Term" :height 1.2))

;; theme
 doom-theme 'doom-nord
 )

(set-face-attribute 'minibuffer-prompt nil :family "Iosevka Term" :weight 'bold)
