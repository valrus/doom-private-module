;;; ~/.doom.d/+default-settings.el -*- lexical-binding: t; -*-

(setq
 show-trailing-whitespace t
 org-directory "~/Dropbox/Work Share/org/"

 ;; fonts
 doom-font (font-spec :family "Iosevka" :size 12 :weight 'light)
 doom-serif-font (font-spec :family "Iosevka Slab" :size 12 :weight 'light)
 doom-unicode-font (font-spec :family "Iosevka" :size 10 :weight 'light)
 doom-big-font (font-spec :family "Iosevka" :size 20)
 doom-variable-pitch-font (font-spec :family "PT Sans")
 minibuffer-font-spec '((default :family "Iosevka"))

 ;; theme
 doom-theme 'modus-operandi)

;; line numbers must be monospaced
(custom-set-faces!
 '((line-number line-number-current-line) :family "Iosevka"))

;; this is like courier or something... yuck
(set-face-attribute 'fixed-pitch nil :family "Iosevka" :weight 'regular :height 120)
(set-face-attribute 'variable-pitch nil :family "PT Sans")

(after! ivy-rich
  (ivy-rich-modify-columns
   'ivy-switch-buffer
   '((ivy-switch-buffer-transformer (:width 24))
     (ivy-rich-switch-buffer-major-mode (:width 20))
     (ivy-rich-switch-buffer-project (:width 20)))))

;; posframes
(after! ivy-posframe
  (defun ivy-truncated-posframe-display (str)
    (ivy-posframe-display-at-frame-top-center str)
    (with-current-buffer ivy-posframe-buffer
      (setq-local word-wrap nil)
      (setq-local truncate-lines t)))

  ;; enable posframe for counsel-rg
  (dolist (fn '(swiper counsel-rg counsel-grep counsel-git-grep))
    (delq! fn ivy-posframe-display-functions-alist #'assq))

  ;; ivy display function setup
  (setq ivy-posframe-display-functions-alist
        ;; use a regular window for swiper so posframe doesn't obscure buffer previews
        '((swiper . ivy-display-function-fallback)
          (swiper-all . ivy-display-function-fallback)
          (complete-symbol . ivy-posframe-display-at-point)
          (counsel-M-x . ivy-truncated-posframe-display)
          (t . ivy-truncated-posframe-display)))

  (setq-default
   ivy-height 15
   ivy-posframe-width 160
   ivy-posframe-border-width 1
   ;; use a larger font for ivy-posframe
   ivy-posframe-font doom-big-font
   ivy-posframe-parameters '((left-fringe . 0)
                             (right-fringe . 0)
                             (internal-border-width . 10))))
   ;; ivy-posframe-font (apply #'font-spec
   ;;                          (plist-put
   ;;                           (plist-put (font-face-attributes doom-font) :size 18)
   ;;                           :weight 'medium))))
