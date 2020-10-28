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
(package! lsp-ui)
;; light
(package! modus-operandi-theme)
;; dark
(package! modus-vivendi-theme)
;; for Spacehammer
(package! fennel-mode)

(package! tsc
  :recipe (:host github
           :repo "ubolonton/emacs-tree-sitter"
           :files ("core/*.el")))

(package! tree-sitter
  :recipe (:host github
           :repo "ubolonton/emacs-tree-sitter"
           :files ("lisp/*.el")))

(package! tree-sitter-langs
  :recipe (:host github
           :repo "ubolonton/emacs-tree-sitter"
           :files ("langs/*.el" "langs/queries")))

(straight-pull-package-and-deps "tree-sitter")

(package! mugur
  :type 'local
  :recipe (:local-repo "packages/mugur"
           :no-byte-compile t))

;; Unpinned packages
(unpin! doom-themes)

;; Disabled packages
(package! magit-todos :disable t)
(package! solaire-mode :disable t)

;; Local-specific packages
(cond
 ((local-config-work-p)
  (package! haml-mode)
  (package! web-mode)
  (package! projectile-rails)
  (package! rvm)))
