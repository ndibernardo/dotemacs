;;; editing.el --- Text Editing Configuration -*- mode: emacs-lisp; lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Text editing enhancements and utilities

;;; Code:

(use-package emacs
  :custom
  (indent-tabs-mode nil)
  (tab-width 2)
  :config
  (delete-selection-mode 1)
  (setq-default show-trailing-whitespace t)
  :hook
  (before-save . delete-trailing-whitespace)
  :bind
  (("<escape>"      . keyboard-escape-quit)
   ("<s-up>"        . beginning-of-buffer)
   ("<s-down>"      . end-of-buffer)
   ("<s-left>"      . smart-beginning-of-line)
   ("C-a"           . smart-beginning-of-line)
   ("<s-right>"     . move-end-of-line)
   ("s-+"           . text-scale-increase)
   ("s--"           . text-scale-decrease)
   ("<M-up>"        . backward-paragraph)
   ("<M-down>"      . forward-paragraph)
   ("M-<backspace>" . backward-kill-word)
   ("M-f"           . beginning-of-next-word)
   ("<M-right>"     . beginning-of-next-word)
   ("s-w"           . kill-this-buffer)
   ("s-a"           . mark-whole-buffer)
   ("s-c"           . kill-ring-save)
   ("s-v"           . yank)
   ("S-s"           . save-buffer)
   ("s-l"           . goto-line)
   ("s-z"           . undo)
   ("s-/"           . comment-or-uncomment-region)
   ("M-c"           . nil)
   ("s-x"           . nil)))

(use-package avy
  :bind (("C-." . avy-goto-word-1)))

(use-package expand-region
  :bind (("C-=" . er/expand-region)
         ("C-+" . er/contract-region)))

(use-package multiple-cursors
  :bind (("C-,"     . mc/edit-lines)
         ("C->"     . mc/mark-next-like-this)
         ("C-<"     . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

(use-package paredit)

(use-package rainbow-delimiters
  :defer t
  :hook (lisp-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :diminish rainbow-mode
  :defer t
  :hook ((text-mode prog-mode) . rainbow-mode))

(use-package subword
  :diminish subword-mode
  :defer t
  :hook (after-init . global-subword-mode))

(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode))

(provide 'editing)
;;; editing.el ends here
