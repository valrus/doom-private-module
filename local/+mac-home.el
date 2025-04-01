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
 ;; doom-font (font-spec :family "Inconsolata" :size 14 :width 'semi-condensed)
 ;; doom-font (font-spec :family "Operator Mono Light" :weight 'light :size 14)
 ;; doom-font (font-spec :family "Iosevka" :size 14 :weight 'semi-light)

 ;; fonts: iosevka custom
 ;; doom-font (font-spec :family "Iosevka Custom" :size 14 :weight 'light)
 ;; doom-serif-font (font-spec :family "Iosevka Slab" :size 14 :weight 'semi-light)
 ;; doom-unicode-font (font-spec :family "Iosevka Custom" :size 14 :weight 'light)
 ;; doom-big-font (font-spec :family "Iosevka Custom" :size 20 :weight 'light)
 ;; doom-variable-pitch-font (font-spec :family "PT Sans" :weight 'light :size 14)
 ;; minibuffer-font-spec '((default :family "Iosevka Custom"))

 ;; fonts: maple mono
 doom-font (font-spec :family "Maple Mono" :size 14 :weight 'light)
 doom-serif-font (font-spec :family "Iosevka Slab" :size 14 :weight 'semi-light)
 doom-unicode-font (font-spec :family "Maple Mono" :size 14 :weight 'light)
 doom-big-font (font-spec :family "Maple Mono" :size 20 :weight 'light)
 doom-variable-pitch-font (font-spec :family "PT Sans" :weight 'light :size 14)
 minibuffer-font-spec '((default :family "Maple Mono"))

 ;; fonts: cartograph
 ;; doom-font (font-spec :family "Cartograph Mono CF" :size 14 :weight 'light)
 ;; doom-serif-font (font-spec :family "Cartograph Mono CF" :size 14 :weight 'semi-light)
 ;; doom-unicode-font (font-spec :family "Cartograph Mono CF" :size 14 :weight 'light)
 ;; doom-big-font (font-spec :family "Cartograph Mono CF" :size 20 :weight 'light)
 ;; doom-variable-pitch-font (font-spec :family "PT Sans" :weight 'light :size 14)
 ;; minibuffer-font-spec '((default :family "Cartograph Mono CF"))

 ;; theme
 doom-theme 'doom-nord)

;; (set-face-attribute 'minibuffer-prompt nil :family "IBM Plex Mono" :weight 'bold)
;; (apply #'set-face-attribute 'minibuffer-prompt nil (font-face-attributes doom-big-font))
