;;; ~/.doom.d/bindings/+ivy.el -*- lexical-binding: t; -*-

(map!
 :map ivy-minibuffer-map
 "C-k" #'ivy-previous-line
 "C-j" #'ivy-next-line
 "C-d" #'ivy-kill-line)
