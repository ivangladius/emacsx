

(use-package helm
  :ensure t
  :demand t
  :ryo
  ("SPC i"
   (("e" helm-find-files)
    ("r" helm-recentf)
	("z" helm-show-kill-ring)))
  ("SPC f"
   (("e" switch-to-buffer)))

  
  :config
  (global-set-key (kbd "M-l") #'helm-occur)
  (global-set-key (kbd "M-a") #'helm-do-grep-ag)
  (global-set-key (kbd "M-s") #'helm-imenu)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (define-key helm-map (kbd "<tab>") #'helm-ff-RET)
  (define-key minibuffer-local-map (kbd "<escape>") #'helm-keyboard-quit)
  (setq helm-split-window-default-side "right")
  (helm-mode))
