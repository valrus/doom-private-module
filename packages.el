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
;; (package! json-process-client :recipe (:host github :repo "emacsmirror/json-process-client"))

;; https://protesilaos.com/emacs/ef-themes-pictures
(package! ef-themes)

(when (local-config-work-p)
  (package! chatgpt-shell
    :recipe (:host github :repo "xenodium/chatgpt-shell"))
  (package! copilot
    :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
  (package! eslint-auto-fix-mode :recipe (:host github :repo "merrickluo/eslint-auto-fix-mode"))
  (package! semantic-thrift :recipe (:host github :repo "jerryxgh/semantic-thrift"))
  (package! git-link))

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
(package! dash-docs
  :recipe (:host github :repo "dash-docs-el/dash-docs"))
(package! fennel-mode) ; for Spacehammer

;; Unpinned packages
(unpin! doom-themes)
(unpin! eglot)
(unpin! org-roam)

;; Disabled packages
(package! magit-todos :disable t)
(package! solaire-mode :disable t)
