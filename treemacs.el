
(require 'ryo-modal)

(use-package treemacs
  :ensure t
  :defer t
  :config
  :ryo
  ("SPC j" treemacs-select-window)
  (progn
    (setq treemacs-width-is-initially-locked nil
	  treemacs-text-scale 0.5))
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(use-package treemacs-projectile
  :ensure t
  :defer t)

(use-package treemacs-all-the-icons
  :ensure t
  :defer t)
