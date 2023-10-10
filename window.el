
(defun my-last-buffer ()
  (interactive)
  (switch-to-buffer nil))


(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))


(defun split-right ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun split-below ()
  (interactive)
  (split-window-below)
  (other-window 1))

(provide 'window)
