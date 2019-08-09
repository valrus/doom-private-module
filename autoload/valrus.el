;;; ~/.doom.d/autoload/valrus.el -*- lexical-binding: t; -*-

(defun display-ansi-colors ()
  (interactive)
  ;; (format-decode-buffer 'ansi-colors))
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun popup-file (filepath)
  (select-window (display-buffer-in-side-window (find-file-noselect filepath) ())))

(defun popup-todo-file ()
  (interactive)
  (popup-file (concat org-directory "todo.org")))

(defun popup-work-notes ()
  (interactive)
  (popup-file (concat org-directory "work.org")))
