;;; ~/.doom.d/+imac-home-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace t

 ;; ivy-height 12
 ;; ivy-posframe-font (font-spec :family "Iosevka Slab" :size 14)

 ;; fonts
 doom-font (font-spec :family "Iosevka" :size 12 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka Slab" :weight 'light)
 doom-big-font (font-spec :family "Iosevka" :size 20)
 doom-variable-pitch-font (font-spec :family "Iosevka Aile")

 ;; theme
 doom-theme 'doom-nord)

(load! "+home")
