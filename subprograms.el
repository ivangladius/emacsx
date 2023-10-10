
(require 'ryo-modal)

(use-package isearch
  :config
  (define-key isearch-mode-map (kbd "<escape>") #'isearch-exit)
  (define-key isearch-mode-map (kbd "M-l") #'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "M-m") #'isearch-repeat-backward))

(defun isearch-my-exit ()
  (interactive)
  (isearch-exit)
  (backward-char))



(use-package disaster
  :ensure t
  :defer t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package auto-sudoedit
  :ensure t
  :demand t

  :config
  (auto-sudoedit-mode 1))

(use-package vterm
  :ensure t)


(defun my/quickrun ()
  (interactive)
  (call-interactively 'save-buffer)
  (quickrun)
  (call-interactively 'ace-window))

(use-package quickrun
  :ensure t
  :config
  (global-set-key (kbd "M-B") #'my/quickrun))


(defun my-gdb-other-frame ()
  (interactive)
  (select-frame (make-frame))
  (call-interactively 'gdb))

(use-package realgud
  :ensure t)



;; ###### ESHELL

(require 'esh-mode)

(defun eshell-beginning-of-line ()
  "when pressing beginning of line go to $ sign instead of complete left of screen"
  (interactive)
  (re-search-backward "$" nil t nil))



(defun eshell-clear-all ()
  (interactive)
  (eshell/clear 1))

(define-key eshell-mode-map (kbd "M-]") #'eshell-previous-matching-input-from-input)
(define-key eshell-mode-map (kbd "M-}") #'eshell-clear-all)

(ryo-modal-major-mode-keys
 'eshell-mode
 ("a" eshell-bol)
 ("w" eshell-bol)
 ("b" eshell-bol :exit t))


(defun spawn-gef ()
  (interactive)
  (call-process-shell-command "kitty&" nil 0))

(global-set-key (kbd "M-3") #'spawn-gef)


;; PDF

(use-package pdf-tools
  :ensure t
  :config
  (define-key pdf-view-mode-map (kbd "]") #'pdf-view-next-page)
  (define-key pdf-view-mode-map (kbd "]") #'pdf-view-previous-page))

;; DIRED

;; preview files and directories in other window live like ranger

;;(setq my/dired-live-preview-buffer-name nil)
(setq my/dired-live-preview-active nil)
(setq my/dired-live-preview-buffer-list '())
(setq my/dired-live-preview-current-buffer-list '())


(defun my/dired-live-preview-current-windows ()
  "get a list of current visible open buffers"
  (mapcar #'buffer-name (mapcar #'window-buffer (window-list))))

(defun my/dired-live-preview-add-to-buffer-list ()
  "add buffers visited by live preview"
  (cl-pushnew (buffer-name) my/dired-live-preview-buffer-list))

(defun my/dired-live-preview-kill-buffer-list ()
  (interactive)
  (let ((open-windows (my/dired-live-preview-current-windows)))
	(dolist (buffer my/dired-live-preview-buffer-list)
	  (when (not (member buffer open-windows))
	    (and buffer 
		 (kill-buffer buffer)))
	(setq my/dired-live-preview-buffer-list nil))))

(defun my/dired-live-preview-toggle ()
  (interactive)
  (my/dired-live-preview-kill-buffer-list)
  (my/dired-live-preview-start-if-deactive)
  (setq my/dired-live-preview-active (not my/dired-live-preview-active)))

(defun my/dired-live-preview-start-if-deactive ()
  (when (null my/dired-live-preview-active)
	(setq my/dired-live-preview-buffer-name (buffer-name))
	(delete-other-windows)
	(dired-find-file-other-window)
	(my/dired-live-preview-add-to-buffer-list)
	(call-interactively 'ace-window)))


(defun my/dired-live-preview-up ()
  (interactive)
  (if my/dired-live-preview-active
      (progn
	;;		(kill-current-buffer)
	(delete-other-windows)
	(call-interactively 'dired-previous-line)
	(dired-find-file-other-window)
	(my/dired-live-preview-add-to-buffer-list)
	(call-interactively 'ace-window))
    (call-interactively 'dired-previous-line)))


(defun my/dired-live-preview-down ()
  (interactive)
  (if my/dired-live-preview-active
      (progn
	;;		(kill-current-buffer)
	(delete-other-windows)
	(call-interactively 'dired-next-line)
	(dired-find-file-other-window)
	(my/dired-live-preview-add-to-buffer-list)
	(call-interactively 'ace-window))
    (call-interactively 'dired-next-line)))

(defun my/dired-live-preview-leave ()
  (interactive)
  (my/dired-live-preview-kill-buffer-list)
  (dired-find-file)
;;  (delete-other-windows)
  (if (eq major-mode 'dired-mode)
      (progn
	(dired-find-file-other-window)
	(call-interactively 'ace-window))))


(defun my/dired-live-preview-kill ()
  (interactive)
  (kill-current-buffer)
  (my/dired-live-preview-kill-buffer-list))



(ryo-modal-major-mode-keys
 'dired-mode
 ("i" my/dired-live-preview-up)
 ("k" my/dired-live-preview-down))

(ryo-modal-major-mode-keys
 'dired-mode
 ("SPC k" my/dired-live-preview-kill))

 (define-key dired-mode-map (kbd "<return>") #'my/dired-live-preview-leave)

(define-key dired-mode-map (kbd "M-w") #'my/dired-live-preview-toggle)
(define-key dired-mode-map (kbd "M-e") #'(lambda ()
					   (interactive)
					   (print my/dired-live-preview-buffer-list)))
(define-key dired-mode-map (kbd "M-c") #'(lambda ()
					   (interactive)
					   (print my/dired-live-preview-current-buffer-list)))

(define-key dired-mode-map (kbd "M-r") #'my/dired-live-preview-kill-buffer-list)
