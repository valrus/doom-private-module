;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! linum-relative)
(package! deadgrep)
(package! which-key-posframe)

;; Disabled packages
(package! magit-todos :disable t)

;; Local-specific packages
(load! "+packages.el" (local-config-dir) t)
;; (load! (local-config-file "+packages.el") nil t)
