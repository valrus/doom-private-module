;;; ~/.doom.d/bindings/+deadgrep.el -*- lexical-binding: t; -*-

(map!
 (:after deadgrep
  (:map deadgrep-mode-map
   :desc "Quit deadgrep" :n "q" (lambda! (quit-window t))))

 (:after ivy
  (:leader
   (:prefix "/"
    :desc "Search project" :n "/" #'+default/search-project
    :desc "Find with deadgrep" :n "p" #'deadgrep))))
