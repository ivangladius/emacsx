
;; (shell-command "xmodmap ~/.xmodmap")

(let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))



(use-package which-key
  :ensure t
  :config
  (which-key-mode))


(use-package doom-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi t))


;;(global-display-line-numbers-mode 1)
;;(setq display-line-numbers-type 'relative)


(set-face-attribute 'default nil
                    :family "Hack"
                    :height 115
                    :weight 'normal
                    :width 'normal)



(setq inhibit-splash-screen t)
(transient-mark-mode 1)

(setq make-backup-files nil)
(setq auto-save-default nil)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


;; (setq display-line-numbers 'relative)
;; (global-display-line-numbers-mode
 


(setq mode-line-modes
      (mapcar (lambda (elem)
                (pcase elem
                  (`(:propertize (,_ minor-mode-alist . ,_) . ,_)
                   "")
                  (t elem)))
              mode-line-modes))



(display-time-mode 1)


(setq indent-tabs-mode t)
(setq tab-width 4)

(setq dired-listing-switches "-allht")


;; avy

(setq avy-background t)
