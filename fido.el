

(require 'icomplete)
(icomplete-mode 1)
;; show choices vertically
(setq icomplete-separator "|")
(setq icomplete-hide-common-prefix nil)
(setq icomplete-in-buffer t)

(global-set-key (kbd "M-e") #'find-file)
(global-set-key (kbd "M-s") #'imenu-anywhere)
(global-set-key (kbd "M-w") #'switch-to-buffer)
(global-set-key (kbd "M-q") #'ripgrep-regexp)
(global-set-key (kbd "M-a") #'ripgrep-regexp)

(ryo-modal-keys
 ("SPC i"
  (("e" find-file)
   ("r" recentf)
   ("z" yank-pop))))


(define-key icomplete-minibuffer-map (kbd "C-p") 'icomplete-forward-completions)
(define-key icomplete-minibuffer-map (kbd "C-n") 'icomplete-backward-completions)
(define-key icomplete-minibuffer-map (kbd "<tab>") 'icomplete-fido-ret)
;;(fido-mode 1)

(fido-vertical-mode 1)

