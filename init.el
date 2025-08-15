;;; init.el --- Init File -*- mode: emacs-lisp; lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Code:

;;; Early Init Configuration
(defconst font "Triplicate T4c")
(defconst size 140)

;;; Load Path Configuration
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'lib)

;;; Package Management
(require 'package)
(setopt package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

(defvar my-packages
  '(avy
    cider
    cider-eval-sexp-fu
    clj-refactor
    clojure-mode
    consult
    corfu
    dap-mode
    diminish
    docker-compose-mode
    dockerfile-mode
    doom-themes
    exec-path-from-shell
    expand-region
    flycheck
    flycheck-clj-kondo
    gcmh
    git-gutter
    git-gutter-fringe
    lsp-mode
    lsp-ui
    lua-mode
    magit
    marginalia
    multiple-cursors
    orderless
    paredit
    protobuf-mode
    rainbow-delimiters
    rainbow-mode
    rust-mode
    savehist
    slime
    subword
    treemacs
    vertico
    which-key
    yasnippet)
  "List of packages to install.")

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package)))
(require 'diminish)

;;; Core Emacs Configuration
(defalias 'yes-or-no-p 'y-or-n-p)
(setopt compilation-scroll-output t)
(setopt compilation-window-height 15)
(setopt cursor-type 'bar)
(setopt display-line-numbers-width 3)
(setopt split-height-threshold 80)
(setopt temp-buffer-max-height 15)
(setopt temp-buffer-resize-mode t)
(setopt window-divider-default-right-width 1)
(setopt fill-column 100)
(setopt indent-tabs-mode nil)
(setopt tab-width 2)

(setopt display-buffer-alist
        '(("\\*\\(compilation\\|eshell\\|xref\\|cider-repl\\)\\*"
           (display-buffer-reuse-mode-window
            display-buffer-below-selected)
           (window-height . 20))))

(blink-cursor-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(window-divider-mode 1)
(menu-bar-mode 1)
(fringe-mode '(10 . 0))
(delete-selection-mode 1)
(setq-default show-trailing-whitespace t)

(set-face-attribute 'default nil :font font :weight 'normal :height size)

;;; Hooks
(add-hook 'text-mode-hook   #'set-line-spacing)
(add-hook 'prog-mode-hook   #'set-line-spacing)
(add-hook 'text-mode-hook   #'display-line-numbers-mode)
(add-hook 'prog-mode-hook   #'display-line-numbers-mode)
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;;; Path Configuration
(setopt exec-path-from-shell-arguments '("-i"))
(autoload 'exec-path-from-shell-initialize "exec-path-from-shell")
(exec-path-from-shell-initialize)

;; Macos native compilation libraries path
(when (eq system-type 'darwin)
  (setup-macos-native-comp-library-paths))

;;; Garbage Collection
(setopt gcmh-high-cons-threshold (* 32 1024 1024))
(setopt gcmh-idle-delay 5)
(setopt gcmh-verbose nil)
(add-hook 'after-init-hook #'gcmh-mode)
(with-eval-after-load 'gcmh
  (diminish 'gcmh-mode))

;;; Completion Configuration
(require 'orderless)
(setopt completion-styles '(orderless basic))
(setopt completion-category-overrides '((file (styles basic partial-completion))))
(setopt corfu-auto t)
(setopt corfu-cycle t)
(setopt corfu-quit-at-boundary nil)
(setopt corfu-quit-no-match t)

(add-hook 'after-init-hook #'global-corfu-mode)
(add-hook 'after-init-hook #'marginalia-mode)
(add-hook 'after-init-hook #'vertico-mode)
(add-hook 'after-init-hook #'savehist-mode)

(setopt which-key-idle-delay 0.7)
(which-key-mode)
(with-eval-after-load 'which-key
  (diminish 'which-key-mode))

;;; Editing Enhancements

(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'text-mode-hook #'rainbow-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)
(with-eval-after-load 'rainbow-mode
  (diminish 'rainbow-mode))

(add-hook 'after-init-hook #'global-subword-mode)
(with-eval-after-load 'subword
  (diminish 'subword-mode))

(add-hook 'after-init-hook #'yas-global-mode)
(with-eval-after-load 'yasnippet
  (diminish 'yas-minor-mode))

;;; Development Tools
(setopt flycheck-emacs-lisp-load-path 'inherit)
(add-hook 'prog-mode-hook #'flycheck-mode)

(setq-default flycheck-indication-mode 'left-margin)
(add-hook 'flycheck-mode-hook #'flycheck-set-indication-mode)

(add-hook 'prog-mode-hook #'git-gutter-mode)
(require 'git-gutter)
(with-eval-after-load 'git-gutter
  (setq git-gutter:update-interval 0.02)
  (diminish 'git-gutter-mode))

(require 'git-gutter-fringe)
(define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)

;;; Treemacs
(setopt treemacs-filewatch-mode t)
(setopt treemacs-follow-mode t)
(setopt treemacs-no-png-images t)
(setq treemacs-text-scale -0.2)
(setopt treemacs-user-mode-line-format 'none)
(setopt treemacs-expand-after-init t)
(setopt treemacs-hide-gitignored-files-mode t)
(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

;;; LSP Configuration
(setopt lsp-completion-provider :none)
(setopt lsp-headerline-breadcrumb-enable nil)
(setopt lsp-modeline-code-actions-enable nil)
(setopt lsp-semantic-tokens-enable t)
(setopt lsp-inlay-hint-enable t)
(setopt lsp-inlay-hints-mode t)
(setopt lsp-ui-doc-enable nil)

(defun corfu-lsp-setup ()
  "Lsp setup for corfu completion."
  (setq-local completion-styles '(orderless)
              completion-category-defaults nil))
(add-hook 'lsp-mode-hook #'corfu-lsp-setup)

(setopt dap-lldb-debug-program '("/opt/homebrew/opt/llvm/bin/lldb-dap"))
(with-eval-after-load 'dap-mode
  (require 'dap-lldb)
  (dap-auto-configure-mode)
  (dap-register-debug-template
   "Rust::Cargo Debug"
   (list :type "lldb-vscode"
         :initCommands '("command script import ~/.rustup/toolchains/stable-aarch64-apple-darwin/lib/rustlib/etc/lldb_lookup.py"
                         "command source ~/.rustup/toolchains/stable-aarch64-apple-darwin/lib/rustlib/etc/lldb_commands")
         :request "launch"
         :name "Cargo Debug"
         :program "${workspaceFolder}/target/debug/${workspaceFolderBasename}"
         :cwd "${workspaceFolder}"
         :args []))
  (define-key dap-mode-map (kbd "<f5>") #'dap-debug)
  (define-key dap-mode-map (kbd "<f10>") #'dap-next)
  (define-key dap-mode-map (kbd "<f11>") #'dap-step-in)
  (define-key dap-mode-map (kbd "<f12>") #'dap-step-out)
  (define-key dap-mode-map (kbd "<f9>") #'dap-breakpoint-toggle))

;;; Language Modes
(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.edn\\'" . clojure-mode))
(add-hook 'clojure-mode-hook #'lsp)
(add-hook 'clojurescript-mode-hook #'lsp)
(add-hook 'clojurec-mode-hook #'lsp)
(with-eval-after-load 'clojure-mode
  (define-key clojure-mode-map (kbd "<s-return>") #'cider-eval-last-sexp)
  (define-key clojure-mode-map (kbd "<S-s-return>") #'cider-eval-defun-at-point)
  (define-key clojure-mode-map (kbd "<C-s-return>") #'cider-eval-buffer)
  (define-key clojure-mode-map (kbd "<M-.>") #'cider-find-var))

(setopt cider-font-lock-dynamically '(macro core function var deprecated))
(setopt cider-overlays-use-font-lock t)
(setopt cider-prompt-save-file-on-load 'always-save)
(setopt cider-repl-pop-to-buffer-on-connect 'display-only)
(setopt cider-repl-use-clojure-font-lock t)
(setopt cider-repl-use-pretty-printing t)
(setopt cider-use-overlays t)
(setopt nrepl-hide-special-buffers t)
(setopt nrepl-log-messages t)
(setopt nrepl-use-ssh-fallback-for-remote-hosts t)
(add-hook 'cider-repl-mode-hook #'cider-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-interaction-mode-hook #'eldoc-mode)

(setopt cider-eval-sexp-fu-flash-duration 0.2)

(add-hook 'cider-mode-hook #'clj-refactor-mode)
(with-eval-after-load 'clj-refactor
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'lsp-mode)
(add-hook 'rust-mode-hook #'dap-mode)
(add-hook 'rust-mode-hook #'dap-ui-mode)

(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))
(add-hook 'lua-mode-hook #'lsp)

(setopt inferior-lisp-program "sbcl")
(with-eval-after-load 'slime
  (load (expand-file-name "~/.quicklisp/slime-helper.el") :noerror))

(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("docker-compose\\'" . docker-compose-mode))

(with-eval-after-load 'eldoc
  (diminish 'eldoc-mode))


;;; Theme
(defun set-face (face style)
  "Reset a FACE and make it inherit STYLE."
  (set-face-attribute face nil
   :foreground 'unspecified :background 'unspecified
   :family     'unspecified :slant      'unspecified
   :weight     'unspecified :height     'unspecified
   :underline  'unspecified :overline   'unspecified
   :box        'unspecified :inherit    style))

(defface face-critical      '((t :foreground "#ffffff" :background "#ff6347")) "Critical.")
(defface face-error         '((t :foreground "#ff6347")) "Error.")
(defface face-popout        '((t :foreground "#227755")) "Popout.")
(defface face-strong        '((t :weight regular)) "Regular.")
(defface face-actually-bold '((t :weight bold)) "Bold.")
(defface face-salient       '((t :foreground "#006b99")) "Salient.")
(defface face-faded         '((t :foreground "#999999")) "Faded.")
(defface face-subtle        '((t :background "#f0f0f0")) "Subtle.")
(defface face-modeline      '((nil :box (:line-width 1 :color "#d1d1d1"))) "Modeline border.")
(defface face-highlight     '((t :background "#b1d6fd")) "Highlight.")
(defface face-matching      '((t :background "#b1d6fd" :weight bold)) "Matching.")
(defface face-completion    '((t :foreground "#006b99" :weight bold)) "Completion.")

(set-face 'font-lock-comment-face            'face-faded)
(set-face 'font-lock-doc-face                'face-faded)
(set-face 'font-lock-string-face             'face-popout)
(set-face 'font-lock-constant-face           'face-salient)
(set-face 'font-lock-warning-face            'face-popout)
(set-face 'font-lock-function-name-face      'face-strong)
(set-face 'font-lock-variable-name-face      'face-strong)
(set-face 'font-lock-builtin-face            'face-salient)
(set-face 'font-lock-type-face               'face-salient)
(set-face 'font-lock-keyword-face            'face-actually-bold)
(set-face 'custom-set                        'face-salient)
(set-face 'minibuffer-prompt                 'face-salient)
(set-face 'mode-line                         'face-modeline)
(set-face 'highlight                         'face-highlight)
(set-face 'region                            'face-highlight)
(set-face 'show-paren-match                  'face-matching)
(set-face 'completions-common-part           'face-completion)
(set-face 'orderless-match-face-0            'face-completion)
(set-face 'error                             'face-error)
(set-face 'success                           'face-popout)

;;; Key Bindings
;; Basic navigation and editing
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)
(global-set-key (kbd "<s-up>") #'beginning-of-buffer)
(global-set-key (kbd "<s-down>") #'end-of-buffer)
(global-set-key (kbd "<s-left>") #'smart-beginning-of-line)
(global-set-key (kbd "C-a") #'smart-beginning-of-line)
(global-set-key (kbd "<s-right>") #'move-end-of-line)
(global-set-key (kbd "s-+") #'text-scale-increase)
(global-set-key (kbd "s--") #'text-scale-decrease)
(global-set-key (kbd "<M-up>") #'backward-paragraph)
(global-set-key (kbd "<M-down>") #'forward-paragraph)
(global-set-key (kbd "M-<backspace>") #'backward-kill-word)
(global-set-key (kbd "M-f") #'beginning-of-next-word)
(global-set-key (kbd "<M-right>") #'beginning-of-next-word)
(global-set-key (kbd "s-w") #'kill-this-buffer)
(global-set-key (kbd "s-a") #'mark-whole-buffer)
(global-set-key (kbd "s-c") #'kill-ring-save)
(global-set-key (kbd "s-v") #'yank)
(global-set-key (kbd "S-s") #'save-buffer)
(global-set-key (kbd "s-l") #'goto-line)
(global-set-key (kbd "s-z") #'undo)
(global-set-key (kbd "s-/") #'comment-or-uncomment-region)
(global-set-key (kbd "M-c") nil)
(global-set-key (kbd "s-x") nil)

;; Editing enhancements
(global-set-key (kbd "C-.") #'avy-goto-word-1)
(global-set-key (kbd "C-=") #'er/expand-region)
(global-set-key (kbd "C-+") #'er/contract-region)
(global-set-key (kbd "C-,") #'mc/edit-lines)
(global-set-key (kbd "C->") #'mc/mark-next-like-this)
(global-set-key (kbd "C-<") #'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") #'mc/mark-all-like-this)

;; Development tools
(global-set-key (kbd "C-x g") #'magit-status)
(global-set-key (kbd "C-x C-g") #'magit-status)

;;; init.el ends here
