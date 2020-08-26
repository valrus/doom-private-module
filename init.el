;;; init.el -*- lexical-binding: t; -*-
;; workaround for gnu find on mac
(setq exec-path (append '("/usr/local/opt/findutils/libexec/gnubin") exec-path))

(load! "autoload/configs")

;;; Actual init starts here
(doom!
 :completion
 (company          ; the ultimate code completion backend
 ;; +tng ; complete using only TAB
  +childframe)
 ;; (helm             ; the *other* search engine for love and life
 ;;  +childframe
 ;;  +fuzzy)          ; enable fuzzy search backend for helm
 ;; ido               ; the other *other* search engine...
 (ivy               ; a search engine for love and life
  +childframe
  +prescient)
 ;; +icons           ; slowish
 ;; +fuzzy)          ; enable fuzzy search backend for ivy
 ;; (selectrum
 ;;  +prescient)

 :ui
 deft              ; notational velocity for Emacs
 doom              ; what makes DOOM look the way it does
 doom-dashboard    ; a nifty splash screen for Emacs
 ;; doom-quit         ; DOOM quit-message prompts when you quit Emacs
 ;; fill-column    ; a `fill-column' indicator
 hl-todo           ; highlight TODO/FIXME/NOTE tags
 hydra
 ;; indent-guides
 mini-frame
 (modeline         ; snazzy, Atom-inspired modeline, plus API
  +light)
 nav-flash         ; blink the current line after jumping
 ;; neotree           ; a project drawer, like NERDTree for vim
 ophints           ; display visual hints when editing in evil
 (popup            ; tame sudden yet inevitable temporary windows
  +all             ; catch all popups that start with an asterix
  +defaults        ; default popup rules
  )
 ;; ligatures       ; replace bits of code with pretty symbols
 ;; +iosevka ; needs a patched font
 ;; tabs              ; FIXME an (incomplete) tab bar for Emacs
 ;; treemacs          ; a project drawer, like neotree but cooler
 ;; unicode           ; extended unicode support for various languages
 ;; vc-gutter         ; vcs diff in the fringe
 ;; vi-tilde-fringe   ; fringe tildes to mark beyond EOB
 (window-select    ; visually switch windows
  +numbers)
 workspaces        ; tab emulation, persistence & separate workspaces
 zen

 :editor
 (evil +everywhere)
 file-templates    ; auto-snippets for empty files
 fold
 ;; (format +onsave)  ; automated prettiness
 ;; god
 ;; lispy             ; vim for lisp, for people who dont like vim
 multiple-cursors  ; editing in many places at once
 ;; objed
 ;; parinfer          ; turn lisp into python, sort of
 rotate-text       ; cycle region at point between text candidates
 snippets          ; my elves. They type so I don't have to
 ;; word-wrap

 :emacs
 (dired             ; making dired pretty [functional]
  ;; +ranger
  +icons)
 electric          ; smarter, keyword-based electric-indent
 (ibuffer +icons)
 undo
 vc                ; version-control and Emacs, sitting in a tree

 :term
 ;; eshell            ; a consistent, cross-platform shell (WIP)
 ;; shell
 ;; term              ; terminals in Emacs
 vterm

 :checkers
 ;; grammar
 ;; spell
 (syntax
  +childframe)

 :tools
 ;; ansible
 ;; debugger          ; FIXME stepping through code, to help you add bugs
 ;; direnv
 editorconfig      ; let someone else argue about tabs vs spaces
 ;; ein               ; tame Jupyter notebooks with emacs
 eval              ; run code, run (also, repls)
 ;; gist              ; interacting with github gists
 (lookup           ; helps you navigate your code and documentation
  +devdocs         ; ...on devdocs.io online
  +docsets)        ; ...or in Dash docsets locally
 lsp
 ;; macos             ; MacOS-specific commands
 magit
 ;; make              ; run make tasks from Emacs
 ;; pass              ; password manager for nerds
 ;; pdf               ; pdf enhancements
 ;; prodigy           ; FIXME managing external services & code builders
 ;; rgb               ; creating color strings
 ;; terraform
 ;; tmux              ; an API for interacting with tmux
 ;; upload            ; map local to remote projects via ssh/ftp
 ;; wakatime

 :lang
 ;;agda              ; types of types of types of types...
 ;; assembly          ; assembly for fun or debugging
 ;; (cc +irony +rtags); C/C++/Obj-C madness
 ;; clojure           ; java with a lisp
 ;; common-lisp       ; if you've seen one lisp, you've seen them all
 ;; crystal           ; ruby at the speed of c
 ;; csharp            ; unity, .NET, and mono shenanigans
 data              ; config/data formats
 ;; erlang            ; an elegant language for a more civilized age
 ;; elixir            ; erlang done right
 (:if (local-config-home-p) elm)
 emacs-lisp        ; drown in parentheses
 ;; ess               ; emacs speaks statistics
 ;; fsharp           ; ML stands for Microsoft's Language
 ;; go                ; the hipster dialect
 ;; (haskell +intero) ; a language that's lazier than I am
 ;; hy                ; readability of scheme w/ speed of python
 ;; (java +meghanada) ; the poster child for carpal tunnel syndrome
 ;; javascript        ; all(hope(abandon(ye(who(enter(here))))))
 ;; julia             ; a better, faster MATLAB
 ;; kotlin            ; a better, slicker Java(Script)
 (:if (local-config-home-p) (latex +latexmk))
 ;; ledger            ; an accounting system in Emacs
 lua               ; one-based indices? one-based indices
 markdown          ; writing docs for people to ignore
 ;; nim               ; python + lisp at the speed of c
 ;; nix               ; I hereby declare "nix geht mehr!"
 ;; ocaml             ; an objective camel
 (org              ; organize your plain life in plain text
  ;; +brain
  ;; +dragndrop
  ;; +jupyter
  ;; +pandoc
  ;; +gnuplot
  ;; +present
  +journal
  +roam
  )
 ;; perl              ; write code no one else can comprehend
 ;; php               ; perl's insecure younger brother
 ;; plantuml          ; diagrams for confusing people more
 ;; purescript        ; javascript, but functional
 (python           ; beautiful is better than ugly
  +pyenv)
 ;; qt                ; the 'cutest' gui framework ever
 ;; racket            ; a DSL for DSLs
 ;; rest              ; Emacs as a REST client
 (:if (local-config-work-p) (ruby +lsp +rvm +rails))
 ;; (ruby +rvm +lsp)
 ;; rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
 ;; scala             ; java, but good
 (sh +zsh)        ; she sells (ba|z)sh shells on the C xor
 ;; solidity          ; do you need a blockchain? No.
 ;; swift             ; who asked for emoji variables?
 (:if (local-config-home-p) tablature)
 ;; terra             ; Earth and Moon in alignment for performance.
 ;; vala              ; GObjective-C
 web               ; the tubes
 (yaml +lsp)

 ;; Applications are complex and opinionated modules that transform Emacs
 ;; toward a specific purpose. They may have additional dependencies and
 ;; should be loaded late.
 :app
 ;; calendar
 ;; (email +gmail)    ; emacs as an email client
 irc               ; how neckbeards socialize
 ;; (rss +org)        ; emacs as an RSS reader
 ;; twitter           ; twitter client https://twitter.com/vnought
 ;; (write            ; emacs as a word processor (latex + org + markdown)
 ;; +wordnut         ; wordnet (wn) search
 ;; +langtool)       ; a proofreader (grammar/style check) for Emacs

 :config
 ;; For literate config users. This will tangle+compile a config.org
 ;; literate config in your `doom-private-dir' whenever it changes.
 ;; literate

 ;; The default module set reasonable defaults for Emacs. It also provides
 ;; a Spacemacs-inspired keybinding scheme, a custom yasnippet library,
 ;; and additional ex commands for evil-mode. Use it as a reference for
 ;; your own modules.
 (default
 +bindings
 ;; +smartparens
 ))

;; If a :pre-init / :pre-config hook returns nil, it overwrites that package's
;; original :init / :config block. Exploit this to overwrite Doom's config.

;; (def-package-hook! evil-escape
;;   :pre-config
;;   (global-set-key (kbd "ESC") 'evil-escape)
;;   )

;; `def-package-hook' also has :post-init and :post-config hooks

(defvar-local +modeline--buffer-project-root nil)

(setq-hook! '(change-major-mode-after-body-hook
              after-save-hook
              focus-in-hook
              projectile-after-switch-project-hook)
  +modeline--buffer-project-root (if default-directory (doom-project-root)))

(defmacro def-modeline-var! (name body &optional docstring &rest plist)
  "Define a modeline segment variable."
  (unless (stringp docstring)
    (push docstring plist)
    (setq docstring nil))
  `(progn
     (defconst ,name ,body ,docstring)
     ,@(if (plist-get plist :local) `((make-variable-buffer-local ',name)))
     (put ',name 'risky-local-variable t)))

(def-modeline-var! +modeline-buffer-identification ; slightly more informative buffer id
  '((:eval
     (let ((file-name (buffer-file-name (buffer-base-buffer))))
       (propertize
        (or (when (and file-name (not (file-remote-p file-name)))
              (when-let (project +modeline--buffer-project-root)
                (file-relative-name (or buffer-file-truename (file-truename file-name))
                                    (concat project ".."))))
            "%b")
        'face (cond ((buffer-modified-p)
                     '(error bold mode-line-buffer-id))
                    ((+modeline-active)
                     'mode-line-buffer-id))
        'help-echo file-name)))
    (buffer-read-only (:propertize " RO" face warning))))
