;;; bindings/+consult.el -*- lexical-binding: t; -*-

(defun valrus/consult-ripgrep-with-param (param)
  (let ((consult-ripgrep-args
         (replace-regexp-in-string
          "^rg" (concat "rg " param)
          consult-ripgrep-args t t)))
    (consult-ripgrep)))

(map!
 (:leader
  (:prefix "/"
   ;; this shadows +lookup/synonyms, which no thanks
   :desc "Search excluding tests" :n "T"
   (cmd! (valrus/consult-ripgrep-with-param "-g !*_test.py -g !*.test.*")))))
