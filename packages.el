;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(load! "autoload/configs")

(package! linum-relative)
(package! deadgrep)
(package! which-key-posframe)
(package! refine)

;; Disabled packages
(package! magit-todos :disable t)

;; Local-specific packages
(cond
 ((local-config-home-p)
  (package! tablature-mode :recipe (:fetcher github :repo "valrus/tablature-mode"))
  (package! olivetti))
 ((local-config-work-p)
  (package! haml-mode)
  (package! web-mode)
  (package! projectile-rails)
  (package! rvm)))
