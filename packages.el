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
(package! indium)
(package! snakemake-mode)

;; light
(package! modus-operandi-theme)
;; dark
(package! modus-vivendi-theme)

;; for Spacehammer
(package! fennel-mode)

(package! tree-sitter
  :ignore (null (bound-and-true-p module-file-suffix)))
(package! tree-sitter-langs
  :ignore (null (bound-and-true-p module-file-suffix)))

(when (local-config-home-p)
  (package! mugur
    :type 'local
    :recipe (:local-repo "packages/mugur"
             :build (:not compile)))

  (package! twee-mode
    :type 'local
    :recipe (:local-repo "packages/twee-mode"
             :build (:not compile))))

;; Unpinned packages
(unpin! doom-themes)

;; Disabled packages
(package! magit-todos :disable t)
(package! solaire-mode :disable t)

;; Local-specific packages
(cond
 ((local-config-work-p)
  (package! thrift-mode
    :recipe (:host github
             :repo "davidmiller/thrift-mode"))))
