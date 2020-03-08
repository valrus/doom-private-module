;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! deadgrep)
;; Doesn't do anything without some kinda messing around
;; (not compatible with doom's modeline?)
;; (package! moody)
(package! which-key-posframe)
(package! refine)
(package! typo)
;; (package! poet-theme)
;; (package! olivetti)
(package! org-roam
  :recipe (:host github :repo "jethrokuan/org-roam"))
(package! org-journal
  :recipe (:host github :repo "bastibe/org-journal"))

;; Disabled packages
(package! magit-todos :disable t)
(package! solaire-mode :disable t)
;; (package! smartparens :disable t)

;; Local-specific packages
(cond
 ((local-config-home-p)
  (package! tablature-mode :recipe (:host github :repo "valrus/tablature-mode"))
  (unpin! tablature-mode))
 ((local-config-work-p)
  (package! haml-mode)
  (package! web-mode)
  (package! projectile-rails)
  (package! rvm)))
