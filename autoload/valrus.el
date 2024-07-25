;;; ~/.doom.d/autoload/valrus.el -*- lexical-binding: t; -*-

;;;###autoload
(defun display-ansi-colors ()
  (interactive)
  ;; (format-decode-buffer 'ansi-colors))
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

;;;###autoload
(defun popup-file (filepath)
  (select-window (display-buffer-in-side-window (find-file-noselect filepath) '((side . top)))))

;;;###autoload
(defun popup-todo-file ()
  (interactive)
  (popup-file (concat org-directory "todo.org")))

;;;###autoload
(defun popup-work-notes ()
  (interactive)
  (popup-file (concat org-directory "work.org")))

;;;###autoload
(defun quote-uuids-in-buffer ()
  "Wrap all UUIDs in the current buffer in single quotes"
  (interactive)
  (save-excursion
    (progn
      (goto-char (point-min))
      (while (re-search-forward
              (rx
               (repeat 8 hex-digit)
               "-"
               (repeat 4 hex-digit)
               "-"
               (repeat 4 hex-digit)
               "-"
               (repeat 4 hex-digit)
               "-"
               (repeat 12 hex-digit)) nil t)
        (replace-match "'\\&'")))))

;; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/
(defvar valrus/copilot-manual-mode nil
  "When `t' will only show completions when manually triggered.")

;;;###autoload
(defun valrus/copilot-change-activation ()
  "Switch between three activation modes:
- automatic: copilot will automatically overlay completions
- manual: you need to press a key (M-C-<return>) to trigger completions
- off: copilot is completely disabled."
  (interactive)
  (if (and copilot-mode valrus/copilot-manual-mode)
      (progn
        (message "deactivating copilot")
        (global-copilot-mode -1)
        (setq valrus/copilot-manual-mode nil))
    (if copilot-mode
        (progn
          (message "activating copilot manual mode")
          (setq valrus/copilot-manual-mode t))
      (message "activating copilot mode")
      (global-copilot-mode))))

;;;###autoload
(defun valrus/fix-too-many-open-files ()
  ;; alias since i always forget this function name
  (interactive)
  (file-notify-rm-all-watches))

;; https://karthinks.com/software/emacs-window-management-almanac/#a-window-prefix-command-for-ace-window
;;;###autoload
(defun valrus/ace-window-prefix ()
  "Use `ace-window' to display the buffer of the next command.
The next buffer is the buffer displayed by the next command invoked
immediately after this command (ignoring reading from the minibuffer).
Creates a new window before displaying the buffer.
When `switch-to-buffer-obey-display-actions' is non-nil,
`switch-to-buffer' commands are also supported."
  (interactive)
  (display-buffer-override-next-command
   (lambda (buffer _)
     (let (window type)
       (setq
        window (aw-select (propertize " ACE" 'face 'mode-line-highlight))
        type 'reuse)
       (cons window type)))
   nil "[ace-window]")
  (message "Use `ace-window' to display next command buffer..."))

;;;###autoload
(defun valrus/goto-def-ace-window (identifier)
  (interactive (list (doom-thing-at-point-or-region)))
  (valrus/ace-window-prefix)
  (xref-find-definitions-other-window identifier))
