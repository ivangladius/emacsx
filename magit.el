
(require 'ryo-modal)

(use-package magit
  :ensure t
  :ryo
  ("SPC /"
   (("s" magit-status)
    ("c" magit-clone))))
    
