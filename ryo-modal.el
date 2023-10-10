


;;(require 'window)
;;(require 'paredit)
;;(require 'editing)

;; (defun my-ryo-insert-mode ()
;;   (interactive)
;;   (if (boundp ryo-modal-mode)
;;       (ryo-modal-mode -1)))

;; (defun my-ryo-normal-mode ()
;;   (interactive)
;;   (if (not (boundp 'ryo-modal-mode))
;;       (ryo-modal-mode)))

;;(define-global-minor-mode ryo-global-mode ryo-modal-mode
;;  (lambda ()
;;    (unless (or minibufferp (bound-and-true-p eshell-mode)) 
;;      (ryo-modal-mode 1))))
;;

;; remove which key weird symbols


(require 'avy)

(defun my-ryo-global-mode ()
  (if (not (or (active-minibuffer-window) (eq major-mode 'eshell-mode)))
      (ryo-modal-mode 1)))


(use-package ryo-modal
  :ensure t
  :demand t
  :commands ryo-modal-mode
  :init
  (setq ryo-modal-cursor-color "red"
	ryo-modal-default-cursor-color "white")
  
  :config
  (setq ryo-modal-cursor-type 'box)
  (global-set-key (kbd "M-1") #'persp-next)
  (global-set-key (kbd "M-2") #'persp-prev)

  (global-set-key (kbd "<escape>") #'(lambda () (interactive)
								  (ryo-modal-mode 1)))
  (ryo-modal-keys
   ;; ("," ryo-modal-repeat)
   
   ("r" ryo-modal-mode 1)
   ("j" backward-char)
   ("k" next-line)
   ("i" previous-line)
   ("o" forward-char)
   ("e" end-of-line)
   ("a" beginning-of-line)
   ("w" back-to-indentation)
   ("M-p" paredit-forward)
   ("M-n" paredit-backward)

   ("," scroll-down-10)
   ("." scroll-up-10)

   ("M-," my-page-up)
   ("M-." my-page-down)

   ;;(";" end-of-line :exit t)
	   
   ("b" back-to-indentation :exit t)
   ("h" end-of-line :exit t)

   ("M-h" insert-mode-above :exit t)
   ("M-b" insert-mode-below :exit t)

   ("l" isearch-forward)
   ("m" isearch-backward)

   ("c" kill-ring-save)

   
   ("n" backward-word)
   ("p" forward-word)
   ("[" backward-paragraph)
   ("]" forward-paragraph)
   
   ("x" delete-region-or-char)

   ("y" undo)
   ("Y" undo-redo)
   ("z" set-mark-command)

   (";" jump-to-letter-forward)
   ("s" jump-to-letter-backward)
   ("0" avy-goto-char)
   ("9" avy-goto-line)

   ("M-i" forward-global-mark)
   ("M-o" backward-global-mark)

   ("q" paste))

  (ryo-modal-keys
   ("d"
    (("p" kill-word)
     ("n" backward-kill-word)
     ("k" kill-line)
     ("a" kill-whole-line)
     ("v" kill-region)
     ("i" mark-inner-delete)
	 ("o" mark-inner-whole-delete)
	 ("b" delete-content-in-buffer)))
   ("v"
    (("a" xah-select-line)
     ("s" mark-paragraph)
     ("b" mark-whole-buffer)
     ("x" mark-only-content-on-line)
     ("p" mark-forward)
     ("n" mark-backward)
     ("M-p" mark-whole-forward)
     ("M-n" mark-whole-backward)
     ("i" mark-inner)
	 ("o" mark-inner-whole)))
   ("f"
    (("i" mark-inner-delete :exit t)
     ("o" mark-inner-whole-delete :exit t)
     ("k" change-outer :exit t)
     ("l" change-inner :exit t)))
   ("t"
    (("r" avy-copy-region)
     ("e" avy-kill-region)
     ("k" avy-kill-whole-line)
	 ("l" avy-copy-line))))
  
  (ryo-modal-key
   "SPC i"
   '(("d" dired)))

  ;; LAUNCH
  (ryo-modal-key
   "SPC l"
   '(("e" eshell)))
	 
  (ryo-modal-keys
   (:norepeat t)
   ("SPC s" "C-x C-s"))

  (ryo-modal-key
   "SPC"
   '(("1" delete-other-windows)
     ("2" delete-window)
     ("3" split-right)
     ("4" split-below)
     ("-" end-of-buffer)
     ("9" beginning-of-buffer)
     ("m" dired-jump)
     ("k" kill-current-buffer)
     ("<tab>" my-last-buffer)
     ))

  ;; elisp
  (ryo-modal-major-mode-keys
   'emacs-lisp-mode
   ("SPC o"
    (("e" eval-last-sexp)
     ("d" eval-defun)
     ("c" comment-or-uncomment-region))))

  ;; (ryo-modal-major-mode-keys
  ;;  'isearch-mode
  ;;  ("SPC"
  ;;   (("<tab>" isearch-repeat-forward))))
  

  (push '((nil . "ryo:.*:") . (nil . "")) which-key-replacement-alist)
  (ryo-modal-mode 1))

;; (defun my-ryo/mode-line ()
;;   (if (not ryo-modal-mode)
;;       (set-face-attribute 'mode-line nil
;; 			  :foreground "#FFFFFF"
;; 			  :background "#000000")
;;     (set-face-attribute 'mode-line nil
;; 			:foreground "#a52a2a"
;; 			:background "#e1d8b3")))




;; (add-hook 'post-command-hook #'my-ryo/mode-line)
(add-hook 'buffer-list-update-hook 'my-ryo-global-mode)

