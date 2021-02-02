;;; ~/.doom.d/+imac-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace t

 ivy-height 12
 ivy-posframe-font (font-spec :family "Iosevka Slab" :size 14)

 ;; fonts
 doom-font (font-spec :family "Iosevka" :size 12 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka" :weight 'light)
 doom-big-font (font-spec :family "Iosevka" :size 20 :weight 'medium)
 doom-variable-pitch-font (font-spec :family "Iosevka Sparkle" :weight 'light)
 ;; minibuffer-font-spec '((default :family "IBM Plex Mono" :height 1.4))
 minibuffer-font-spec '((default :family "Iosevka" :height 1.0))

 ;; ui
 mac-use-title-bar t
 frame-title-format nil)

;; (set-face-attribute 'minibuffer-prompt nil :family "IBM Plex Mono" :weight 'bold)
(set-face-attribute 'minibuffer-prompt nil :family "Iosevka" :weight 'bold :height 1.0)

(load! "+work")
