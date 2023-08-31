;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! deadgrep)
;; Doesn't do anything without some kinda messing around
;; (not compatible with doom's modeline?)
;; (package! moody)
;; (package! which-key-posframe)
(package! refine)
(package! typo)
;; (package! poet-theme)
;; (package! lsp-ui)
(package! indium)
(package! snakemake-mode)
(package! vimrc-mode)
(package! json-process-client :recipe (:host github :repo "emacsmirror/json-process-client"))
(package! ef-themes)
(package! chatgpt-shell
  :recipe (:host github :repo "xenodium/chatgpt-shell"))
(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))

;; tsx-mode?
;; (package! tsi :recipe (:host github :repo "orzechowskid/tsi.el" :branch "main"))
;; (package! coverlay)
;; (package! origami)
;; (package! tsx-mode :recipe (:host github :repo "orzechowskid/tsx-mode.el" :branch "emacs29"))

(unpin! eglot)
(unpin! org-roam)

;; workaround for straight issue
;; (package! straight :pin "3eca3d")

;; for Spacehammer
(package! fennel-mode)

(when (local-config-home-p)
  (package! mugur
    :type 'local
    :recipe (:local-repo "packages/mugur"
             :build (:not compile)))

  (package! twee-mode
    :type 'local
    :recipe (:local-repo "packages/twee-mode"
             :build (:not compile))))

(package! evil-text-object-python)

(package! string-inflection)

;; Unpinned packages
(unpin! doom-themes)
;; (unpin! lsp-mode)
;; (unpin! lsp-python-ms)

;; Disabled packages
(package! magit-todos :disable t)
(package! solaire-mode :disable t)

;; Local-specific packages
(when (local-config-work-p)
  (package! eslint-auto-fix-mode :recipe (:host github :repo "merrickluo/eslint-auto-fix-mode"))
  (package! thrift-mode
    :recipe (:host github
             :repo "davidmiller/thrift-mode"))
  (package! git-link))

;; async formatting, commit hash "ffa8d5865118bb33299a429e9c25577a79410542"
(package! apheleia :pin "ffa8d5865118bb33299a429e9c25577a79410542")
