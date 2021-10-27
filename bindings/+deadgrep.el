;;; ~/.doom.d/bindings/+deadgrep.el -*- lexical-binding: t; -*-

(map!
 (:after deadgrep
  (:map deadgrep-mode-map
   :desc "Quit deadgrep" :n "q" (cmd! (quit-window t))))

  (:leader
   (:prefix "/"
    :desc "Find with deadgrep" :n "p" #'deadgrep)))
