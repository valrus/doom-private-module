;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 org-directory "~/Dropbox/Work Share/org/"

 ;; Fonts
 doom-font (font-spec :family "Inconsolata" :size 13 :width 'semi-condensed)
 doom-serif-font (font-spec :family "Inconsolata" :size 13 :width 'semi-condensed)
 doom-unicode-font (font-spec :family "Noto Sans" :size 8)
 doom-big-font (font-spec :family "Inconsolata" :size 18)
 doom-variable-pitch-font (font-spec :family "PT Sans" :weight 'light)
 minibuffer-font-spec (font-spec :family "Inconsolata")

 ;; theme
 ;; doom-theme 'doom-solarized-light

 ;; ui
 ;; frame-title-format nil
 ;; ns-use-proxy-icon nil
 mac-use-title-bar t)

(setq-default
 show-trailing-whitespace nil)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; for dark themes
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))

(after! flycheck
  (setq flycheck-scss-lint-executable "emacs-scss-lint"))

(load! "+work")
