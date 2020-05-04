;;; completion/selectrum/config.el -*- lexical-binding: t; -*-

(use-package! selectrum
  :config
  (selectrum-mode +1)

  (when (featurep! +prescient)
    ;; to make sorting and filtering more intelligent
    (selectrum-prescient-mode +1)

    ;; to save your command history on disk, so the sorting gets more
    ;; intelligent over time
    (prescient-persist-mode +1)))
