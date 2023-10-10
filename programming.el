
(defun c-run ()
  (interactive)
  (shell-command "bash run"))

(global-set-key (kbd "C-c 0") #'c-run)
