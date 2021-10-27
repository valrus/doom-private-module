;;; bindings/+easymotion.el -*- lexical-binding: t; -*-

(map!
 (:prefix "g"
  :desc "Easymotion up" :nv [up] #'evilem-motion-previous-line
  :desc "Easymotion down" :nv [down] #'evilem-motion-next-line))
