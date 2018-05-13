
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
 '(company-clang-arguments (quote ("-I.. -I../include")))
 '(display-battery-mode t)
 '(flycheck-clang-include-path (list "include" "." "../include"))
 '(flycheck-clang-includes nil)
 '(flycheck-clang-language-standard "c++11")
 '(inhibit-startup-screen t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (awk . t) (C . t))))
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "https://marmalade-repo.org/packages/"))))
 '(package-selected-packages
   (quote
    (nord-theme haskell-mode f lsp-rust racer-mode toml-mode yasnippet company evil markdown-mode cargo rust-mode flycheck-rust which-key use-package robe magit latex-preview-pane rainbow-delimiters smex intero counsel irony undo-tree helm)))
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
             :ensure t)

;; -- Comodity stuff
(use-package recentf
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

;; -- Programming stuff
;; Misc

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

;; Rust
(use-package cargo
  :commands cargo-minor-mode
  :hook (rust-mode . cargo-minor-mode)
  :ensure t)

(use-package flycheck-rust
  :ensure t)

(use-package toml-mode
  :mode (("\\.toml\\'" . toml-mode))
  :ensure t)

(use-package rust-mode
    :mode (("\\.rs\\'" . rust-mode))
    :init
    (setq rust-format-on-save t))
;; (use-package lsp-mode
;;     :init
;;     (add-hook 'prog-mode-hook 'lsp-mode)
;;     :config
;;     (use-package lsp-flycheck
;;         :ensure f
;;         :after flycheck)
;;     :ensure t)
;; (use-package lsp-rust
;;   :after lsp-mode
;;   :ensure t)

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
 '(mode-line ((t (:box nil :family "Fira Mono" :height 160)))))


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

;; -- Time logging
(add-hook 'org-clock-in-hook 'save-buffer)
(add-hook 'org-clock-out-hook 'save-buffer)

(find-file-noselect "~/timelog.org")

;; ;; Writing math fast
;; (use-package cdlatex :ensure t)
;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(put 'upcase-region 'disabled nil)
