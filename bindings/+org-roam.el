;;; ~/.doom.d/bindings/+org-roam.el -*- lexical-binding: t; -*-

(map!
 (:map org-mode-map
   (:localleader
     (:prefix ("m" . "org-roam")
       :desc "org-roam" :n "m" #'org-roam
       :desc "today" :n "t" #'org-roam-today
       :desc "find file" :n "f" #'org-roam-find-file
       :desc "insert" :n "i" #'org-roam-insert
       :desc "show graph" :n "g" #'org-roam-show-graph))))
