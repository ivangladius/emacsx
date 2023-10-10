

(defun my-god-mode/normal-mode ()
  (interactive)
  (and (boundp 'god-mode-all) (message "YES")))

(global-set-key (kbd "M-1") #'my-god-mode/normal-mode)

(use-package god-mode
	     :ensure t
	     :demand t
	     :init
	     (setq god-exempt-major-modes nil)
	     (setq god-exempt-predicates nil)
	     :config
	     (global-set-key (kbd "<escape>") #'god-local-mode)
	     (define-key god-local-mode-map (kbd "i") #'god-local-mode)
	     (god-mode))

