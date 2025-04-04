;;; +code.el --- Bindings for code modifications.    -*- lexical-binding: t; -*-

(defun valrus/rb-replace-hash-format ()
  (interactive)
  (evil-ex "%s/:\(\w+\) =>/\1:/g"))

(map!
 :leader
 :map (haml-mode-map
       web-mode-map)
 "m" nil)

(map!
 :localleader
 :map (haml-mode-map
       web-mode-map)
 "r" nil
 (:prefix "r"
  :nv "h" #'valrus/rb-replace-hash-format))

(defun valrus/py-fold-class ()
  (interactive)
  (hs-hide-level 2))

(when (local-config-work-p)
  (defalias 'valrus/py-convert-optional-typing
    (kmacro "d i w % i SPC | SPC N o n e <escape> d s ]")))

(defun valrus/search-symbol-forward ()
  (interactive)
  (evil-ex-search-word-forward 1 t))

(defun valrus/search-symbol-backward ()
  (interactive)
  (evil-ex-search-word-backward 1 t))

(map!
 (:map python-mode-map
  :desc "Search symbol forward" :nv "*" #'valrus/search-symbol-forward
  :desc "Search symbol backward" :nv "#" #'valrus/search-symbol-backward
  (:prefix "z"
   :desc "Hide class" :n "C" #'hs-hide-level)
  (:localleader
   :desc "Update Optional syntax" :n "o" #'valrus/py-convert-optional-typing
   (:prefix "t"
    :desc "Run test at point" :n "t" #'python-pytest-run-def-or-class-at-point-dwim))))

(map!
 (:after eglot
         (:leader
          (:prefix "c"
           :desc "Toggle event logging" :n "l" #'valrus/toggle-eglot-event-log))))

(map!
 (:after chatgpt-shell
         (:leader
          (:prefix "c"
           :desc "LLM compose" :n "g" #'chatgpt-shell-prompt-compose))))

(map!
 (:leader
  (:prefix "c"
           (:prefix ("~" . "Change string inflection")
            :desc "snake_case" :nv "s" #'string-inflection-underscore
            :desc "lowerCamelCase" :nv "l" #'string-inflection-lower-camelcase
            :desc "kebab-case" :nv "k" #'string-inflection-kebab-case
            :desc "SCREAMING_SNAKE_CASE" :nv "S" #'string-inflection-upcase
            :desc "CamelCase" :nv "c" #'string-inflection-camelcase))))

(map!
 (:prefix "g"
  :nv "+" #'evil-numbers/inc-at-pt
  :nv "R" #'+lookup/references
  :nv "D" #'valrus/goto-def-ace-window))

(defun valrus/pytest-copy-test-name ()
  (interactive)
  (let ((test-name (format "%s::%s" (buffer-file-name) (python-pytest--current-defun))))
    (print test-name)
    (kill-new test-name)
    (message "Copied %s" test-name)))

(map!
 (:map python-mode-map
  :localleader
  (:prefix "t"
   :desc "Copy test name" :n "c" #'valrus/pytest-copy-test-name)))

(when (local-config-work-p)
  (defun valrus/copilot-change-activation ()
    "Switch between three activation modes:
- automatic: copilot will automatically overlay completions
- manual: you need to press a key to trigger completions
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

  (map!
   ;; explicit copilot complete
   :desc "Copilot complete" :i "M-<return>" #'copilot-complete
   :desc "Copilot activation toggle" "M-<escape>" #'valrus/copilot-change-activation
   ;; accept completion from copilot and fallback to company
   (:map copilot-completion-map
         "M-<right>" #'copilot-accept-completion-by-word
         "M-<down>" #'copilot-accept-completion-by-word
         "M-p" #'copilot-previous-completion
         "M-n" #'copilot-next-completion
         "M-<return>" #'copilot-accept-completion
         "C-g" #'copilot-clear-overlay)))

(map!
 (:prefix "z"
  :desc "open all folds" :n "O" #'+fold/open-all
  :desc "close all folds" :n "C" #'+fold/close-all))

(map!
 :localleader
 "e" nil
 (:prefix "e"
  :nv "b" #'+eval/buffer
  :nv "r" #'+eval:region))
