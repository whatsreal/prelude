;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(org-agenda-files (quote ("~/Dropbox/org/organizer.org")))
;;  '(package-selected-packages
;;    (quote
;;     (markdown-mode zop-to-char zenburn-theme which-key web-mode volatile-highlights vkill undo-tree smex smartrep smartparens smart-mode-line rainbow-mode rainbow-delimiters ov operate-on-number move-text magit key-chord json-mode js2-mode imenu-anywhere ido-ubiquitous helm-projectile helm-descbinds helm-ag guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck flx-ido expand-region exec-path-from-shell elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux company-auctex company-anaconda cdlatex browse-kill-ring beacon anzu ace-window))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.v
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

;; Require Helm everyhwere

(require 'prelude-helm-everywhere)


 ;; Org setup note different files.
(setq org-mobile-directory "~/Dropbox/org")
(setq org-directory "~/Dropbox/org/")
(setq org-default-notes-file "~/Dropbox/org/.notes")
(setq org-todo-keywords
       '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(x)")))

 ;; Org auto indent
(setq org-startup-indented 1)


 ;; Org-mode Capture setup requirements
(global-set-key "\C-cr" 'org-capture)
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/Dropbox/org/organizer.org" "Tasks")
         "** TODO %? %^g\n")
        ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
         "* %^{Short Heading}\n %?\n %i\n %a\n")
        ("b" "Book" entry (file+olp "~/Dropbox/org/books.org" "General Books")
         (file "~/Dropbox/org/templates/booktemp.txt"))))

 ;; Setup my custom agendas
(setq org-agenda-custom-commands
'(("o" "Office View" tags-todo "work") ;; all work projects
  ("p" "Personal" ;; selects personal, family, and church tags.
   ((tags-todo "personal")
    (tags-todo "church")
    (tags-todo "family")))))

;; Integrate org mode with RefTeX
(defun my-org-mode-setup ()
  (when (and (buffer-file-name)
             (file-exists-p (buffer-file-name)))
    (load-library "reftex")
    (and (buffer-file-name)
         (file-exists-p (buffer-file-name))
         (reftex-parse-all))
    (reftex-set-cite-format
     '((?b . "[[bib::%l]]")
       (?n . "[[note::%l]]"))))
  (define-key org-mode-map "\C-c\C-g" 'reftex-citation)
  )
(add-hook 'org-mode-hook 'my-org-mode-setup)
(add-hook 'org-mode-hook 'turn-on-auto-fill)



 ;; Integrating BibTeX into my captured books.org file
(defun add-bibliographic-data ()
  ; this is a bit hacky: we detect the AUTHOR property, and create bibtex entries if
  ; it is present
  (message "optionally adding bibliographic data")
  (if (and (org-entry-get (point) "AUTHOR")
           (y-or-n-p "Add bibliographic data? "))
      ; with prefix arg to get all fields:
      (org-bibtex-create-in-current-entry 1)
    nil))

(add-hook 'org-capture-before-finalize-hook (lambda ()
(add-bibliographic-data)))


 ;; the settings for the google translate interface.
 ;; I am using the google-translate.el in this dir.

 ;; (require 'google-translate)
(global-set-key "\C-xt" 'google-translate-at-point)
(global-set-key "\C-xT" 'google-translate-query-translate)
(setq google-translate-default-target-language "en")
(setq google-translate-default-source-language "de")

 ;; Setup for reftex

(setq reftex-bibpath-environment-variables
'("/Users/danielfleming/Dropbox/Academic/Resources/bibrsrc/general.bib"))
(setq reftex-default-bibliography '("/Users/danielfleming/Dropbox/Academic/Resources/bibrsrc/general.bib"))
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

(setq reftex-default-bibliography
      (quote
       ("user.bib" "local.bib" "main.bib")))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; Make RefTeX faster
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-cite-prompt-optional-args "maybe")

(eval-after-load 'reftex-vars
  '(progn
     ;; (also some other reftex-related customizations)
     (setq reftex-cite-format
           '((?\C-m . "\\cite[]{%l}")
             (?f . "\\footcite[][]{%l}")
             (?t . "\\textcite[]{%l}")
             (?p . "\\parencite[]{%l}")
             (?o . "\\citepr[]{%l}")
             (?n . "\\nocite{%l}")))))


 ;; For Bibtex
(setq TeX-PDF-mode t)
(setq TeX-parse-self t)
(setq TeX-style-private "~/.emacs.d/personal/mystyles")



;; Turn on Auto Fill Mode for all text
(add-hook 'text-mode-hook 'turn-on-auto-fill)

'(provide custom)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode helm-ag helm-descbinds helm-projectile helm geiser company-anaconda anaconda-mode company-auctex cdlatex auctex json-mode js2-mode rainbow-mode elisp-slime-nav rainbow-delimiters company counsel swiper zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smex smartrep smartparens projectile operate-on-number move-text markdown-mode magit ivy imenu-anywhere ido-completing-read+ hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck flx-ido expand-region exec-path-from-shell editorconfig easy-kill discover-my-major diminish diff-hl crux browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; add inline todo items
(require 'org-inlinetask)
