(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(global-linum-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'dark)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://stable.melpa.org/packages/"))

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.5.1")    ; This may not be appeared if you have already added.
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;(ac-config-default)
(setq ac-delay 0.1) ;; eclipse uses 500ms
;; set default sources
(setq ac-sources
      (append '(ac-source-features
		ac-source-functions
		ac-source-yasnippet
		ac-source-variables
		ac-source-filename
		ac-source-symbols
		ac-source-words-in-same-mode-buffer)
	      ac-sources))
(global-auto-complete-mode t)

;;(setq ac-sources '(ac-source-symbols ac-source-words-in-same-mode-buffers))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;(add-to-list 'load-path "~/emacs.d/elpa/")
(require 'neotree)
(define-key neotree-mode-map (kbd "i") #'neotree-enter-horizontal-split)
(define-key neotree-mode-map (kbd "I") #'neotree-enter-vertical-split)

(require 'powerline)

;;(add-to-list 'load-path "/.emacs.d/elpa/autopair") ;; comment if autopair.el is in standard load path
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'load-path "~/.emacs.d/elpa/sr-speedbar")
(require 'sr-speedbar)

(add-to-list 'load-path "~/.emacs.d/elpa/flymake-python-pyflakes-0.9/")
(add-to-list 'load-path "~/.emacs.d/elpa/flymake-easy-0.10/")
;; Load Flymake
(require 'flymake)
;; Load Flymake-python
(require 'flymake-python-pyflakes)
;; Activate it each time python mode is turned on
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;; Control-c n    next error
(global-set-key (kbd "C-c n") 'flymake-goto-next-error)
;; Control-c p    previous error
(global-set-key (kbd "C-c p") 'flymake-goto-prev-error)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))

;; Display error and warning messages in minibuffer.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.5)
 '(python-shell-buffer-name "Python"))

	;;; jedi completion
	;;; see https://github.com/tkf/emacs-jedi

;; jedi dependency: deferred
(add-to-list 'load-path (expand-file-name
			 "~/.emacs.d/elpa/deferred"))
;; jedi dependency: deferred
(add-to-list 'load-path (expand-file-name
			 "~/.emacs.d/elpa/ctable"))
;; jedi dependency: epc
(add-to-list 'load-path (expand-file-name
			 "~/.emacs.d/elpa/epc"))
(add-to-list 'load-path (expand-file-name
			 "~/.emacs.d/elpa/jedi"))
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

(setq python-python-command "/urs/local/bin/python3")

(autoload 'comint-dynamic-complete-filename "comint" nil t)
(global-set-key "\M-]" 'comint-dynamic-complete-filename)

(setq python-shell-interpreter "python3")
(add-to-list 'load-path "~/.emacs.d/isend-mode")
(require 'isend)

(add-to-list 'load-path "~/.emacs.d/multi-term")
(require 'multi-term)
(setq multi-term-program "/bin/bash")

(add-to-list 'load-path "~/.emacs.d/list-process-plus")
(autoload 'list-processes+ "A enhance list processes command" t)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'smartparens-config)
(add-hook 'js-mode-hook #'smartparens-mode)

(require 'wrap-region)
(setq wrap-region-mode t)

(require 'win-switch)
(win-switch-setup-keys-ijkl "\C-xo" "\C-x\C-o")

