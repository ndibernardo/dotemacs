;;; development.el --- Development Tools Configuration -*- mode: emacs-lisp; lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Development tools and IDE features

;;; Code:

(use-package flycheck
  :defer t
  :hook ((prog-mode . flycheck-mode))
  :custom
  (flycheck-emacs-lisp-load-path 'inherit))

(use-package flycheck-clj-kondo)

(use-package dap-mode
  :demand t
  :custom
  (dap-lldb-debug-program '("/opt/homebrew/opt/llvm/bin/lldb-dap"))
  :config
  (require 'dap-lldb)
  (dap-auto-configure-mode)

  ;; For cargo projects specifically
  (dap-register-debug-template
   "Rust::Cargo Debug"
   (list :type "lldb-vscode"
         :initCommands '("command script import ~/.rustup/toolchains/stable-aarch64-apple-darwin/lib/rustlib/etc/lldb_lookup.py"
                         "command source ~/.rustup/toolchains/stable-aarch64-apple-darwin/lib/rustlib/etc/lldb_commands")
         :request "launch"
         :name "Cargo Debug"
         :program "${workspaceFolder}/target/debug/${workspaceFolderBasename}"
         :cwd "${workspaceFolder}"
         :args []
         ;;:preLaunchTask "cargo build"
         ))

  (define-key dap-mode-map (kbd "<f5>") 'dap-debug)
  (define-key dap-mode-map (kbd "<f10>") 'dap-next)
  (define-key dap-mode-map (kbd "<f11>") 'dap-step-in)
  (define-key dap-mode-map (kbd "<f12>") 'dap-step-out)
  (define-key dap-mode-map (kbd "<f9>") 'dap-breakpoint-toggle))

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-modeline-code-actions-enable nil)
  (lsp-semantic-tokens-enable t)
  (lsp-inlay-hint-enable t)
  (lsp-inlay-hints-mode t)
  :config
  (defun corfu-lsp-setup ()
    (setq-local completion-styles '(orderless)
                completion-category-defaults nil))
  :hook (lsp-mode . corfu-lsp-setup))

(use-package lsp-ui
  :custom (lsp-ui-doc-enable nil))

(use-package treemacs
  :demand t
  :custom
  (treemacs-filewatch-mode t)
  (treemacs-follow-mode t)
  (treemacs-no-png-images t)
  (treemacs-text-scale -0.2)
  (treemacs-user-mode-line-format 'none)
  (treemacs-expand-after-init t)
  (treemacs-hide-gitignored-files-mode t)
  :bind (:map treemacs-mode-map
              ([mouse-1] . treemacs-single-click-expand-action)))

(use-package magit
  :bind ("C-x g" . magit-status))

(provide 'development)
;;; development.el ends here
