;;; ~/.doom.d/bindings/+deadgrep.el -*- lexical-binding: t; -*-

(map!
 :map deadgrep-mode-map
 :desc "Quit deadgrep" :n "q" (lambda! (quit-window t)))
