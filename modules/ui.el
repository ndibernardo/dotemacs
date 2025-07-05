;;; ui.el --- UI Configuration -*- mode: emacs-lisp; lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; UI configuration including themes, fonts, appearance, and modeline

;;; Code:

(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p)
  :custom
  (compilation-scroll-output t)
  (compilation-window-height 15)
  (cursor-type 'bar)
  (display-buffer-alist
   '(("\\*\\(compilation\\|eshell\\|xref\\|cider-repl\\)\\*"
      (display-buffer-reuse-mode-window
       display-buffer-below-selected)
      (window-height . 20))))
  (display-line-numbers-width 3)
  (split-height-threshold 80)
  (temp-buffer-max-height 15)
  (temp-buffer-resize-mode t)
  (window-divider-default-right-width 1)
  :config
  (blink-cursor-mode 0)
  (column-number-mode 1)
  (show-paren-mode 1)
  (window-divider-mode 1)
  (menu-bar-mode 0)
  (fringe-mode '(0 . 0))
  (setq-default fill-column 100)

  (let ((font (cl-find-if (lambda (f) (find-font (font-spec :name f)))
                          '("Cartograph CF" "Menlo" "Hack" "Input Mono" "TX-02 Medium Condensed"
                            "Fira Code" "PragmataPro Mono Liga" "monospace"))))
  (when font
    (set-face-attribute 'default nil :font font :height 130)))

  (enable-ligatures)

  :hook
  (((text-mode prog-mode) . set-line-spacing)
   ((text-mode prog-mode) . display-line-numbers-mode)))

(use-package doom-themes
  :custom
  (doom-themes-enable-bold nil)
  (doom-themes-enable-italic nil)
  :config
  (load-theme 'doom-borealis t))

(provide 'ui)
;;; ui.el ends here
