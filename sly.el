
(require 'ryo-modal)

(use-package sly
  :ensure t
  :ryo
  ("SPC o"
   (("e" sly-compile-defun)
    ("i" sly-interrupt)
    ("m" sly-macroexpand-all)
    ("t" sly-toggle-fancy-tree)
    ("s" eval-last-sexp)))
  :config
  (setq inferior-lisp-program "sbcl"))
