;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! linum-relative)

(package! deadgrep)
(package! haml-mode)
(package! web-mode)
(package! projectile-rails)
(package! rvm)
(package! which-key-posframe)

;; To disable a package

(package! magit-todos :disable t)

(package! tablature-mode :recipe (:fetcher github :repo "valrus/tablature-mode"))
