(require 'package) 

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) 

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
			 '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq package-selected-packages '(projectile flx-ido
      linum-relative smart-tabs-mode adaptive-wrap web-mode magit
      php-mode rust-mode zenburn-theme org-bullets
      cython-mode ein))
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

; Hack font
(when (eq system-type 'darwin)
      (set-default-font "-*-Hack-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1"))
; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode t)

; highlight parentheses when the cursor is next to them
(require 'paren)
(show-paren-mode t)

;-----------------;
;;; Color Theme ;;;
;-----------------;

;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)
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

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-c") 'compile)

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'ctrl))


;; Change default window size
(setq initial-frame-alist
	  '(
		(width . 180) ;character
		(height . 54) ; lines
		))

;; When using doc-view,
;; make sure page width is the width of the window
(add-hook 'doc-view-mode-hook 'doc-view-fit-width-to-window)

;; Previous and next command in shell
(require 'comint)
(define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") 'comint-next-input)

(require 'ox)

;; Limit to 80
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(setq-default fill-column 80)

(add-hook 'prog-mode-hook 'whitespace-mode)

;; PEP-8
(add-to-list 'load-path "~/.emacs.d/py-autopep8")
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=80"))

(require 'epa-file)
(epa-file-enable)

;; Org-mode pretty bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; Org-mode source blocks
(setq org-src-tab-acts-natively t)

;; Set shortcut for org-mode
(global-set-key (kbd "C-c t") (lambda () (interactive)
								(org-insert-time-stamp (current-time))))
(global-set-key (kbd "C-c l") 'org-store-link)
;; Python autocomplete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-show-menu-immediately-on-auto-complete t)

(require 'jedi)
(setq jedi:complete-on-dot t)
(add-to-list 'ac-sources 'ac-source-jedi-direct)
(add-hook 'python-mode-hook 'jedi:setup)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("97084a13605260fbe13aa89c2ababb876014d7d3b63879c69c8439d25ab3fb8f" default)))
 '(epa-pinentry-mode (quote loopback))
 '(global-visual-line-mode t)
 '(package-check-signature nil)
 '(package-selected-packages
   (quote
	(ox-html5slide elpy djvu mmm-mode ox-twbs multiple-cursors sublimity centered-window-mode ox-reveal wc-mode py-autopep8 company-math cython-mode zenburn-theme markdown-mode projectile flx-ido linum-relative smart-tabs-mode adaptive-wrap web-mode magit php-mode rust-mode)))
 '(scroll-conservatively 10000)
 '(scroll-step 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#3F3F3F")))))

(setq cwm-ignore-buffer-predicates nil)

(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(package-initialize)
(elpy-enable)

; (add-to-list 'load-path "~/.emacs.d/external/org-reveal")
(require 'ox-reveal)
(require 'ox-twbs)
