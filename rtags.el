(require 'rtags)

(use-package cmake-ide
  :ensure t)

(cmake-ide-setup)
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

(use-package rtags
  :ensure t
  :hook (c++-mode . rtags-start-process-unless-running)
  :config (setq rtags-completions-enabled t
		rtags-path "/home/manoj/.emacs.d/rtags/src/rtags.el"
		rtags-rc-binary-name "/home/manoj/.emacs.d/rtags/bin/rc"
;;		rtags-use-helm t
		rtags-rdm-binary-name "/home/manoj/.emacs.d/rtags/bin/rdm")
  :bind (("C-c E" . rtags-find-symbol)
  	 ("C-c e" . rtags-find-symbol-at-point)
  	 ("C-c O" . rtags-find-references)
  	 ("C-c o" . rtags-find-references-at-point)
  	 ("C-c s" . rtags-find-file)
  	 ("C-c v" . rtags-find-virtuals-at-point)
  	 ("C-c F" . rtags-fixit)
  	 ("C-c f" . rtags-location-stack-forward)
  	 ("C-c b" . rtags-location-stack-back)
  	 ("C-c n" . rtags-next-match)
  	 ("C-c p" . rtags-previous-match)
  	 ("C-c P" . rtags-preprocess-file)
  	 ("C-c R" . rtags-rename-symbol)
  	 ("C-c x" . rtags-show-rtags-buffer)
  	 ("C-c T" . rtags-print-symbol-info)
  	 ("C-c t" . rtags-symbol-type)
  	 ("C-c I" . rtags-include-file)
  	 ("C-c i" . rtags-get-include-file-for-symbol)))

;;(setq rtags-display-result-backend 'helm)

