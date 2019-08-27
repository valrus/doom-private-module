;;; Helpers to find per-machine settings
(defun local-config-name ()
  (pcase (system-name)
    ("iMac.local"
     (pcase (user-login-name)
       ("ianbonanza" "imac-work")
       (_ "imac-home")))
    ("Ians-MBP" "macbook")
    ("galliumos" "gallium")
    (_ "default")))

(defun local-config-file ()
  (format "+%s.el" (local-config-name)))

(defun local-config-work-p ()
  (member (local-config-name) '("imac-work" "macbook")))

(defun local-config-home-p ()
  (member (local-config-name) '("imac-home" "gallium")))

