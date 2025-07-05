;;; gc.el --- Garbage Collection Configuration -*- mode: emacs-lisp; lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Garbage collection optimization

;;; Code:

(use-package gcmh
  :defer t
  :diminish gcmh-mode
  :custom
  (gcmh-high-cons-threshold (* 32 1024 1024))
  (gcmh-idle-delay 5)
  (gcmh-verbose nil)
  :hook (after-init . gcmh-mode))

(provide 'gc)
;;; gc.el ends here
