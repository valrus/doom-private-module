;;; ~/.doom.d/bindings/+org-journal.el -*- lexical-binding: t; -*-

(map!
 (:leader
   (:prefix "o"
     (:prefix ("o" . "open org file")
       :desc "Journal entry" :n "j" #'org-journal-new-entry))))
