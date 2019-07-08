;;; ~/.doom.d/bindings/+elisp.el -*- lexical-binding: t; -*-

(map!
 :localleader
 :map emacs-lisp-mode-map
 "e" nil
 :nv "x" #'macrostep-expand
 (:prefix "e"
   :nv "e" #'eval-last-sexp))
