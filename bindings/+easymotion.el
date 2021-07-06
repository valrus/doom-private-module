;;; bindings/+easymotion.el -*- lexical-binding: t; -*-

(map!
 (:prefix "g"
  :desc "Easymotion up" :n [up] #'evilem-motion-previous-line
  :desc "Easymotion down" :n [down] #'evilem-motion-next-line))
