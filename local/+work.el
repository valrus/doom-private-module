;;; ~/.doom.d/local/+work.el -*- lexical-binding: t; -*-

(setq
 so-long-threshold 500

 ;; theme
 doom-theme 'ef-maris-light
 require-final-newline nil)

(add-hook! doom-load-theme
  (set-face-attribute 'mode-line nil :box nil)
  (set-face-attribute 'mode-line-inactive nil :box nil))

(add-hook!
  (python-mode-hook)
  #'format-all-mode)

(setq-hook!
    '(rjsx-mode-hook
      js2-mode-hook
      typescript-tsx-mode-hook
      tsx-ts-mode
      typescript-mode-hook)
  eslint-fix-auto-mode t)

;; Some files have a LOT of errors; use a less resource-intensive highlight mode
(use-package! flycheck
  :defer t
  :config
  (setq-default
   flycheck-error-list-highlight-overlays t
   flycheck-highlighting-mode 'symbols
   flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(use-package! yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode)))

(use-package! git-link
  :defer nil
  :commands (git-link)
  :config
  (map!
   (:leader
    (:prefix "f"
     :desc "Yank git link" :n "g" #'git-link))))

(use-package! rjsx-mode
  :config
  (setq sgml-basic-offset 4)
  (setq js2-basic-offset 4))

;; emacs-mac-port only
;; (mac-auto-operator-composition-mode t)
