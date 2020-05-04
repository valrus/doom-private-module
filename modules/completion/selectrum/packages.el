;; -*- no-byte-compile: t; -*-
;;; completion/selectrum/packages.el

(package! selectrum)

(if (featurep! +prescient)
    (package! selectrum-prescient))
