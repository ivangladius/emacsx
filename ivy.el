
(require 'ryo-modal)

(use-package smex
  :ensure t)

(use-package imenu-anywhere
  :ensure t
  :defer t)

(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t
	enable-recursive-minibuffers t
	ivy-height 25)
  :ryo
  ("M-s" imenu)
  ("M-a" counsel-ag)
  ("M-x" counsel-M-x)
  ("M-l" swiper)
  ("SPC ]" counsel-yank-pop)
  ("SPC i"
   (("e" counsel-find-file)
    ("r" counsel-recentf)))
  ("SPC f"
   (("e" ivy-switch-buffer)))
  :config
  (ivy-mode)
  (define-key ivy-minibuffer-map (kbd "<tab>") #'ivy-alt-done))


(defun ivan-ivy--list-executables ()
  (let ((executables '()))
    (dolist (file (directory-files "."))
      (and (file-executable-p file) (not (file-directory-p file))
	   (cl-pushnew file executables)))
    executables))

(defun ivan-ivy-valgrind-execute ()
  (interactive)
  (let ((executable (ivan-ivy--list-executables)))
    (async-shell-command (concat "valgrind --leak-check-full --track-origins=yes ./"
				 (ivy-read "executable:"  executable)))))


  
