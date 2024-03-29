;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace nil

 ;; Fonts
 doom-font (font-spec :family "Iosevka Comfy" :size 14)
 doom-serif-font (font-spec :family "Iosevka Comfy Motion" :size 14)
 doom-unicode-font (font-spec :family "Iosevka Comfy")
 doom-big-font (font-spec :family "Iosevka Comfy" :size 20)
 doom-variable-pitch-font (font-spec :family "Iosevka Comfy")
 minibuffer-font-spec '((default :family "Iosevka Comfy" :height 1.2))

 ;; theme
 doom-theme 'doom-nord

 ;; this makes emacs hang on quit
 x-select-enable-clipboard-manager nil)

;; line numbers must be monospaced
(set-face-attribute 'line-number nil :family "Iosevka Comfy")
(set-face-attribute 'line-number-current-line nil :family "Iosevka Comfy")

;; minibuffer
(set-face-attribute 'minibuffer-prompt nil :family "Iosevka Comfy" :weight 'bold)

(after! ivy-posframe
  (setq-default
   ivy-posframe-font (font-spec :family "Iosevka Comfy" :size 14)))
