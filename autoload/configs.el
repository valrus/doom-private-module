;;; ~/.doom.d/autoload/configs.el -*- lexical-binding: t; -*-

;;; Helpers to find per-machine settings
;;;###autoload
(defun local-config-name ()
  (pcase (system-name)
    ("Mac-Studio.local" "mac-home")
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
