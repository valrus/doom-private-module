;;; ~/.doom.d/autoload/configs.el -*- lexical-binding: t; -*-

;;; Helpers to find per-machine settings
;;;###autoload
(defun local-config-name ()
  (pcase (system-name)
    ((or "iMac.local" "iMac.lan" "Mac-Studio.local") "mac-home")
    ("Ians-MBP" "macbook")
    ("Ians-MBP.lan" "macbook")
    ("Ians-MacBook-Pro.local" "macbook")
    ("Brutus.local" "macbook")
    ("galliumos" "gallium")
    (_ "default")))

;;;###autoload
(defun local-config-file ()
  (format "+%s.el" (local-config-name)))

;;;###autoload
(defun local-config-work-p ()
  (member (local-config-name) '("mac-work" "macbook")))

;;;###autoload
(defun local-config-home-p ()
  (member (local-config-name) '("mac-home" "gallium")))
