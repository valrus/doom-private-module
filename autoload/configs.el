;;; ~/.doom.d/autoload/configs.el -*- lexical-binding: t; -*-

;;; Helpers to find per-machine settings
;;;###autoload
(defun local-config-name ()
  (pcase (system-name)
    ("iMac.local"
     (pcase (user-login-name)
       ("ianbonanza" "imac-work")
       (_ "imac-home")))
    ("Ians-MBP" "macbook")
    ("galliumos" "gallium")
    (_ "default")))

;;;###autoload
(defun local-config-file ()
  (format "+%s.el" (local-config-name)))

;;;###autoload
(defun local-config-work-p ()
  (member (local-config-name) '("imac-work" "macbook")))

;;;###autoload
(defun local-config-home-p ()
  (member (local-config-name) '("imac-home" "gallium")))
