;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; 
 ;; File Name 		:header-c.el
 ;; Created by		:Guillaume Francqueville
 ;; Creation date	:janvier 12th, 2016
 ;; Last changed by 	:Guillaume Francqueville
 ;; Last change 		:janvier 15th, 2016 08:01
 ;; Description		:fichier pour la création et mis à jour automatique des headers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'autoinsert)
;;variables
(setq authorName "Guillaume Francqueville")

;;pour ajouter la gestion des headers a la création et a la sauvegarde des fichiers
(add-hook 'find-file-hooks 'auto-insert)
(add-hook 'c-mode-hook (lambda () (add-hook 'before-save-hook 'update-header-ensibs)))
(add-hook 'makefile-mode-hook (lambda () (add-hook 'before-save-hook 'update-header-ensibs)))
(add-hook 'html-mode-hook (lambda () (add-hook 'before-save-hook 'update-header-ensibs)))
(add-hook 'php-mode-hook (lambda () (add-hook 'before-save-hook 'update-header-ensibs)))

;;des headers différents pour chaque type de fichiers
(setq auto-insert-alist
      (append '(((c-mode .  "C Mode") . insert-c-header))
	      auto-insert-alist))
(setq auto-insert-alist
      (append '((("[mM]akefile" .  "Make Mode") . insert-makefile-header))
	      auto-insert-alist))
(setq auto-insert-alist
      (append '((("*.php" .  "PHP Mode") . insert-php-header))
	      auto-insert-alist))
(setq auto-insert-alist
      (append '(((html-mode .  "HTML Mode") . insert-html-header))
	      auto-insert-alist))



;;fonction generique pour insérer les header
;;paramètres : prefix du header,
;;             chaine pour debut de block de commentaire,
;;             chaine pour la fin du block de commentaire
(defun insert-header (header-prefix header-comment-start header-comment-stop)
  (insert (concat header-comment-start (make-string 50 (string-to-char header-prefix))))
  (insert (concat "\n " header-prefix " \n "))
  (insert (concat header-prefix " File Name \t\t:"))
  (insert (file-name-nondirectory (buffer-file-name)))
  (insert (concat "\n " header-prefix  " Created by\t\t:"))
  (insert authorName)
  (insert (concat "\n " header-prefix " Creation date\t:"))
  (insert (format-time-string "%B %dth, %Y"))
  (insert (concat "\n " header-prefix  " Last changed by \t:"))
  (insert authorName)
  (insert (concat "\n " header-prefix " Last change \t\t:"))
  (insert (format-time-string "%B %dth, %Y %H:%m"))
  (insert (concat "\n " header-prefix " Description\t\t:"))
  (insert (read-from-minibuffer "Description :"))
  (insert (concat "\n " header-prefix "\n"))
  (insert (concat (make-string 50 (string-to-char header-prefix)) header-comment-stop ))
  )

;; fonction pour l'insertion des headers en C
(defun insert-c-header ()
  "Insert C header"
  (interactive)
  (insert-header "*" "/**" "**/")
  )

;; header html
(defun insert-html-header ()
  "Insert html header"
  (interactive)
  (insert-header "-" "<!--" "-->")
  )

(defun insert-php-header ()
  "insert php header"
  (interactive)
  (insert-header "*" "/**" "**/")
  )

;;fonction pour l'insertion des headers des makefile
(defun insert-makefile-header ()
  "Insert makefile header"
  (interactive)
  (insert-header "#" "##" "##")
  (insert "\n\n#### DEFAULT PARAMETERS ####\n")
  (insert "EXECUTABLE=<Output Executable Name>\n") 
  (insert "SOURCES=<Source1 Source2 .... SourceX>\n")
  (insert "CFLAGS=<OPT1 OPT2 ... OPTX>\n")
  (insert "LDFLAGS=<OPT1 OPT2 ... OPTX>\n")
  (insert "CC=<Compiler>\n") 
  (insert "OBJECTS=$(SOURCES:.c=.o)\n")  
  (insert "\n")
  (insert "#### CUSTOM PARAMETERS ####\n")
  (insert "<NAME>(CAPS LOCK)=your parameters\n")
  (insert "\n")
  (insert "#### DEFAULT TARGETS ####\n")
  (insert "all: $(EXECUTABLE)\n")
  (insert "$(EXECUTABLE): $(OBJECTS)\n")
  (insert "\t$(CC) $(LDFLAGS) $(OBJECTS) -o $(EXECUTABLE)\n")
  (insert "\n\n")
  (insert "clean:\n")
  (insert "\trm $(OBJECTS) $(EXECUTABLE)\n")
  (insert "\n\n")
  (insert "#### CUSTOM TARGET ####\n")
  (insert "<Action Name>:\n")
  (insert "\tAction 1\n")
  (insert "\tAction X\n")
  )

;;mis à jour du header à la sauvegarde
(defun update-header-ensibs ()
  "update header"
  (update-last-change)
  (update-last-changed-by)
  )

;;mis à jour de la date de dernière mise à jour
(defun update-last-change ()
  (goto-line 1)
  (replace-regexp
   "Last change .*:[0-9][0-9]"
   (concat "Last change \t\t:" (format-time-string "%B %dth, %Y %H:%m"))
   )
  )

;;mise à jour de la dernière personne qui a modifier le fichier
(defun update-last-changed-by ()
  (goto-line 1)
  (replace-regexp
   "Last changed by .*:.*[a-z]$"
   (concat "Last changed by \t:" authorName)
   )
  )
