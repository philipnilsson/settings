;; Supress initial scratch message
(setq initial-scratch-message nil)

(add-to-list 'load-path "~/.emacs.d/c-sharp-mode")
(require 'csharp-mode)


(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-emacs-21)
                      

;; home path via the network
;; (setq network-home-path "\\\\philipnilsson/philipni/AppData/Roaming/")
(defun try-set-font (fonts)
  (if (null fonts) 
      ()
    (let ((font+size (car fonts)))
      (setq font (car font+size)) 
      (setq size (car (cdr font+size)))
      
      (if (null (x-list-fonts font))
	  (try-set-font (cdr fonts) size)
	(set-default-font (concat font " " (int-to-string size)))))))

(set-default-font "Consolas 10")

;; Browse kill-ring

(load "~/.emacs.d/browse-kill-ring.el")
(load "~/.emacs.d/browse-kill-ring+.el")
(require 'browse-kill-ring)
(require 'browse-kill-ring+)

;;(try-set-font '(("Inconsolata" 12) ("Consolas" 11) ("Envy Code R" 11) ("Mono" 11)))

(load "~/.emacs.d/iy-go-to-char.el")
(require 'iy-go-to-char)

(load "~/.emacs.d/key-chord.el")
(require 'key-chord)
(key-chord-mode 1)


;; Mark multiple
(add-to-list 'load-path "~/.emacs.d/mark-multiple")
(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
(global-set-key (kbd "C-c l") 'org-store-link)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-x a r") 'align-regexp)


(key-chord-define-global "qq" 'execute-extended-command)
(key-chord-define-global "qf" 'find-file)
(key-chord-define-global "qo" 'nope)
(key-chord-define-global "ql" 'other-window)
(key-chord-define-global "qw" 'ido-switch-buffer)

(require 'org)

(defun nope ()
  (interactive)
  (message "NOPE"))

(global-set-key (kbd "C-x o") 'nope)

;; key bindings
(global-set-key (kbd "C-c C-h")                 'iy-go-to-char)
(global-set-key (kbd "C-c h")                   'iy-go-to-char-backward)
(global-set-key (kbd "C-c C-c")                 'compile)
(global-set-key (kbd "C-x C-m")                 'execute-extended-command)
(global-set-key (kbd "C-.")                     'repeat)
(global-set-key (kbd "M-.")                     'repeat-complex-command)
(global-set-key (kbd "C-x 3")                   'split-vertically-and-next-buffer)
(global-set-key (kbd "C-x C-r")                 'remember)
(global-set-key (kbd "C-o")                     'split-line)
(global-set-key (kbd "C-=")                     'duplicate-line)
(global-set-key (kbd "C-x ;")                   'comment-or-uncomment-region)
(global-set-key (kbd "C-a")                     'beginning-of-line-alt)
(global-set-key (kbd "C-M-o")                   'nope)
(global-set-key (kbd "C-(")                     'nope)
(global-set-key (kbd "C-x C-k")                 'kill-region)
(global-set-key (kbd "C-w")                     'backward-kill-word)
(global-set-key (kbd "C-x k")                   'kill-this-buffer)
(global-set-key (kbd "M-n")                     'forward-paragraph)
(global-set-key (kbd "M-p")                     'backward-paragraph)
(global-set-key (kbd "M-o")                     'fixup-whitespace)
(global-set-key (kbd "C-c w")                   'clipboard-kill-ring-save)
(progn (global-set-key (kbd "C-c C-m")          'bookmark-jump)
       (define-key org-mode-map (kbd "C-c C-m") 'bookmark-jump))
(progn (global-set-key (kbd "C-x C-m")          'execute-extended-command)
       (define-key org-mode-map (kbd "C-x C-m") 'execute-extended-command))

;; gui
(tool-bar-mode 0)

(scroll-bar-mode 0)
(menu-bar-mode 0)

(transient-mark-mode ())

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(make-backup-file-name-function nil)
 '(make-backup-files nil)
 '(org-return-follows-link t)
 '(org-todo-keywords (quote ((sequence "TODO" "WAITING" "DONE"))))
 '(remember-data-file "~\\.notes.org")
 '(tab-width 4)
 '(truncate-lines t)
 '(yas/indent-line (quote fixed)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-done ((((class color) (min-colors 16) (background dark)) (:foreground "GreenYellow" :weight bold))))
 '(org-level-1 ((t (:inherit outline-1 :foreground "black"))))
 '(org-todo ((((class color) (min-colors 16) (background dark)) (:foreground "salmon" :weight bold)))))

(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t)
	(backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))

(column-number-mode 1)

(defun beginning-of-line-alt ()
  (interactive)
  (if (= 0 (current-column))
      (back-to-indentation)
    (beginning-of-line)))

(defun duplicate-line ()
  (interactive)
  (let ((c (current-column))
	(s (progn (beginning-of-line) (point)))
	(e (progn (end-of-line) (point))))
    (insert "\n")
    (insert-buffer-substring (current-buffer) s e)
    (move-to-column c)))

(recentf-mode 1)
(ido-mode 1)
(toggle-truncate-lines 1)

(set-variable 'ido-enable-flex-matching t)

;; powershell inferior shell is kinda wonky it seems
(autoload 'powershell "powershell" "Start a interactive shell of PowerShell." t)

;; yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; Show matching parens (mixed style)
(show-paren-mode t)
(setq show-paren-delay 0.0)
(setq show-paren-style 'parenthesis)

(set-variable 'visible-bell t)

(defun date (i)
  (interactive "P")
  (shell-command "date +%d%m%y" i))

(defun week(i)
  (interactive "P")
  (shell-command "date +%V" i))

;; colors
(global-hl-line-mode 1)
(set-face-background 'hl-line "#FFffe2")

;; for dark / gnome2 color theme
;; (set-face-background 'hl-line "#103020")
;; (set-face-foreground 'hl-line "#ffffff")


;; yasnippet mode
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(set-variable 'yas/root-directory "~/.emacs.d/yasnippet/snippets")
(global-set-key (kbd "C-<tab>") 'yas/expand)
(add-hook 'text-mode-hook 'yas/minor-mode)

(defun split-vertically-and-next-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  (next-buffer)
  (other-window -1))

(set-variable 'indent-tabs-mode ())

(defun version (ver)
  (interactive "M")
  (message ver)
  (if (not (string= ver ""))
      (shell-command (concat "sd print " (buffer-file-name) "#" ver))
    (shell-command (concat "sd filelog -l " (buffer-file-name)))))
  
(load "~/.emacs.d/haskell-mode/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
 
(put 'scroll-left 'disabled nil)
