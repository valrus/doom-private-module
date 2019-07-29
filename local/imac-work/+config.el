;;; ~/.doom.d/+imac-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace t

 ;; ivy-height 12
 ;; ivy-posframe-font (font-spec :family "Iosevka Slab" :size 14)

 ;; fonts
 doom-font (font-spec :family "Iosevka SS09" :size 12 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka" :weight 'medium)
 doom-big-font (font-spec :family "Iosevka" :size 20 :weight 'medium)
 doom-variable-pitch-font (font-spec :family "InputSansCompressed")
 minibuffer-font-spec '((default :family "InputMono" :height 1.4))

 ;; theme
 doom-theme 'doom-solarized-light
)

(set-face-attribute 'minibuffer-prompt nil :family "InputSans" :weight 'bold)