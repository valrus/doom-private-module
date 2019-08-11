;;; ~/.doom.d/+default-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace t

 ;; ivy-height 12
 ;; ivy-posframe-font (font-spec :family "Iosevka Slab" :size 14)

 ;; fonts
 doom-font (font-spec :family "Iosevka" :size 12 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka" :weight 'light)
 doom-big-font (font-spec :family "Iosevka" :size 20)
 doom-variable-pitch-font (font-spec :family "Iosevka")

 ;; theme
 doom-theme 'doom-solarized-light
)

;; minibuffer
(setq minibuffer-font-spec '((default :family "Iosevka")))
(set-face-attribute 'minibuffer-prompt nil :family "Iosevka" :weight 'bold)
