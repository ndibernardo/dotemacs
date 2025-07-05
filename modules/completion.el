;;; completion.el --- Completion Configuration -*- mode: emacs-lisp; lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Completion and navigation configuration

;;; Code:

(use-package consult)

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match t)
  :hook (after-init . global-corfu-mode))

(use-package marginalia
  :defer t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package savehist
  :defer t
  :hook (after-init . savehist-mode))

(use-package vertico
  :defer t
  :hook (after-init . vertico-mode))

(use-package which-key
  :diminish which-key-mode
  :custom (which-key-idle-delay 0.7)
  :init   (which-key-mode))

(provide 'completion)
;;; completion.el ends here
