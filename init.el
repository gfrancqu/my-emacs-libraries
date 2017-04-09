;;; init.el --- initiaion file for my lisp librairies-*- lexical-binding: t; -*-

;; Copyright (C) 2017  

;; Author:  Guy @P_TE

;;utilisation des package MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
	     '("gnu" . "http://elpa.gnu.org/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


;; load all libraries 
(add-to-list 'load-path "./lisp")
(load-library "myheader")
(load-library "web-mode")
(load-library "browser-refresh")
(load-library "dockerfile-mode")
(load-library "smali-mode")
(load-library "afternoon-theme")

(unless (package-installed-p "company")
  (package-install "company")
  )

;; auto mode depending on file type
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '(".smali$" . smali-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; custom shortcuts
(global-set-key (kbd "M-s") 'browser-refresh) ; Alt+s


;;theme
(load-theme 'afternoon t)
