
(add-to-list 'load-path "~/.emacs.d/lsp-bridge")

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)
(global-lsp-bridge-mode)

(ryo-modal-major-mode-keys
 'lsp-bridge-mode
 ("g"
  (("d" lsp-bridge-find-def)
   ("D" lsp-bridge-find-def-other-window)
   ("i" lsp-bridge-find-impl)
   ("I" lsp-bridge-find-impl-other-window)
   ("r" lsp-bridge-find-references)
   ("o" xref-quit-and-pop-marker-stack))))
