

(require 'ryo-modal)
(require 'window)

(use-package company
  :ensure t
  :demand t
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (global-company-mode))


(use-package lsp-mode
  :ensure t
  :ryo
  ("g"
   (("d" lsp-find-definition)
    ("D" my-lsp-find-definition-new-window)
    ("r" my/lsp-find-references)
    ("s" lsp-ivy-global-workspace-symbol)
    ("S" my-lsp-ivy-global-workspace-symbol-new-window)
    ("o" xref-go-back)))
  :config
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-idle-delay 0.500)
  (setq lsp-log-io nil)

  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-lens-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-code-actions nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-signature-auto-activate nil))


(require 'lsp-mode)

(defun screen-full-p ()
  "if more then 2 windows are there return true"
  (and (>= (count-windows) 2) t))

(defun my-lsp-find-definition-new-window ()
  "open definition in vertical split window"
  (interactive)
  (if (screen-full-p)
      (split-below)
    (split-right))
  (call-interactively 'lsp-find-definition))

(defun my-lsp-ivy-global-workspace-symbol-new-window ()
  (interactive)
  (if (screen-full-p)
      (split-below)
    (split-below))
  (call-interactively 'lsp-ivy-global-workspace-symbol))


(use-package lsp-ui
  :ensure t)

;; PYTHON
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright))))


;; (use-package lsp-java
;;   :ensure t
;;   :hook (java-mode . (lambda ()
;;                        (require 'lsp-java))))

(use-package ccls
  :ensure t
  :hook (c-mode . (lambda ()
		    (require 'ccls))))

(use-package lsp-haskell
  :ensure t
  :hook (haskell-mode . (lambda ()
		    (require 'lsp-haskell))))



(use-package lsp-ivy
  :ensure t)

(use-package smartparens
  :ensure t)

(use-package dap-mode
  :ensure t
  :config
  (setq dap-auto-configure-mode t))


;; navigate to *xref* lsp references without leaving the window
;; trough shortcuts

(setq my/lsp-xref-buffer-open nil)
(setq my/lsp-xref-buffer-name "*xref*")

(defun my/lsp-find-references ()
  (interactive)
  (lsp-find-references)
  (switch-to-buffer my/lsp-xref-buffer-name)
  (forward-line)
  (xref-goto-xref))

(defun my/lsp-xref-check-open ()
  (if (car (member my/lsp-xref-buffer-name
		   (mapcar #'buffer-name
			   (mapcar #'window-buffer (window-list)))))
      (setq my/lsp-xref-buffer-open t)
    (setq my/lsp-xref-buffer-open nil)))

(defun my/point-number-p ()
  (let ((char (char-after)))
    (while (eq ? char)
      (forward-char)
      (setq char (char-after)))
    (member(char-after) '(?0 ?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9))))

(defun my/xref-up ()
  (interactive)
  (if (my/lsp-xref-check-open)
      (progn
	(switch-to-buffer my/lsp-xref-buffer-name)
	(when (= (line-number-at-pos) 2)
	  t)
	(previous-line)
	(redisplay t)
	(while (not (my/point-number-p))
	  (previous-line))
	(xref-goto-xref))))


(defun my/xref-down ()
  (interactive)
  (if (my/lsp-xref-check-open)
      (progn
	(switch-to-buffer my/lsp-xref-buffer-name)
	(forward-line)
	(redisplay t)
	(while (not (my/point-number-p))
	  (forward-line)
	  (redisplay t))
	(xref-goto-xref))))


(global-set-key (kbd "M-P") #'my/xref-up)
(global-set-key (kbd "M-N") #'my/xref-down)




