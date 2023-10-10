
(require 'ryo-modal)

(use-package winner
  :ensure t 
  :demand t
  :ryo
  ("3" winner-undo)
  ("4" winner-redo)
  :config
  (winner-mode))
