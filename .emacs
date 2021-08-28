(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(global-linum-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; ;; open agenda in current window
;; (setq org-agenda-window-setup 'current-window)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;;Persistent Scratch Buffer
;; Source : https://dorophone.blogspot.fr/2011/11/how-to-make-emacs-scratch-buffer.html

(defvar persistent-scratch-filename
  "~/.emacs-persistent-scratch"
  "Location of *scratch* file contents for persistent-scratch.")

(defun save-persistent-scratch ()
  "Write the contents of *scratch* to the file name
  PERSISTENT-SCRATCH-FILENAME, making a backup copy in
  PERSISTENT-SCRATCH-BACKUP-DIRECTORY."
  (with-current-buffer (get-buffer "*scratch*")
    (write-region (point-min) (point-max)
		  persistent-scratch-filename)))

(defun load-persistent-scratch ()
  "Load the contents of PERSISTENT-SCRATCH-FILENAME into the
  scratch buffer, clearing its contents first."
  (if (file-exists-p persistent-scratch-filename)
      (with-current-buffer (get-buffer "*scratch*")
	(delete-region (point-min) (point-max))
	(shell-command (format "cat %s" persistent-scratch-filename) (current-buffer))))
  )

(load-persistent-scratch)

(push #'save-persistent-scratch kill-emacs-hook)

(use-package shell
  :commands shell
  :bind
  (:map shell-mode-map
        ("TAB" . 'company-complete))
  )

(use-package company
  :init
  (setq company-idle-delay nil
        company-tooltip-align-annotations t)
  :bind (("C-c q" . company-complete)
	 :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :config
  (global-company-mode t)
  (progn
    (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle))
  (progn
    (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous))
  )

(use-package whitespace
  :diminish (global-whitespace-mode
             whitespace-mode
             whitespace-newline-mode)
  :config
  (progn
    (setq whitespace-style '(trailing face))
    (global-whitespace-mode))
  (add-hook 'after-save-hook 'whitespace-cleanup)
  )

;; windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Multiple cursors
(use-package multiple-cursors
  :init (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

;;Helm Mode
(use-package helm
  :ensure t
  :demand
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         ("C-x c o" . helm-occur)) ;SC
  ("M-y" . helm-show-kill-ring) ;SC
  ("C-x r b" . helm-filtered-bookmarks) ;SC
  :preface (require 'helm-config)
  :init (setq helm-split-window-in-side-p t) ; open helm buffer inside current window, not occupy whole other window
  (setq helm-move-to-line-cycle-in-source t) ; move to end or beginning of source when reaching top or bottom of source.
  (setq helm-scroll-amount 8) ; scroll 8 lines other window using M-<next>/M-<prior>
  (setq helm-ff-file-name-history-use-recent t)
  :config  (helm-mode 1)
  )

;; YaSnippet
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1)
  )

;; Autopair
(use-package autopair
  :ensure t
  :config (autopair-global-mode 1)
  )

;;Indent
(setq js-indent-level 2)
(setq python-indent-level 2)
(setq c++-indent-level 2)

;;Show Paren Mode On
(show-paren-mode 1)
(setq show-paren-delay 0)
(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#FFF400")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-super-agenda git-gutter+ snakemake-mode graphviz-dot-mode vue-html-mode vue-mode helm-bibtex auctex company-jedi company-shell helm-company helm-proc ggtags shell-current-directory multiple-cursors autopair git-gutter magit solarized-theme helm-lsp lsp-ui exec-path-from-shell flycheck pyenv-mode use-package poly-R polymode ess helm lsp-mode typescript-mode))
 '(python-shell-interpreter "python3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'solarized-dark t)

(setq bash-completion-nospace t)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-copy-env "HOMEBREW_NO_AUTO_UPDATE")
  (exec-path-from-shell-copy-env "BASH_SILENCE_DEPRECATION_WARNING")
  (exec-path-from-shell-copy-env "PS1")
  (exec-path-from-shell-copy-env "parse_git_branch")
  (exec-path-from-shell-copy-env "parse_git_dirty")
  (exec-path-from-shell-initialize))

(use-package pyenv-mode
  :init
  (add-to-list 'exec-path "~/.pyenv/shims")
  (setenv "WORKON_HOME" "~/.pyenv/versions/")
  :config
  (pyenv-mode)
  :bind
  ("C-x p e" . pyenv-activate-current-project))

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode)
  (with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers '(xml-xmlstarlet xml-xmllint)))
  )

;; lsp-mode
(use-package lsp-ui)
(setq lsp-keymap-prefix "s-l")
(use-package lsp-mode
  :hook ((python-mode . lsp))
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)

;; Set default font
(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 110
                    :weight 'normal
                    :width 'normal)

;; Magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; ggtags
(use-package ggtags
  :ensure t
  :commands ggtags-mode
  :config
  (unbind-key "M-<" ggtags-mode-map)
  (unbind-key "M->" ggtags-mode-map))

(use-package cc-mode
  :ensure nil
  :config
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
                (ggtags-mode 1)))))

(use-package git-gutter+
  :ensure t
  :init (global-git-gutter+-mode)
  :config (progn
            (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
            (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
            (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
            (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
            (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
            (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer))
  :diminish (git-gutter+-mode . "gg"))

(use-package helm
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  :demand t
  :bind (("M-x" . helm-M-x)
	 ("C-c h o" . helm-occur)
	 ("<f1> SPC" . helm-all-mark-rings) ; I modified the keybinding
	 ("M-y" . helm-show-kill-ring)
	 ("C-c h x" . helm-register)    ; C-x r SPC and C-x r j
	 ("C-c h g" . helm-google-suggest)
	 ("C-c h M-:" . helm-eval-expression-with-eldoc)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini)      ; *<major-mode> or /<dir> or !/<dir-not-desired> or @<regexp>
	 :map helm-map
	 ("<tab>" . helm-execute-persistent-action) ; rebind tab to run persistent action
	 ("C-i" . helm-execute-persistent-action) ; make TAB works in terminal
	 ("C-z" . helm-select-action) ; list actions using C-z
	 :map shell-mode-map
	 ("C-c C-l" . helm-comint-input-ring) ; in shell mode
	 :map minibuffer-local-map
	 ("C-c C-l" . helm-minibuffer-history))
  :init
  (setq helm-command-prefix-key "C-c h")
  (setq recentf-save-file "~/.emacs.d/misc/recentf"
	recentf-max-saved-items 50)
  :config
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match    t)
  (setq helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match    t)
  (setq helm-locate-fuzzy-match t)
  (setq helm-apropos-fuzzy-match t)
  (setq helm-lisp-fuzzy-completion t)
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
  (require 'helm-config)
  (setq helm-split-window-in-side-p         t ; open helm buffer inside current window, not occupy whole other window
	helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
	helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
	helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
	helm-ff-file-name-history-use-recentf t
	helm-echo-input-in-header-line t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (helm-mode 1)
  )

;; eDiff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; Make TeX-command-extra-options safe
(with-eval-after-load 'tex
  (add-to-list 'safe-local-variable-values
               '(TeX-command-extra-options . "-shell-escape")))

;; HELM bibtex
(use-package helm-bibtex
  :ensure t
  :init
  (autoload 'helm-bibtex "helm-bibtex" "" t)
  :config
  (require 'helm)
  (setq bibtex-completion-bibliography
	'("/Users/karthik/Documents/zotero_library.bib"))
  (helm-add-action-to-source
   "Insert citations" 'bibtex-completion-insert-citation
   helm-source-bibtex)
  )

;; Agenda
(setq org-agenda-files '("~/org-tasks"))
(setq org-super-agenda-groups
      '((:auto-group t))
      )
(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

;;Opening emacs window
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")
(split-window-horizontally)
(other-window 1)
(add-hook 'after-init-hook 'org-agenda-list)
(switch-to-buffer "*Org Agenda*")
(split-window-vertically)
(switch-to-buffer "*scratch*")
(other-window 1)
