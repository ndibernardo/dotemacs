;;; early-init.el --- Early Init File -*- mode: emacs-lisp; lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Early Init File: https://www.gnu.org/software/emacs/manual/html_node/emacs/Early-Init-File.html

;;; Code:

;; Increase garbage collector threshold
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)
(setq file-name-handler-alist nil)

(add-hook 'after-init-hook
  (lambda ()
    ;; Restore default file name handlers
    (setq file-name-handler-alist default-file-name-handler-alist)))

;; Increase the amount of data reads from the process
(setq read-process-output-max (* 1024 1024))

;; Don't compact font caches during GC
(setq inhibit-compacting-font-caches t)

;; Measure sizes in units of pixels
(setq frame-inhibit-implied-resize t)
(setq frame-resize-pixelwise t)
(setq window-resize-pixelwise t)

;; Disable startup messages
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

;; Define frames
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(height . 100) default-frame-alist)
(push '(width  . 200) default-frame-alist)

(when (featurep 'ns)
  (setq frame-title-format '("%b"))
  (setq ns-use-proxy-icon nil)
  (push '(ns-transparent-titlebar . t) default-frame-alist))

;; Set UTF-8 encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Don't use file dialog
(setq use-file-dialog nil)

;; Keep backup files in a dedicated directory
(setq backup-directory-alist
      `((".*" . ,(concat user-emacs-directory "backups")))
      auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; Don't need lockfiles
(setq create-lockfiles nil)
;; Move to trash rather than delete
(setq delete-by-moving-to-trash t)

;; Ignore X
(advice-add #'x-apply-session-resources :override #'ignore)

;; Write customizations in 'custom.el' file
(setq custom-file (locate-user-emacs-file "custom.el"))

;; Less noise when compiling elisp
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))
(setq load-prefer-newer t)
(setq package-enable-at-startup nil)
(setq native-comp-async-jobs-number (max 1 (/ (num-processors) 2)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq native-comp-speed 1)

;;; early-init.el ends here
