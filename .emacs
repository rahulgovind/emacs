(require 'package) 

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) 

(setq package-selected-packages
      '(projectile flx-ido linum-relative smart-tabs-mode adaptive-wrap web-mode magit php-mode rust-mode))
(package-install-selected-packages)

(require 'ido)
(require 'flx-ido)
(ido-mode t)
(flx-ido-mode 1)
(put 'erase-buffer 'disabled nil)


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

(setq-default tab-width 4)
(smart-tabs-insinuate 'c 'c++)

(c-set-offset 'inline-open '0)

(global-visual-line-mode 1)
(require 'adaptive-wrap)
(add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode)

(setq-default web-mode-markup-indent-offset tab-width)
(setq-default web-mode-css-indent-offset tab-width)
(setq-default web-mode-code-indent-offset tab-width)
(setq-default web-mode-sql-indent-offset tab-width)
(setq web-mode-script-padding tab-width)
(setq web-mode-markup-indent-offset tab-width)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("97084a13605260fbe13aa89c2ababb876014d7d3b63879c69c8439d25ab3fb8f" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-c") 'compile)

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'ctrl))


  
