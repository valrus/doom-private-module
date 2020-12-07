;;; ~/.doom.d/+imac-home-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace t

 ;; ivy-height 12
 ;; ivy-posframe-font (font-spec :family "Iosevka Slab" :size 14)

 ;; fonts
 doom-font (font-spec :family "Iosevka" :size 12 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka" :weight 'light)
 doom-big-font (font-spec :family "Iosevka" :size 20)
 doom-variable-pitch-font (font-spec :family "Iosevka Etoile" :weight 'light)

 ;; theme
 doom-theme 'doom-nord)

(load! "+home")
