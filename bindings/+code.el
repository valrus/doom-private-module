;;; +code.el --- Bindings for code modifications.    -*- lexical-binding: t; -*-

(defun valrus/rb-replace-hash-format ()
  (interactive)
  (evil-ex "%s/:\(\w+\) =>/\1:/g"))

(map!
 :leader
 :map (haml-mode-map
       web-mode-map)
 "m" nil)

(map!
 :localleader
 :map (haml-mode-map
       web-mode-map)
 "r" nil
 (:prefix "r"
  :nv "h" #'valrus/rb-replace-hash-format))

(map!
 (:prefix "z"
  :desc "Fold top level" :n [return] #'hs-hide-all
  :desc "Toggle hiding" :n "SPC" #'hs-toggle-hiding))

(map!
 :map python-mode-map
 (:prefix "z"
  :desc "Fold class" :n "C" #'hs-hide-level))
