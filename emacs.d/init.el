(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar my/packages '(
		      ;; --- Auto-completion ---
		      company
		      ;; --- Better Editor ---
		      hungry-delete
		      swiper
		      counsel
		      smartparens
		      ;; --- Themes ---
		      monokai-theme
		      ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
    (loop for pkg in my/packages
	    when (not (package-installed-p pkg)) do (return nil)
	      finally (return t)))

(unless (my/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
	(package-install pkg))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 显示行号
(global-linum-mode 1)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 更改字体大小 16pt
(set-face-attribute 'default nil :height 160)

;; 关闭自动备份文件功能
(setq make-backup-files nil)

;; 快速打开配置文件
(defun open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 将函数open-init-file绑定到<F2>键上
(global-set-key (kbd "<f2>") 'open-init-file)


;; org-mod 自动换行功能
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;; org-mod 执行代码块
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (sqlite . t)
   ))

;; 自动括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 高亮当前行
(global-hl-line-mode 1)

;; 加载主题
(load-theme 'monokai 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python configuration
(setq-default indent-tabs-mode nil) ;; 使用空格而不是tab
(setq default-tab-width 4)
