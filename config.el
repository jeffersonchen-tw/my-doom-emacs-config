;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jefferson Chen"
      user-mail-address "f1jefferson2@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;
(setenv "PYTHONPATH" (shell-command-to-string "$SHELL --login -c 'echo -n $PYTHONPATH'"))

(setq org-roam-directory "~/Documents/Org/roam")

(use-package! org-roam
  :after org
  :commands
  (org-roam-buffer
   org-roam-setup
   org-roam-capture
   org-roam-node-find)
  :config
  :init
  (map!
        :leader
        :prefix ("r" . "org-roam")
        "c" #'org-roam-capture
        "f" #'org-roam-node-find
        "i" #'org-roam-node-insert
        "b" #'org-roam-buffer-toggle
        "t" #'org-roam-tag-add
        "T" #'org-roam-tag-remove)
  :config
  (setq org-roam-mode-section-functions
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            ;; #'org-roam-unlinked-references-section
            ))
  (org-roam-setup))

;; disable confirm message when leave emacs
(setq confirm-kill-emacs nil)
;; startup with fullscreen
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(setq doom-font (font-spec :family "Fira Code" :size 26)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 24))

;; org mode
(after! org
  (setq org-use-speed-commands
        (lambda ()
          (and (looking-at org-outline-regexp)
               (looking-back "^\**")))))
(setq org-hide-emphasis-markers t)
(defun org-toggle-emphasis ()
  "Toggle hiding/showing of org emphasize markers."
  (interactive)
  (if org-hide-emphasis-markers
      (set-variable 'org-hide-emphasis-markers nil)
    (set-variable 'org-hide-emphasis-markers t)))
(setq org-ellipsis "↴")
;; (setq
    ;; org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿")
;; )

(add-hook 'org-mode-hook (lambda ()
   "Beautify Org Checkbox Symbol"
   (push '("[ ]" .  "☐") prettify-symbols-alist)
   (push '("[X]" . "☑" ) prettify-symbols-alist)
   (push '("[x]" . "☑" ) prettify-symbols-alist)
   (push '("[-]" . "❍" ) prettify-symbols-alist)
   (prettify-symbols-mode))
   )
   
(after! org
  (custom-set-faces!
    '(org-document-title :height 1.3)
    '(org-level-1 :inherit outline-1 :weight extra-bold :height 1.4)
    '(org-level-2 :inherit outline-2 :weight bold :height 1.15)
    '(org-level-3 :inherit outline-3 :weight bold :height 1.12)
    '(org-level-4 :inherit outline-4 :weight bold :height 1.09)
    '(org-level-5 :inherit outline-5 :weight semi-bold :height 1.06)
    '(org-level-6 :inherit outline-6 :weight semi-bold :height 1.03)
    '(org-level-7 :inherit outline-7 :weight semi-bold)
    '(org-level-8 :inherit outline-8 :weight semi-bold)
    ;; Ensure that anything that should be fixed-pitch in org buffers appears that
    ;; way
    '(org-block nil :foreground nil :inherit 'fixed-pitch)
    '(org-code nil   :inherit '(shadow fixed-pitch))
    '(org-table nil   :inherit '(shadow fixed-pitch))
    '(org-verbatim nil :inherit '(shadow fixed-pitch))
    '(org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    '(org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    '(org-checkbox nil :inherit 'fixed-pitch)))   
;; log timestamp when TODO items are done
(setq org-log-done 'time)
   
(setq org-roam-graph-executable "/opt/homebrew/bin/dot")
(setq doom-modeline-enable-word-count t)
(setq org-display-remote-inline-images t)
(setq org-startup-with-inline-images t)
(setq org-roam-completion-everywhere t)

(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  (setq org-mind-map-dot-command "/opt/homebrew/bin/dot")
  (setq org-mind-map-unflatten-command "/opt/homebrew/bin/unflatten")
  )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t)))
;; org-tree-slide
(define-key org-mode-map (kbd "<f8>") 'org-tree-slide-mode)
(define-key org-mode-map (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)
(with-eval-after-load "org-tree-slide"
  (define-key org-tree-slide-mode-map (kbd "<f9>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f10>") 'org-tree-slide-move-next-tree)
  )
;; dashboard
;; dashboard icon
(setq fancy-splash-image "~/.emacs.d/images/emacs-gnu-logo.png")
;; default buffer name
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
;; statusbar
(setq doom-modeline-height 15)
(custom-set-faces
  '(mode-line ((t (:family "MesloLGS NF" :height 0.9))))
  '(mode-line-inactive ((t (:family "Noto Sans" :height 0.9)))))
(display-time-mode 1)

;; open window right and bottom
(setq evil-vsplit-window-right t
      evil-split-window-below t)
;; window naviagtion
(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right)
(setq-default major-mode 'org-mode)


;; plantuml
(setq plantuml-jar-path "~/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)

;; company
(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode
    org-mode)
  '(:seperate
    company-ispell
    company-files
    company-yasnippet))
