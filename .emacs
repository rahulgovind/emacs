(require 'package) 

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) 

(projectile-global-mode)

(global-auto-revert-mode t)

(require 'ido)
(require 'flx-ido)
(ido-mode t)
(flx-ido-mode 1)
(put 'erase-buffer 'disabled nil)

(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

(load-file "~/.emacs.d/cython-mode.el")
; don't split windows
(setq py-split-windows-on-execute-p t)

(setq py-smart-indentation t)
;-------------------------;
;;; Syntax Highlighting ;;;
;-------------------------;

; text decoration
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(global-hi-lock-mode nil)
(setq jit-lock-contextually t)
(setq jit-lock-stealth-verbose t)

; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode t)

; highlight parentheses when the cursor is next to them
(require 'paren)
(show-paren-mode t)

;-----------------;
;;; Color Theme ;;;
;-----------------;

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai)
(require 'linum-relative)

(add-hook 'html-mode-hook
          (lambda()
	    (smart-tabs-mode t)
	    (smart-tabs-advice sgml-indent-line sgml-basic-offset)
	    (setq sgml-indent-tabs-mode t)
	    (electric-indent-mode t)))

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0)
  (when (member major-mode '(c-mode c++-mode))
    (irony-mode 1)))

(defun my-php-mode-hook ()
  (setq-default indent-tabs-mode nil)
  (setq tab-width 4)
)

(add-hook 'c-mode-hook 'my-c++-mode-hook)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'php-mode-hook 'my-php-mode-hook)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
  (company-mode t)
  (global-set-key (kbd "C-;") 'company-complete-common))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(setq-default tab-width 4)
(smart-tabs-insinuate 'c 'c++)

(c-set-offset 'inline-open '0)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("97084a13605260fbe13aa89c2ababb876014d7d3b63879c69c8439d25ab3fb8f" default)))
 '(package-selected-packages
   (quote
	(php-mode magit yasnippet yaml-mode web-mode use-package smart-tabs-mode relative-line-numbers projectile neotree mmm-mode linum-relative flx-ido fill-column-indicator company-irony color-theme-modern auto-complete adaptive-wrap)))
 '(safe-local-variable-values (quote ((c-basic-offset 4) (eval smart-tabs-mode nil)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Some corrections for UTF
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


(global-visual-line-mode 1)
(require 'adaptive-wrap)
(add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode)

(add-hook 'php-mode-hook (lambda ()
    (defun ywb-php-lineup-arglist-intro (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) c-basic-offset))))
    (defun ywb-php-lineup-arglist-close (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (current-column))))
    (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
    (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

(setq-default web-mode-markup-indent-offset tab-width)
(setq-default web-mode-css-indent-offset tab-width)
(setq-default web-mode-code-indent-offset tab-width)
(setq-default web-mode-sql-indent-offset tab-width)
(setq web-mode-script-padding tab-width)
(setq web-mode-markup-indent-offset tab-width)
