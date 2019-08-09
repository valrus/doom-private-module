;;; ~/.doom.d/+mbp-settings.el -*- lexical-binding: t; -*-

(setq
 ;; Fonts
 doom-font (font-spec :family "Iosevka" :size 10 :weight 'light)
 doom-serif-font (font-spec :family "Iosevka Slab" :size 10 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka")
 doom-big-font (font-spec :family "Iosevka" :size 18)
 doom-variable-pitch-font (font-spec :family "Iosevka")

 ;; theme
 doom-theme 'doom-solarized-light

 ;; ui
 ;; frame-title-format nil
 ;; ns-use-proxy-icon nil
 mac-use-title-bar t)

;; minibuffer
;; (defvar minibuffer-font-family "InconsolataLGC Nerd Font")
;; (set-face-attribute 'minibuffer-prompt nil :family minibuffer-font-family :weight 'bold :height 1.0)

;; (defun set-minibuffer-font ()
;;   (let ((minibuffer-font-spec `((default :family ,minibuffer-font-family :height 1.0))))

;;     (with-current-buffer (get-buffer " *Echo Area 0*")                             ; the leading space character is correct
;;       (setq-local face-remapping-alist minibuffer-font-spec))
;;     (with-current-buffer (get-buffer " *Echo Area 1*")                             ; the leading space character is correct
;;       (setq-local face-remapping-alist minibuffer-font-spec))))

;; (add-hook 'window-startup-hook #'set-minibuffer-font)

(setq-default
 show-trailing-whitespace nil)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; for dark themes
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))

(after! org
  (setq org-directory "~/Dropbox (Personal)/Work Share/org/"))

(def-package! rvm
  :config
  (progn
    (rvm-use-default)))

(after! flycheck
  (setq flycheck-scss-lint-executable "emacs-scss-lint"))
