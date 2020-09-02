;;; ~/.doom.d/+default-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace t

 ;; fonts
 doom-font (font-spec :family "Iosevka" :size 12 :weight 'light)
 doom-serif-font (font-spec :family "Iosevka Slab" :size 12 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka" :weight 'light)
 doom-big-font (font-spec :family "Iosevka" :size 20)
 doom-variable-pitch-font (font-spec :family "Iosevka")

 ;; theme
 doom-theme 'modus-operandi)

;; line numbers must be monospaced
(custom-set-faces!
 '((line-number line-number-current-line) :family "Iosevka"))

;; minibuffer
(setq minibuffer-font-spec '((default :family "Iosevka")))
(set-face-attribute 'minibuffer-prompt nil :family "Iosevka" :weight 'bold)

(defun truncate-lines-in-child-frame (frame)
  (when (frame-parameter frame 'parent-frame)
    (setq-local word-wrap nil)
    (toggle-truncate-lines 1)))

(after! org
  (setq org-directory "~/Dropbox/Work Share/org/"))

;; posframes
(after! ivy-posframe
  (defun display-truncated-posframe (str)
    (ivy-posframe-display-at-frame-top-center str)
    (with-current-buffer ivy-posframe-buffer
      (setq-local word-wrap nil)
      (setq-local truncate-lines t)))

  ;; enable posframe for counsel-rg
  (dolist (fn '(swiper counsel-rg counsel-grep counsel-git-grep))
    (delq! fn ivy-posframe-display-functions-alist #'assq))

  (setf (alist-get t ivy-posframe-display-functions-alist)
        #'display-truncated-posframe)
  (setq-default
   ivy-height 12
   ivy-posframe-width 200
   ivy-posframe-font (font-spec :family "Iosevka" :size 14)))
