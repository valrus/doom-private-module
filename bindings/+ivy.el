;;; ~/.doom.d/bindings/+ivy.el -*- lexical-binding: t; -*-

(map!
 :desc "Search project" :n "/" #'+default/search-project

 :map ivy-minibuffer-map
 "C-k" #'ivy-previous-line
 "C-j" #'ivy-next-line
 "C-d" #'ivy-kill-line
 "C-f" #'ivy-scroll-up-command
 "C-b" #'ivy-scroll-down-command)

(defun ivy-refine (x)
  (refine x))

(ivy-add-actions
 'counsel-set-variable
 '(("r" ivy-refine "refine")))
