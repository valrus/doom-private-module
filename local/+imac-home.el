;;; ~/.doom.d/+imac-home-settings.el -*- lexical-binding: t; -*-

(load! "+home")

(setq
 show-trailing-whitespace t

 ;; ivy-height 12
 ;; ivy-posframe-font (font-spec :family "Iosevka Slab" :size 14)

 ;; fonts
 ;; doom-font (font-spec :family "Iosevka" :size 12 :weight 'light)
 ;; doom-unicode-font (font-spec :family "Iosevka" :weight 'light)
 ;; doom-big-font (font-spec :family "Iosevka" :size 20)
 ;; doom-variable-pitch-font (font-spec :family "Iosevka Etoile" :weight 'light)

 ;; fonts: inconsolata
 doom-font (font-spec :family "Inconsolata" :size 14 :width 'semi-condensed)
 doom-serif-font (font-spec :family "monofur" :size 14)
 doom-unicode-font (font-spec :family "Inconsolata" :width 'semi-condensed)
 doom-big-font (font-spec :family "Inconsolata" :size 20)
 doom-variable-pitch-font (font-spec :family "Neris" :weight 'light :size 14)
 minibuffer-font-spec '((default :family "Inconsolata"))

 ;; theme
 doom-theme 'doom-nord)

;; (set-face-attribute 'minibuffer-prompt nil :family "IBM Plex Mono" :weight 'bold)
(apply #'set-face-attribute 'minibuffer-prompt nil (font-face-attributes doom-big-font))
