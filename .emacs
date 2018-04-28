(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(global-linum-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-whitespace-mode t)

;; Open agenda in current window
(setq org-agenda-window-setup 'current-window)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;Helm Mode
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; (helm-mode 1)

;; (require 'powerline)

;;(add-to-list 'load-path "/.emacs.d/elpa/autopair") ;; comment if autopair.el is in standard load path
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)


(add-to-list 'load-path "~/.emacs.d/elpa/sr-speedbar")
(require 'sr-speedbar)

;;Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(c/c++-clang))

(setq python-python-command "/urs/local/bin/python3")

;; (autoload 'comint-dynamic-complete-filename "comint" nil t)
;; (global-set-key "\M-]" 'comint-dynamic-complete-filename)

(setq python-shell-interpreter "/usr/local/bin/python3")
(add-to-list 'load-path "~/.emacs.d/isend-mode")
(require 'isend)
(add-hook 'isend-mode-hook 'isend-default-shell-setup)
(add-hook 'isend-mode-hook 'isend-default-python-setup)
(setq isend-skip-empty-lines nil)
(setq isend-strip-empty-lines nil)
(setq isend-delete-indentation nil)
(setq isend-end-with-empty-line t)

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

;; (require 'smartparens-config)
;; (add-hook 'js-mode-hook 'smartparens-mode)

(require 'wrap-region)
(setq wrap-region-mode t)

(require 'win-switch)
(global-set-key "\C-xo" 'win-switch-dispatch)
(win-switch-setup-keys-ijkl "\C-xo" "\C-x\C-o")

;; Theme
(load-theme 'solarized-dark t)

;; Smart mode line
;; These two lines are just examples
(setq sml/no-confirm-load-theme t)
(sml/setup)

;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)

;; Don't change the font for some headings and titles
(setq solarized-use-variable-pitch nil)

;; make the modeline high contrast
;; (setq solarized-high-contrast-mode-line t)

(add-to-list 'load-path "~/.emacs.d/shell-current-directory/")
(require 'shell-current-directory)
(put 'erase-buffer 'disabled nil)

;; Org ditaa export
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa

;; Org Mode configuration
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/personal.org"
			     "~/org/toread.org"))

;; Magit shortcuts				;
(global-set-key (kbd "C-x g") 'magit-status)

;;Scratch Mode
(setq initial-major-mode 'org-mode)

;;Graphviz
(load-file "~/.emacs.d/graphviz-dot-mode/graphviz-dot-mode.el") 

;;Render ASCII
(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;;JS Mode
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

;;Indent
(setq js-indent-level 2)
(setq python-indent-level 2)

;;Show Paren Mode On
(show-paren-mode 1)
(setq show-paren-delay 0)
    (require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#FFF400")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;;Org capture
(setq org-default-notes-file "~/org/notes.org")
(define-key global-map "\C-cc" 'org-capture)

;;Grid layout
(defun split-window-multiple-ways (x y)
  "Split the current frame into a grid of X columns and Y rows."
  (interactive "nColumns: \nnRows: ")
  ;; one window
  (delete-other-windows)
  (dotimes (i (1- x))
    (split-window-horizontally)
    (dotimes (j (1- y))
      (split-window-vertically))
    (other-window y))
  (dotimes (j (1- y))
    (split-window-vertically))
  (balance-windows))

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

(org-babel-do-load-languages
'org-babel-load-languages
'((scheme . t)
 (emacs-lisp . t)
 (ruby . t)
 (R . t)
 (python . t)
 (C . t)
 (sh . t)))

;;Show entire debug on error
(setq debug-on-error t)

;;Compile
(defun bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if succeeded without warnings "
  (if (and
       (string-match "compilation" (buffer-name buffer))
       (string-match "finished" string)
       (not
        (with-current-buffer buffer
          (goto-char (point-min))
          (search-forward "warning" nil t))))
      (run-with-timer 1 nil
                      (lambda (buf)
                        (bury-buffer buf)
                        (switch-to-prev-buffer (get-buffer-window buf) 'kill))
                      buffer)))
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

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

;;UUIDGEN
(load-file "~/.emacs.d/uuidgen-el/uuidgen.el") 

;;YaSnippet
(add-hook 'python-mode-hook 'yas-minor-mode)
(add-hook 'js-mode-hook 'yas-minor-mode)
(add-hook 'sh-mode-hook 'yas-minor-mode)
(add-hook 'C++-mode-hook 'yas-minor-mode)
(add-hook 'C-mode-hook 'yas-minor-mode)

;; compile commands
(defun my-c-mode ()
  (setq get-buffer-compile-command
	(lambda (file)
	  (cons (format "gcc -Wall  -o %s %s && ./%s"
			(file-name-sans-extension file)
			file
			(file-name-sans-extension file))
		11))))
(add-hook 'c-mode-hook 'my-c-mode)

(defun my-c++-mode ()
  (setq get-buffer-compile-command
	(lambda (file)
	  (cons (format "g++ -Wall  -o %s %s && ./%s"
			(file-name-sans-extension file)
			file
			(file-name-sans-extension file))
		11))))
(add-hook 'c++-mode-hook 'my-c++-mode)

;; Bitlbee
(load-file "~/.emacs.d/bitlbee.el") 
(require 'bitlbee)

(add-hook 'python-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'js-mode-hook 'company-mode)
(add-hook 'R-mode-hook 'company-mode)
(add-hook 'org-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'sh-mode-hook 'company-mode)

(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))

(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

(setq company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend
        company-preview-frontend
        company-echo-metadata-frontend))

(setq company-require-match 'never)

(setq company-auto-complete t)

;; set default `company-backends'
(setq company-backends
      '((company-files          ; files & directory
         company-keywords       ; keywords
         company-capf
         company-yasnippet
         )
        (company-abbrev company-dabbrev)
        ))


(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(defun my/js-mode-hook ()
  (add-to-list 'company-backends 'company-tern))

(defun my/c++-mode-hook ()
  (add-to-list 'company-backends 'company-irony))

(defun my/R-mode-hook ()
  (add-to-list 'company-backends 'company-ess-backend))

(eval-after-load "shell"
  '(define-key shell-mode-map (kbd "TAB") #'company-complete))


(add-hook 'python-mode-hook 'my/python-mode-hook)
(add-hook 'js-mode-hook 'my/js-mode-hook)
(add-hook 'c++-mode-hook 'my/c++-mode-hook)
(add-hook 'R-mode-hook 'my/R-mode-hook)
(add-hook 'shell-mode-hook #'company-mode)

(setq flycheck-c/c++-gcc-executable "/usr/local/bin/gcc-6")
(setq flycheck-clang-language-standard "c++11")

(global-set-key (kbd "C-c q") 'company-complete)

;; Company color
'(company-template-field ((t (:background ,yellow :foreground ,base02))))
'(company-echo-common ((t (:inherit company-echo :underline t))))
'(company-tooltip ((t (:background ,base02 :foreground ,cyan))))
'(company-tooltip-selection ((t (:background ,cyan-lc :foreground ,cyan-hc))))
'(company-tooltip-mouse ((t (:background ,cyan-hc :foreground ,cyan-lc))))
'(company-tooltip-common ((t (:foreground ,base1 :underline t))))
'(company-tooltip-common-selection ((t (:foreground ,base1 :underline t))))
'(company-tooltip-annotation ((t (:foreground ,base1 :background ,base02))))
'(company-scrollbar-fg ((t (:foreground ,base03 :background ,base0))))
'(company-scrollbar-bg ((t (:background ,base02 :foreground ,cyan))))
'(company-preview ((t (:background ,base02 :foreground ,cyan))))
'(company-preview-common ((t (:foreground ,base1 :underline t))))
'(company-preview-search ((t (:inherit company-preview :slant italic))))


(company-quickhelp-mode 1)
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

;; Remote crontab edit
(defun crontab-e ()
    (interactive)
    (with-editor-async-shell-command "crontab -e"))
;; Docker
;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
;; (setq exec-path (append exec-path '("/usr/local/bin")))
;; ;; Use "docker-machine env box" command to find out your environment variables
;; (setenv "DOCKER_TLS_VERIFY" "1")
;; (setenv "DOCKER_HOST" "tcp://10.11.12.13:2376")
;; (setenv "DOCKER_CERT_PATH" "/Users/karthik/.docker/machine/machines/box")
;; (setenv "DOCKER_MACHINE_NAME" "box")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Tex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (uuidgen markdown-preview-mode polymode yatemplate wrap-region win-switch undo-tree tern-auto-complete stan-snippets solarized-theme snakemake-mode smartparens smart-mode-line-powerline-theme rainbow-mode org-gcal org-bullets org-autolist org-agenda-property org-ac markdown-mode magit js2-refactor jedi image+ ht helm-tramp helm-flycheck gnuplot gitignore-mode git ggtags exec-path-from-shell ess-smart-underscore ess ensime dockerfile-mode docker company-tern company-shell company-quickhelp company-jedi company-irony-c-headers company-irony bash-completion autopair)))
 '(whitespace-line-column 300))

;;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
