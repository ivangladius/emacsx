

(require 'paredit)
(require 'ryo-modal)
(require 'avy)

(use-package change-inner
  :ensure t)

(defun xah-select-line ()
  "Select current line. If region is active, extend selection downward by line.
If `visual-line-mode' is on, consider line as visual line.
URL `http://xahlee.info/emacs/emacs/modernization_mark-word.html'
Version: 2017-11-01 2021-03-19"
  (interactive)
  (if (region-active-p)
      (if visual-line-mode
          (let ((xp1 (point)))
            (end-of-visual-line 1)
            (when (eq xp1 (point))
              (end-of-visual-line 2)))
        (progn
          (forward-line 1)
          (end-of-line)))
    (if visual-line-mode
        (progn (beginning-of-visual-line)
	       (set-mark (point))
	       (end-of-visual-line))
      (progn
        (end-of-line)
        (set-mark (line-beginning-position))))))

;; when in mark mode

;; (defun kill-all-region (beginning end)
;;   (interactive "r")
;;   (and (use-region-p)
;;        (kill-region beginning end)))

(defun delete-region-or-char ()
  (interactive)
  (if (use-region-p)
	  (kill-region (region-beginning) (region-end))
	(delete-char 1)))

(defun paste ()
  (interactive)
  (if (use-region-p)
      (let ((content-to-paste (substring-no-properties
							   (car kill-ring))))
		(kill-region (region-beginning) (region-end))
		(goto-char (region-beginning))
		(insert content-to-paste)
		(set-mark (point)))
    (yank)))


(defun mark-only-content-on-line ()
  (interactive)
  (beginning-of-line)
  (set-mark (point))
  (end-of-line))


(defun insert-mode-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))


(defun insert-mode-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defmacro my-mark (name command)
  `(defun ,name ()
	 (interactive)
	 (set-mark (point))
	 (,command)))

(my-mark mark-whole-forward paredit-forward)
(my-mark mark-whole-backward paredit-backward)
(my-mark mark-forward forward-word)
(my-mark mark-backward backward-word)

(defun my-page-up ()
  (interactive)
  (scroll-down)
  (move-to-window-line nil))

(defun my-page-down ()
  (interactive)
  (scroll-up)
  (move-to-window-line nil))

(defmacro mark-inner-word (name deletep)
  `(defun ,name ()
     (interactive)
     (backward-char)
     (forward-word)
     (set-mark (point))
     (backward-word)
     (when ,deletep
       (when (use-region-p)
	 (kill-region (region-beginning) (region-end))))))

(mark-inner-word mark-inner nil)
(mark-inner-word mark-inner-delete t)

(defmacro mark-inner-whole-word (name deletep)
  `(defun ,name ()
     (interactive)
     (backward-char)
     (paredit-forward)
     (set-mark (point))
     (paredit-backward)
     (when ,deletep
       (when (use-region-p)
	 (kill-region (region-beginning) (region-end))))))

(mark-inner-whole-word mark-inner-whole nil)
(mark-inner-whole-word mark-inner-whole-delete t)



(defun jump-to-letter-forward ()
  (interactive)
  (forward-char)
  (ryo-modal-mode 0)
  (let ((letter (read-key-sequence " ")))
    (if (null (re-search-forward letter nil t nil))
	(backward-char)
      (ryo-modal-mode 1)))
  (backward-char))

(defun jump-to-letter-backward ()
  (interactive)
  (ryo-modal-mode 0)
  (let ((letter (read-key-sequence " ")))
	(re-search-backward letter nil t nil))
  (ryo-modal-mode 1))


(defun my-xref-find-definitions ()
  (interactive)
  (push-mark)
  (call-interactively 'xref-find-definitions))



;; global mark forward and backward cycling

(defun marker-is-point-p (marker)
  "test if marker is current point"
  (and (eq (marker-buffer marker) (current-buffer))
       (= (marker-position marker) (point))))

(defun push-mark-maybe () 
  "push mark onto `global-mark-ring' if mark head or tail is not current location"
  (if (not global-mark-ring) (error "global-mark-ring empty")
    (unless (or (marker-is-point-p (car global-mark-ring))
                (marker-is-point-p (car (reverse global-mark-ring))))
      (push-mark))))


(defun backward-global-mark () 
  "use `pop-global-mark', pushing current point if not on ring."
  (interactive)
  (push-mark-maybe)
  (when (marker-is-point-p (car global-mark-ring))
    (call-interactively 'pop-global-mark))
  (call-interactively 'pop-global-mark))

(defun forward-global-mark ()
  "hack `pop-global-mark' to go in reverse, pushing current point if not on ring."
  (interactive)
  (push-mark-maybe)
  (setq global-mark-ring (nreverse global-mark-ring))
  (when (marker-is-point-p (car global-mark-ring))
    (call-interactively 'pop-global-mark))
  (call-interactively 'pop-global-mark)
  (setq global-mark-ring (nreverse global-mark-ring)))


(defun delete-content-in-buffer ()
  (interactive)
  (mark-whole-buffer)
  (when (use-region-p)
    (kill-region (region-beginning) (region-end))))


(defun scroll-down-10 ()
  (interactive)
  (scroll-down-command 10)
  (move-to-window-line nil))


(defun scroll-up-10 ()
  (interactive)
  (scroll-up-command 10)
  (move-to-window-line nil))


(require 'avy)

(defun my-avy-goto-char ()
  "push mark before jumping"
  (interactive)
  (push-mark)
  (call-interactively 'avy-goto-char))


(provide 'editing)



