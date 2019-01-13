;;; ~/.doom.d/autoload/valrus.el -*- lexical-binding: t; -*-

(defun display-ansi-colors ()
  (interactive)
  (format-decode-buffer 'ansi-colors))
  ;; (let ((inhibit-read-only t))
  ;;   (ansi-color-apply-on-region (point-min) (point-max))))
