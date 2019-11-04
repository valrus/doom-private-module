;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 ;; Fonts
 doom-font (font-spec :family "Iosevka" :size 10 :weight 'light)
 doom-serif-font (font-spec :family "Iosevka Slab" :size 10 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka")
 doom-big-font (font-spec :family "Iosevka" :size 18)
 doom-variable-pitch-font (font-spec :family "Iosevka Aile")

 ;; theme
 doom-theme 'doom-solarized-light

 ;; ui
 ;; frame-title-format nil
 ;; ns-use-proxy-icon nil
 mac-use-title-bar t)

(setq-default
 show-trailing-whitespace nil)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; for dark themes
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))

(after! org
  (setq org-directory "~/Dropbox (Personal)/Work Share/org/"))

(use-package! rvm
  :config
  (progn
    (rvm-use-default)))

(after! flycheck
  (setq flycheck-scss-lint-executable "emacs-scss-lint"))

(load! "+work")
