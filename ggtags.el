
(use-package ggtags
  :ensure t
  :ryo
  ("g"
   (("d" ggtags-find-tag-dwim)
    ("o" xref-go-back)
    ("r" ggtags-find-reference)
    ("c" ggtags-create-tags)
    ("0" ggtags-update-tags)
    ("a" ggtags-grep)))
  :config
  (add-hook 'c-mode-common-hook
          (lambda ()
              (ggtags-mode 1))))

