
(require 'ryo-modal)

;; (use-package rainbow-delimiters
;;   :ensure t
  
;;   :hook lisp-mode)

(use-package paredit
  :ensure t
  :demand t
  :init
  (add-hook 'lisp-mode-hook #'(lambda ()
				;; (rainbow-delimiters-mode)
				(paredit-mode)))
  
  (add-hook 'emacs-lisp-mode-hook #'(lambda ()
				      ;; (rainbow-delimiters-mode)
				      (paredit-mode)))
  :ryo
  
  (:mode 'lisp-mode)

  ("SPC j"
   (("w" paredit-wrap-sexp)
    ("r" paredit-splice-sexp)))
  
  ("d"
   (("k" paredit-kill)))

  ("M-p" backward-sexp)
  ("M-n" forward-sexp)
  
  ("1" paredit-forward-barf-sexp)
  ("2" paredit-forward-slurp-sexp)
  ("3" paredit-backward-slurp-sexp)
  ("4" paredit-backward-barf-sexp)

  :config
  (paredit-mode))
