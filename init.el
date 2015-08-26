(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

(require 'pallet)
(pallet-mode t)

(require 'ido)
(ido-mode 1)
(setq ido-enable-flex-matching t)

(require 'flx-ido)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)
(setq ido-vertical-show-count t)

(require 'projectile)
(projectile-global-mode)
(setq projectile-require-project-root nil)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'powerline-evil)
(powerline-evil-center-color-theme)

(require 'ag)
(setq ag-highlight-search t)

(require 'ace-jump-mode)
(setq ace-jump-word-mode-use-query-char nil)

;; remove unneeded ui
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq use-dialog-box nil)

;; turn on line numbers
(global-linum-mode t)
(setq linum-format "%4d ")

;; better scrolling
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t)

;; better buffer names for duplicates
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-ignore-buffers-re "^\\*" ; leave special buffers alone
      uniquify-after-kill-buffer-p t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq sentence-end-double-space nil)
(setq echo-keystrokes 0.01)
(setq gc-cons-threshold 10000000)

(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

(setq show-paren-delay 0)
(setq sp-highlight-pair-overlay nil)
(setq sp-highlight-wrap-overlay nil)
(setq sp-highlight-wrap-tag-overlay nil)
(show-paren-mode)

;; turn on electric pair mode & indent mode
(electric-pair-mode)
(electric-indent-mode t)

;; view file info
(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)

;; use soft tabs
(setq-default tab-width 2 indent-tabs-mode nil)

;; make prompts accept y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; no confirmation for non-existent files or buffers
(setq confirm-nonexistent-file-or-buffer nil)

;; disable audible bell
(setq ring-bell-function 'ignore)

;; set the theme
(load-theme 'noctilux t)

;; move into new split windows automatically
(defun lurk-split-window-right ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun lurk-split-window-below ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun lurk-split-edit-init-el ()
  (interactive)
  (lurk-split-window-right)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(defun lurk-split-edit-cask ()
  (interactive)
  (lurk-split-window-right)
  (find-file (expand-file-name "Cask" user-emacs-directory)))

(defun lurk-split-edit-zshrc ()
  (interactive)
  (lurk-split-window-right)
  (find-file "~/.zshrc"))

(defun lurk-load-init-el ()
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(defun lurk-split-buffers ()
  (interactive)
  (list-buffers)
  (other-window 1))

(evil-leader/set-key
  "a"   'ag-project
  "b"   'lurk-split-buffers
  "dk"  'describe-key
  "df"  'describe-function
  "v"   'lurk-split-window-right
  "h"   'lurk-split-window-below
  "w"   'save-buffer
  "q"   'delete-window
  "Q"   'save-buffers-kill-terminal
  "p"   'projectile-find-file
  "ec"  'lurk-split-edit-cask
  "ev"  'lurk-split-edit-init-el
  "ez"  'lurk-split-edit-zshrc
  "sv"  'lurk-load-init-el
  "j" 'ace-jump-word-mode)

(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

(require 'evil)
(evil-mode 1)
(setq evil-move-cursor-back nil)

;; make esc work in most places
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)

;; quick window movement
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "-") 'dired-jump)

;; working with wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; dired commands
(require 'dired+)

;; don't spawn buffers while moving around
(defun lurk-dired-up-directory ()
  (interactive)
  (find-alternate-file ".."))

(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(evil-define-key 'normal dired-mode-map "RET" 'dired-find-alternate-file)
(evil-define-key 'normal dired-mode-map "-" 'lurk-dired-up-directory)
(evil-define-key 'normal dired-mode-map "d" 'dired-create-directory)
(evil-define-key 'normal dired-mode-map "n" 'evil-search-next)
(evil-define-key 'normal dired-mode-map "N" 'evil-search-previous)
(evil-define-key 'normal dired-mode-map "%" 'find-file)

(evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
  'elisp-slime-nav-describe-elisp-thing-at-point)

;; setting up emacs backups
(setq backup-by-copying t
      backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory)))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; turning off auto saves
(auto-save-mode 0)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'ruby-mode)
(require 'inf-ruby)
(require 'ruby-compilation)
(require 'rspec-mode)

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))

(defun lurk-ruby-mode-defaults ()
  (inf-ruby-minor-mode +1)
  (show-paren-mode -1)
  (subword-mode +1)
  (smartparents-mode +1))

(add-hook 'ruby-mode-hook 'lurk-ruby-mode-defaults)

(require 'rbenv)
(global-rbenv-mode)

(require 'elixir-mode)
(require 'alchemist)
