
;; Initialize files-----------------------
;; Where to find external lisp-files, for modes, etc.
;;(add-to-list 'load-path "~/.emacs.d/elisp/color-theme")
;;----------------------------------------

;; Keep message buffer complete----------
(setq message-log-max t)
;; Remove backup files-------------------
(setq make-backup-files nil)

;; Emacs24 themes------------------------
(when (>= emacs-major-version 24)
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/spolsky")
  (load-theme 'spolsky t)
)

;; Epitech std---------------------------
(load-file "~/.emacs.d/std.el")
(load-file "~/.emacs.d/std_comment.el")
;;---------------------------------------

;; Bar control---------------------------
;; no tool-bar at top
(tool-bar-mode -1)
;; no menu-bar at top
(menu-bar-mode -1)
;; no scroll-bar at side
(scroll-bar-mode -1)
;; show (in left margin) marker for empty line
(setq-default indicate-empty-lines t)

;; Line----------------------------------
;; show line numbers
(line-number-mode t)
;; show column numbers
(column-number-mode t)
;; Set Linum-mode on
(global-linum-mode t)
;; Linum-mode add solid line after the number
(setq linum-format "%4d \u2502 ")

;; One-line commands---------------------
(defalias 'yes-or-no-p 'y-or-n-p)                         ;;answer "y/n rather than "yes/no"
(setq visible-bell t)                                     ;;blink instead of beep
;;(setq inhibit-startup-message t)                          ;;don't show start up message/buffer
(file-name-shadow-mode t)                                 ;;file names in mini buffer
(global-font-lock-mode 1)                                 ;;syntax highlighting
(setq font-lock-maximum-decoration t)                     ;;
(setq frame-title-format '(buffer-file-name "%f" ("%b"))) ;;titlebar=buffer unless filename
;;(setq-default indent-tabs-mode nil)                       ;;use space instead of tab

;; Delete space at the end of each line when saved
(add-hook 'c++-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook 'c-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace t)))
(add-hook 'python-mode-hook '(lambda ()
  (add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
;;---------------------------------------

;; Parenthesis-matching------------------
;; through highlighting------------------
(when (fboundp 'show-paren-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis))
;;---------------------------------------

;; Fontify-------------------------------
;; Hightlight columns longer than 79 lines
;; using whitespace-mode
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)
;;---------------------------------------

;; MELPA install packages----------------
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compartibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;;---------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:foreground "#FFFF00" :background nil)))))
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;)
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(custom-safe-themes (quote ("c5348e323138b655f54b283407426019d931e9727ffff166f7f2e8396aca1ede" default))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("a4368d0d9d25d658dadfcf2933a3e38ff6314e482f541f30b79a25a5990d9c31" "123d0163169764fc51719af26926379ebdfb31969231a9d101c7e3c930d336f2" default))))
