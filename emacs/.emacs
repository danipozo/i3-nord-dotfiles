
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-auto-complete t)
 '(company-auto-complete-chars (quote (32 95 41 119 46)))
 '(company-clang-arguments (quote ("-I.. -I../include -I. -Iinclude")))
 '(display-battery-mode t)
 '(flycheck-clang-include-path
   (quote
    ("./include" "." "/usr/include/ImageMagick-7" "../include")))
 '(flycheck-clang-includes nil)
 '(flycheck-clang-language-standard "c++11")
 '(flycheck-gcc-include-path (quote ("../include" "." "include")))
 '(flycheck-gcc-includes nil)
 '(inhibit-startup-screen t)
 '(lsp-ui-flycheck-enable t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (C . t))))
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "https://marmalade-repo.org/packages/"))))
 '(package-selected-packages
   (quote
    (company-lsp lsp-ui lsp-mode org-ref evil-org evil-escape py-autopep8 elpy yasnippet-snippets nord-theme haskell-mode f lsp-rust racer-mode toml-mode yasnippet company evil markdown-mode cargo rust-mode flycheck-rust which-key use-package robe magit latex-preview-pane rainbow-delimiters smex intero counsel irony undo-tree helm)))
 '(ring-bell-function (quote ignore))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(word-wrap t))

;; Theme
(use-package nord-theme
             :ensure t)

;; Aspect
(scroll-bar-mode -1)


;; Evil
(use-package evil
  :ensure t
  :init (evil-mode 1))

(define-key evil-ex-map "e" 'helm-find-files)
(define-key evil-ex-map "b" 'helm-mini)
(define-key evil-motion-state-map "j" 'evil-backward-char)
(define-key evil-motion-state-map "ñ" 'evil-forward-char)
(define-key evil-motion-state-map "k" 'evil-next-line)
(define-key evil-motion-state-map "l" 'evil-previous-line)

(use-package evil-escape
  :ensure t
  :init (evil-escape-mode 1))

(setq-default evil-escape-key-sequence "kk")
(setq-default evil-escape-delay 0.2)

(use-package evil-org
  :hook (org-mode . evil-org-mode)
  :ensure t)
  

;; -- Comodity stuff
(use-package recentf
  :ensure t
  :init
  (setq recentf-exclude '("/\\.git/.*\\'"
                          "/elpa/.*\\'"
                          "/cache/.*\\'"
                          ".*\\.gz\\'")
        recentf-max-saved-items 50
        recentf-max-menu-items 35
	recentf-auto-cleanup 'never)
(recentf-mode 1))

(use-package magit
             :ensure t)

(electric-pair-mode 1)

(global-set-key (kbd "C-<tab>") 'dabbrev-expand)

;; -- Programming stuff
;; Misc

(add-hook 'prog-mode-hook 'linum-mode)

(setq-default show-trailing-whitespace t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :ensure t)

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :ensure t)

;; Company
(use-package company
             :ensure t)

;; Yasnippet
(use-package yasnippet
  :commands yas-minor-mode
  :hook (prog-mode . yas-minor-mode)
  :ensure t)

(use-package yasnippet-snippets
  :ensure t)

;; Python
(use-package elpy
  :hook (python-mode . elpy-mode)
  :ensure t)

;;(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode)

(use-package py-autopep8
	      :ensure t
	      :hook (elpy-mode . py-autopep8-enable-on-save))

;; Rust
(use-package cargo
  :commands cargo-minor-mode
  :hook (rust-mode . cargo-minor-mode)
  :ensure t)


(use-package toml-mode
  :mode (("\\.toml\\'" . toml-mode))
  :ensure t)

(use-package rust-mode
    :mode (("\\.rs\\'" . rust-mode))
    :init
    (setq rust-format-on-save t))

(add-hook 'rust-mode-hook 'company-mode)


(use-package lsp-mode
    :ensure t)

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :ensure t)

(use-package lsp-rust
  :after lsp-mode
  :init (setq lsp-rust-rls-command '("rustup" "run" "stable" "rls"))
  :hook (rust-mode . lsp-rust-enable)
  :ensure t)

(use-package company-lsp
  :init (push 'company-lsp company-backends)
  :ensure t)

(use-package flycheck-rust
  :ensure t
  :hook (rust-mode . flycheck-mode))

;; (with-eval-after-load 'lsp-mode
;;   (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
;;   (require 'lsp-rust))

;; Haskell
(use-package haskell-mode
  :mode (("\\.hs\\'" . haskell-mode))
  :ensure t)

;; Smex.
(use-package smex
	     :ensure t
	     :bind (("M-x" . smex)
		    ("M-X" . smex-major-mode-commands)
		    ("C-c C-c M-x" . execute-extended-command))
	     )

;; Replace Emacs undo mode with undo-tree for a better
;; undo system.
(use-package undo-tree
	     :ensure t
	     :config (global-undo-tree-mode)
	     )

;; Hide menu bar
(menu-bar-mode -1)

;; Helm.
(use-package helm
	     :ensure t
	     :config (require 'helm-config)
             :bind (("M-x" . helm-M-x))
	     )

;; which-key
(use-package which-key
	     :ensure t
	     :config (which-key-setup-minibuffer) (which-key-mode)
             :diminish
	     )

;; CDLaTeX
;; (use-package cdlatex
;;              :ensure t)

;; Auto reload files
(global-auto-revert-mode 1)

;; Iosevka font as default, 13.5 pt
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "PfEd" :family "Iosevka"))))
 '(mode-line ((t (:box nil :family "Iosevka" :height 153)))))


;;;; C/C++ stuff
;; Use company in C/C++ buffers
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)

;; Line numbers
(add-hook 'c++-mode-hook 'linum-mode)
(add-hook 'c-mode-hook 'linum-mode)

;; Flycheck
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

;; Rust stuff
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook 'linum-mode)

;; Add hook for intero in haskell-mode
;;(add-hook 'haskell-mode-hook 'intero-mode)


;; Custom key bindings
(global-set-key (kbd "C-j") 'forward-paragraph)
(global-set-key (kbd "C-i") 'backward-paragraph)
(global-set-key (kbd "C-x f") 'recentf-open-files)
(global-set-key (kbd "C-M-v") 'scroll-down)

;; Org stuff

;; -- Math previsualization scale with text
(defun update-org-latex-fragment-scale ()
  (let ((text-scale-factor
         (expt text-scale-mode-step text-scale-mode-amount)))
    (plist-put org-format-latex-options
               :scale (* 1.2 text-scale-factor)))
)
(add-hook
 'text-scale-mode-hook
 'update-org-latex-fragment-scale)

;; ;; Writing math fast
;; (use-package cdlatex :ensure t)
;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(put 'upcase-region 'disabled nil)

(use-package org-ref
  :ensure t)
