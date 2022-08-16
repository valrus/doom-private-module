;;; ui/nano/config.el -*- lexical-binding: t; -*-

(use-package! nano
  :init
  (setq
   nano-font-size 14
   nano-font-family-proportional nil
   nano-font-family-monospaced "Iosevka Custom")
  :config
  (setq doom-theme nil)

  (require 'disp-table)
  (require 'nano-faces)
  (require 'nano-colors)
  (require 'nano-theme)
  (require 'nano-theme-dark)
  (require 'nano-help)
  (require 'nano-modeline)
  ;; (require 'nano-layout)
  (nano-faces)
  (nano-theme))
