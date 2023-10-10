(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)






;; (defun my-byte-compile-dest-file (source-file)
;;   (concat (file-name-directory source-file)
;;           "prefix-"
;;           (file-name-base source-file)
;;           "-compiled"))

;; (setq byte-compile-dest-file-function 'my-byte-compile-dest-file)


;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;;(package-install 'bind-key)
;;(package-install 'use-package)

(setq essential-packages '(ryo-modal
			   use-package
			   bind-key
			   avy))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package essential-packages)
  (unless (package-installed-p package)
    (package-install package)))

(setq native-comp-async-report-warnings-errors nil)


(require 'bind-key);;(let ((default-directory  "~/.emacs.d/rtags/"))
;;  (normal-top-level-add-subdirs-to-load-path))



(load "~/.emacs.d/paredit")

(load "~/.emacs.d/editing")

(load "~/.emacs.d/window")

(load "~/.emacs.d/ryo-modal")

(load "~/.emacs.d/settings")

(load "~/.emacs.d/scripts")

(load "~/.emacs.d/ivy")

;;(load "~/.emacs.d/fido")

;;(load "~/.emacs.d/helm")

(load "~/.emacs.d/python")

(load "~/.emacs.d/ace-window")

(load "~/.emacs.d/sly")

(load "~/.emacs.d/treemacs")

(load "~/.emacs.d/avy-mode")

;; (load "~/.emacs.d/lsp-mode")
(load "~/.emacs.d/lsp-bridge")

;;(load "~/.emacs.d/ggtags")

;;(load "~/.emacs.d/rtags")

(load "~/.emacs.d/magit")

(load "~/.emacs.d/projectile")

(load "~/.emacs.d/subprograms")

(load "~/.emacs.d/winner")

(load "~/.emacs.d/perspective")

(load "~/.emacs.d/stumpwm")

(load "~/.emacs.d/latex")

(load "~/.emacs.d/yas")

(load "~/.emacs.d/haskell")


(setq inferior-lisp-program "sbcl")

(shell-command "setxkbmap -option caps:escape && xset r rate 200 40")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-type 'box)
 '(custom-safe-themes
   '("512ce140ea9c1521ccaceaa0e73e2487e2d3826cc9d287275550b47c04072bc4" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" default))
 '(disaster-cflags "-march=native ")
 '(disaster-objdump "objdump -d -M attr -Sl --no-show-raw-insn")
 '(package-selected-packages
   '(ccls go-mode golang-mode haskell-language-server haskell-mode dirvish ag rtags cmake-ide ggtags pdf-tools yasnippet realgud quickrun counsel ivy which-key vterm treemacs-projectile treemacs-all-the-icons stumpwm-mode smex smartparens sly ryo-modal pyvenv projectile-ripgrep perspective paredit nav-flash magit imenu-anywhere doom-themes disaster company change-inner auto-sudoedit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
