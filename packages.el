;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! linum-relative)

(package! haml-mode)
(package! web-mode)
(package! projectile-rails)
(package! rvm)
(package! winum)

;; To disable a package

(package! magit-todos :disable t)

(package! tablature-mode :recipe (:fetcher github :repo "valrus/tablature-mode"))
