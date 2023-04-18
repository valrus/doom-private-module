;;; ~/.doom.d/local/+work.el -*- lexical-binding: t; -*-

(setq
 so-long-threshold 500

 ;; theme
 doom-theme 'ef-spring
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
      typescript-mode-hook)
  eslint-fix-auto-mode t)

(add-to-list 'safe-local-variable-values
 '(lsp-python-ms-extra-paths . "/Users/ianmccowan/Code/external-api/thrift/out/gen-py"))

;; (use-package! format-all
;;   :config
;;   (define-format-all-formatter eslint
;;     (:executable "eslint")
;;     (:install)
;;     (:modes rjsx-mode js2-mode typescript-tsx-mode typescript-mode)
;;     (:format
;;      (format-all--buffer-easy
;;       executable
;;       "--fix-dry-run"
;;       "--stdin"
;;       (when (buffer-file-name)
;;         (list "--output-file" (buffer-file-name))))))
;;   (setq-hook! '(rjsx-mode-hook
;;                 js2-mode-hook
;;                 typescript-tsx-mode-hook typescript-mode-hook) +format-with 'eslint))


;; Some files have a LOT of errors; use a less resource-intensive highlight mode
(use-package! flycheck
  :defer t
  :config
  (setq-default
   flycheck-error-list-highlight-overlays t
   flycheck-highlighting-mode 'symbols
   flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(use-package! thrift-mode
 :demand t
 :config
 (add-to-list 'auto-mode-alist '("\\.thrift\\'" . thrift-mode)))

(use-package! yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode)))

(use-package! git-link
  :defer t
  :commands (git-link)
  :config
  (map!
   (:leader
    (:prefix "f"
     :desc "Yank git link" :n "g" #'git-link))))

(use-package! rjsx-mode
  :config
  (setq auto-mode-alist (delete '("\\.tsx\\'" . typescript-mode) auto-mode-alist))
  (setq sgml-basic-offset 4)
  (setq js2-basic-offset 4)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . rjsx-mode)))

;; emacs-mac-port only
;; (mac-auto-operator-composition-mode t)
