;; -*- lexical-binding: nil; -*- 

;; Pakcage management
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
(defvar myPackages
  '(
    use-package
    try
    spacemacs-theme
    treesit-auto
    vterm
    magit
    slime
    paredit
    rainbow-delimiters
    anzu
    org-tree-slide
    )
  )
(dolist (package myPackages)
  (unless (package-installed-p package)
    (package-install package)))

;; Customization
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq column-number-mode t)
(set-frame-font "Liberation Mono 15" nil t)
(load-theme 'spacemacs-dark t)
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

(setq tab-bar-show 1)

(setq-default indent-tabs-mode t)
(setq c-ts-mode-indent-offset 8)
(setq c-ts-mode-indent-style 'linux)
(setq c-default-style "linux")
(setq c++-ts-mode-indent-offset 8)
(setq cmake-ts-mode-indent-offset 8)
(setq imenu-auto-rescan t)

(global-set-key (kbd "C-<return>")  'vterm)
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)
(global-set-key [f2]  'compile)
(global-set-key [f1]  'project-compile)

(setq show-paren-delay 0)
(show-paren-mode)

;; Disabling things
;;-----------------------------------------------------
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist '(undecorated . t))
(delete-selection-mode 1)

;; Configure SBCL as the Lisp program for SLIME.
(add-to-list 'exec-path "/usr/local/bin")
(setq inferior-lisp-program "sbcl")

;; Treesitter
(use-package treesit-auto
  :config
  (setq treesit-auto-install 'prompt) ;; auto-install grammars
)

(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-ts-mode))

;; Anzu
(global-anzu-mode +1)

;; Enable Paredit.
(use-package paredit
  :hook ((emacs-lisp-mode
          lisp-mode
          slime-repl-mode
          ielm-mode) . enable-paredit-mode)
  :defer t)
(defun override-slime-del-key ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-del-key)

;; Enable Rainbow Delimiters.
(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

;; Dired
(setq dired-kill-when-opening-new-dired-buffer t)
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook #'auto-revert-mode)
(setq dired-listing-switches "-alh --group-directories-first")

(defun my/switch-to-dired ()
  "Switch to an existing dired buffer, or open a new one."
  (interactive)
  (let ((buf (seq-find
              (lambda (b)
                (with-current-buffer b
                  (derived-mode-p 'dired-mode)))
              (buffer-list))))
    (if buf
        (switch-to-buffer buf)
      (call-interactively #'dired))))

(defun my/dired-preview-file ()
  "Preview file in other window without leaving dired."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (when (file-regular-p file)
      (view-file-other-window file))))

(global-set-key (kbd "C-x d") #'my/switch-to-dired)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") #'dired-find-file)
  (define-key dired-mode-map (kbd "^")
	      (lambda () (interactive) (find-alternate-file "..")))
  (define-key dired-mode-map (kbd "TAB") #'my/dired-preview-file))

;; Magit
(use-package magit
  :bind ("C-x g" . magit-status)
  :defer t)

;; org-mode
(with-eval-after-load "org-tree-slide"
  (define-key org-tree-slide-mode-map (kbd "C-,") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "C-.") 'org-tree-slide-move-next-tree)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(acme-theme anzu magit mathjax monokai-theme org-tree-slide paredit
		rainbow-delimiters slime spacemacs-theme treesit-auto
		try vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
