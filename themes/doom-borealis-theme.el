;;; doom-borealis-theme.el --- Doom theme based on borealis -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;;; Commentary:
;;
;; A Doom theme inspired by the James Trunk's Borealis color palette.
;; https://github.com/Misophistful/borealis-cursive-theme
;;
;;; Code:

(require 'doom-themes)

;;; Variables

(defgroup doom-borealis-theme nil
  "Options for the `doom-borealis' theme."
  :group 'doom-themes)

(defcustom doom-borealis-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-borealis-theme
  :type 'boolean)

(defcustom doom-borealis-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-borealis-theme
  :type 'boolean)

(defcustom doom-borealis-comment-bg doom-borealis-brighter-comments
  "If non-nil, comments will have a subtle highlight to enhance their
legibility."
  :group 'doom-borealis-theme
  :type 'boolean)

(defcustom doom-borealis-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-borealis-theme
  :type '(choice integer boolean))

;;; Theme definition

(def-doom-theme doom-borealis
  "A dark theme inspired by VSCode Borealis."
  :family 'doom-borealis
  :background-mode 'dark

  ;; name        default   256           16
  ((bg         '("#282C33" "black"       "black"  ))
   (fg         '("#EBECF0" "#ebebeb"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#21252B" "black"       "black"        ))
   (fg-alt     '("#A0A3AC" "#a0a0a0"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#1B1F26" "black"       "black"        ))
   (base1      '("#21252B" "#212121"     "brightblack"  ))
   (base2      '("#272B3B" "#272727"     "brightblack"  ))
   (base3      '("#3D424C" "#3d3d3d"     "brightblack"  ))
   (base4      '("#505562" "#505050"     "brightblack"  ))
   (base5      '("#A0A3AC" "#a0a0a0"     "brightblack"  ))
   (base6      '("#B2B5BE" "#b2b2b2"     "brightblack"  ))
   (base7      '("#C8CAD0" "#c8c8c8"     "brightblack"  ))
   (base8      '("#EBECF0" "#ebebeb"     "white"        ))

   (grey       base4)
   (red        '("#F7B7B7" "#f7b7b7" "red"          ))
   (orange     '("#F7D2B6" "#f7d2b6" "brightred"    ))
   (green      '("#BFEEC5" "#bfeec5" "green"        ))
   (teal       '("#C8FAF2" "#c8faf2" "brightgreen"  ))
   (yellow     '("#EEDDAF" "#eeddaf" "yellow"       ))
   (blue       '("#B2D8FA" "#b2d8fa" "brightblue"   ))
   (dark-blue  '("#5587b3" "#5587b3" "blue"         ))
   (magenta    '("#E7C7F9" "#e7c7f9" "brightmagenta"))
   (violet     '("#D8A4F7" "#d8a4f7" "magenta"      ))
   (cyan       '("#C8FAF2" "#c8faf2" "brightcyan"   ))
   (dark-cyan  '("#A6F8EB" "#a6f8eb" "cyan"         ))

   ;; Face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   base4)
   (selection      base3)
   (builtin        magenta)
   (comments       (if doom-borealis-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-borealis-brighter-comments dark-cyan base5) 0.25))
   (constants      violet) ;;(constants      green)
   (functions      blue)
   (keywords       green)
   (methods        cyan)
   (operators      fg)
   (type           teal);;(type           base8)
   (strings        yellow)
   (variables      fg)
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; Custom variables for this theme
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-borealis-brighter-modeline
                                 (doom-darken dark-blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if doom-borealis-brighter-modeline
                                 (doom-darken dark-blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-borealis-padded-modeline
      (if (integerp doom-borealis-padded-modeline) doom-borealis-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-borealis-comment-bg (doom-lighten bg 0.05) 'unspecified)
    :slant 'italic)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-borealis-brighter-modeline base8 highlight))

   ;; Font lock faces
   (font-lock-keyword-face :foreground keywords)
   (font-lock-type-face :foreground type)
   (font-lock-function-name-face :foreground functions)
   (font-lock-variable-name-face :foreground variables)
   (font-lock-string-face :foreground strings)
   (font-lock-constant-face :foreground constants)
   (font-lock-builtin-face :foreground builtin)
   (font-lock-warning-face :foreground warning)
   (font-lock-negation-char-face :foreground constants)
   (font-lock-preprocessor-face :foreground red)
   (font-lock-preprocessor-char-face :foreground red)
   (font-lock-regexp-face :foreground red)
   (font-lock-regexp-grouping-backslash :foreground red)
   (font-lock-regexp-grouping-construct :foreground red)

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground type)
   (css-selector             :foreground blue)

   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-borealis-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   ;;;; elscreen
   (elscreen-tab-other-screen-face :background base3 :foreground base1)

   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)

   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)

   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground green)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   (markdown-header-delimiter-face :foreground green)
   (markdown-header-rule-face :foreground green)
   (markdown-header-face-1 :foreground green :weight 'bold)
   (markdown-header-face-2 :foreground green :weight 'bold)
   (markdown-header-face-3 :foreground green :weight 'bold)
   (markdown-header-face-4 :foreground green :weight 'bold)
   (markdown-header-face-5 :foreground green :weight 'bold)
   (markdown-header-face-6 :foreground green :weight 'bold)
   (markdown-bold-face :foreground red :weight 'bold)
   (markdown-italic-face :foreground red :slant 'italic)
   (markdown-link-face :foreground blue)
   (markdown-link-title-face :foreground magenta)
   (markdown-url-face :foreground orange)
   (markdown-blockquote-face :foreground blue :slant 'italic)

   ;;;; org-mode
   ;;(org-hide :foreground hidden)
   (org-block :background base2)
   (org-block-begin-line :background base2 :foreground comments)
   (org-block-end-line :background base2 :foreground comments)
   (org-level-1 :foreground green :weight 'bold)
   (org-level-2 :foreground green :weight 'bold)
   (org-level-3 :foreground green :weight 'bold)
   (org-level-4 :foreground green)
   (org-level-5 :foreground green)
   (org-level-6 :foreground green)
   (org-level-7 :foreground green)
   (org-level-8 :foreground green)
   (org-todo :foreground red :weight 'bold)
   (org-done :foreground green :weight 'bold)
   (org-headline-done :strike-through t)
   (org-link :foreground blue :underline t)
   (org-date :foreground cyan)
   (org-code :foreground magenta)
   (org-verbatim :foreground yellow)

   ;;;; rjsx-mode
   (rjsx-tag :foreground magenta)
   (rjsx-attr :foreground orange)

   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt)))

   ;;;; web-mode
   (web-mode-html-tag-face :foreground magenta)
   (web-mode-html-attr-name-face :foreground orange)
   (web-mode-html-attr-value-face :foreground yellow)
   (web-mode-css-selector-face :foreground blue)
   (web-mode-css-property-name-face :foreground type)

   ;;;; js2-mode
   (js2-function-param :foreground fg)
   (js2-function-call :foreground functions)
   (js2-object-property :foreground fg)
   (js2-jsdoc-tag :foreground doc-comments)
   (js2-external-variable :foreground variables)

   ;;;; typescript-mode
   (typescript-jsdoc-tag :foreground doc-comments)
   (typescript-jsdoc-type :foreground doc-comments)
   (typescript-jsdoc-value :foreground doc-comments)

   ;;;; treemacs
   (treemacs-directory-face :foreground fg)
   (treemacs-file-face :foreground fg)
   (treemacs-git-modified-face :foreground vc-modified)
   (treemacs-git-added-face :foreground vc-added)
   (treemacs-git-untracked-face :foreground red)

   (lsp-face-semhl-namespace :foreground type :weight 'normal))

  ;;;; Base theme variable overrides
  ())

;;; doom-borealis-theme.el ends here
