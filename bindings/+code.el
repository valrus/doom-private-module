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

(defun valrus/py-fold-class ()
  (interactive)
  (hs-hide-level 2))

(map!
 :map python-mode-map
 (:prefix "z"
  :desc "Fold class" :n "C" #'hs-hide-level))

(map!
 (:after eglot
         (:leader
          (:prefix "c"
           :desc "Toggle event logging" :n "l" #'valrus/toggle-eglot-event-log))))

(map!
 (:leader
  (:prefix "c"
           (:prefix ("~" . "Change string inflection")
            :desc "snake_case" :nv "s" #'string-inflection-underscore
            :desc "lowerCamelCase" :nv "l" #'string-inflection-lower-camelcase
            :desc "kebab-case" :nv "k" #'string-inflection-kebab-case
            :desc "SCREAMING_SNAKE_CASE" :nv "S" #'string-inflection-upcase
            :desc "CamelCase" :nv "c" #'string-inflection-camelcase))))

(map!
 (:prefix "g"
          :nv "+" #'evil-numbers/inc-at-pt))
