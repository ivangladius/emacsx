
(require 'ryo-modal)


(use-package perspective
  :ensure t		     ; use `:straight t` if using straight.el!
  :demand t
  :ryo
  ("M-1" persp-prev)
  ("M-2" persp-next)
  ("SPC w"
   (("n" persp-switch)
    ("d" persp-kill-current)))
  :config
  (require 'perspective)
  (setq persp-show-modestring 'header)
  (setq persp-suppress-no-prefix-key-warning t)
  
  (defun persp-kill-current ()
    "kill current active perspective"
    (interactive)
    (persp-kill (persp-current-name)))

  (persp-mode))

