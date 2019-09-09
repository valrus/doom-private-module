;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! deadgrep)
(package! which-key-posframe)
(package! refine)
(package! typo)
;; (package! poet-theme)
(package! olivetti)

;; Disabled packages
(package! magit-todos :disable t)
;; (package! smartparens :disable t)

;; Local-specific packages
(cond
 ((local-config-home-p)
  (package! tablature-mode :recipe (:host github :repo "valrus/tablature-mode")))
 ((local-config-work-p)
  (package! haml-mode)
  (package! web-mode)
  (package! projectile-rails)
  (package! rvm)))
