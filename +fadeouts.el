;;; ~/.doom.d/+fadeouts.el -*- lexical-binding: t; -*-
;;; From https://gist.github.com/ivan-krukov/a0b9a7d648d110e53127b4111c86534e

(defcustom mac-animation-duration 0.5
  "Duration of transition animations")
(defvar mac-animation-locked-p nil)
(defun mac-animation-toggle-lock ()
  (setq mac-animation-locked-p (not mac-animation-locked-p)))

(setq mac-animation-duration 0.75)

(defun animate-frame-fade-out (&rest args)
  (unless mac-animation-locked-p
    (mac-animation-toggle-lock)
    (mac-start-animation nil :type 'fade-out :duration mac-animation-duration)
    (run-with-timer mac-animation-duration nil 'mac-animation-toggle-lock)))

;; Fade outs everywhere!
(advice-add 'set-window-buffer :before 'animate-frame-fade-out)
(advice-add 'split-window :before 'animate-frame-fade-out)
(advice-add 'delete-window :before 'animate-frame-fade-out)
(advice-add 'delete-other-windows :before 'animate-frame-fade-out)
(advice-add 'window-toggle-side-windows :before 'animate-frame-fade-out)
