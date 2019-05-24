;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company          ; the ultimate code completion backend
        +childframe)
       ;; +auto)           ; as-you-type code completion
       ;; (helm             ; the *other* search engine for love and life
       ;;  +childframe
       ;;  +fuzzy)          ; enable fuzzy search backend for helm
       ido               ; the other *other* search engine...
       ivy               ; a search engine for love and life
        ;; +fuzzy)          ; enable fuzzy search backend for ivy

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
      ;doom-modeline     ; a snazzy Atom-inspired mode-line
      ;doom-quit         ; DOOM quit-message prompts when you quit Emacs
      ;fci               ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE tags
       indent-guides
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
      ;neotree           ; a project drawer, like NERDTree for vim
       ophints           ; display visual hints when editing in evil
       treemacs          ; a project drawer, like neotree but cooler
       (popup            ; tame sudden yet inevitable temporary windows
        +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       pretty-code       ; replace bits of code with pretty symbols
      ;tabbar            ; FIXME an (incomplete) tab bar for Emacs
      ;unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
      ;vi-tilde-fringe   ; fringe tildes to mark beyond EOB
      ;(window-select    ; visually switch windows
      ; +switch-window)
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold
       multiple-cursors  ; editing in many places at once
      ;parinfer          ; turn lisp into python, sort of
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       vc                ; version-control and Emacs, sitting in a tree

       :term
      ;eshell            ; a consistent, cross-platform shell (WIP)
       term              ; terminals in Emacs

       :tools
      ;ansible
      ;debugger          ; FIXME stepping through code, to help you add bugs
       editorconfig      ; let someone else argue about tabs vs spaces
      ;ein               ; tame Jupyter notebooks with emacs
       eval              ; run code, run (also, repls)
      (flycheck +childframe)
      ;gist              ; interacting with github gists
       (lookup           ; helps you navigate your code and documentation
        +devdocs         ; ...on devdocs.io online
        +docsets)        ; ...or in Dash docsets locally
      ;lsp
       macos             ; MacOS-specific commands
       magit
      ;make              ; run make tasks from Emacs
      ;password-store    ; password manager for nerds
      ;pdf               ; pdf enhancements
      ;prodigy           ; FIXME managing external services & code builders
      ;rgb               ; creating color strings
      ;terraform
      ;tmux              ; an API for interacting with tmux
      ;upload            ; map local to remote projects via ssh/ftp
      ;wakatime
      ;vterm

       :lang
      ;assembly          ; assembly for fun or debugging
      ;(cc +irony +rtags); C/C++/Obj-C madness
      ;clojure           ; java with a lisp
      ;common-lisp       ; if you've seen one lisp, you've seen them all
      ;crystal           ; ruby at the speed of c
      ;csharp            ; unity, .NET, and mono shenanigans
       data              ; config/data formats
      ;erlang            ; an elegant language for a more civilized age
      ;elixir            ; erlang done right
       elm               ; care for a cup of TEA?
       emacs-lisp        ; drown in parentheses
      ;ess               ; emacs speaks statistics
      ;go                ; the hipster dialect
      ;(haskell +intero) ; a language that's lazier than I am
      ;hy                ; readability of scheme w/ speed of python
      ;(java +meghanada) ; the poster child for carpal tunnel syndrome
      ;javascript        ; all(hope(abandon(ye(who(enter(here))))))
      ;julia             ; a better, faster MATLAB
       latex             ; writing papers in Emacs has never been so fun
      ;ledger            ; an accounting system in Emacs
      ;lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
      ;nim               ; python + lisp at the speed of c
      ;nix               ; I hereby declare "nix geht mehr!"
      ;ocaml             ; an objective camel
       (org              ; organize your plain life in plain text
        +attach          ; custom attachment system
        +babel           ; running code in org
        +capture         ; org-capture in and outside of Emacs
        +export)         ; Exporting org to whatever you want
      ; +present         ; Emacs for presentations
      ;perl              ; write code no one else can comprehend
      ;php               ; perl's insecure younger brother
      ;plantuml          ; diagrams for confusing people more
      ;purescript        ; javascript, but functional
       (python           ; beautiful is better than ugly
        +pyenv)
      ;qt                ; the 'cutest' gui framework ever
      ;racket            ; a DSL for DSLs
      ;rest              ; Emacs as a REST client
       (ruby
        +rvm)
       ;+lsp)
      ;rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
      ;scala             ; java, but good
       (sh +zsh)        ; she sells (ba|z)sh shells on the C xor
      ;solidity          ; do you need a blockchain? No.
      ;swift             ; who asked for emoji variables?
      ;web               ; the tubes

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
      ;(email +gmail)    ; emacs as an email client
      ;irc               ; how neckbeards socialize
      ;(rss +org)        ; emacs as an RSS reader
      ;twitter           ; twitter client https://twitter.com/vnought
      ;(write            ; emacs as a word processor (latex + org + markdown)
      ; +wordnut         ; wordnet (wn) search
      ; +langtool)       ; a proofreader (grammar/style check) for Emacs

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
      ;literate

       ;; The default module set reasonable defaults for Emacs. It also provides
       ;; a Spacemacs-inspired keybinding scheme, a custom yasnippet library,
       ;; and additional ex commands for evil-mode. Use it as a reference for
       ;; your own modules.
       (default +bindings +snippets +evil-commands))

;; If a :pre-init / :pre-config hook returns nil, it overwrites that package's
;; original :init / :config block. Exploit this to overwrite Doom's config.

;; (def-package-hook! evil-escape
;;   :pre-config
;;   (global-set-key (kbd "ESC") 'evil-escape)
;;   )

;; `def-package-hook' also has :post-init and :post-config hooks
