;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace nil

 ;; Fonts
 doom-font (font-spec :family "Iosevka" :size 10 :weight 'light)
 doom-serif-font (font-spec :family "Iosevka Slab" :size 10 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka")
 doom-big-font (font-spec :family "Iosevka" :size 18)
 doom-variable-pitch-font (font-spec :family "Iosevka")

 ;; theme
 doom-theme 'doom-solarized-light

 ;; ui
 ;; ns-use-proxy-icon nil
 mac-use-title-bar t
 ;; frame-title-format nil
 )

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; for dark themes
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))

(after! org
  (setq org-directory "~/Dropbox (Personal)/Work Share/org/todo.org"))

(def-package! rvm
  :config
  (progn
    (rvm-use-default)))

(after! flycheck
  (setq flycheck-scss-lint-executable "emacs-scss-lint"))
