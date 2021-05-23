(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes '(manoj-dark))
 '(ecb-options-version "2.50")
 '(ecb-source-path '("D:\\Software"))
 '(indent-tabs-mode nil)
 '(jedi:complete-on-dot t)
 '(js-indent-level 4)
 '(js-jsx-indent-level 4)
 '(lsp-vetur-format-default-formatter-css "none")
 '(lsp-vetur-format-default-formatter-html "none")
 '(lsp-vetur-format-default-formatter-js "none")
 '(lsp-vetur-validation-template nil)
 '(neo-hidden-regexp-list
   '("\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.o$" "^\\.git$" "^\\.pytest_cache$" "^node_modules$" "^__pycache__$"))
 '(package-selected-packages
   '(vue-mode prettier-js company-jedi auto-virtualenv python-black flymake flymake-python-pyflakes selectrum selectrum-prescient neotree lsp-ui lsp-mode realgud ido-vertical-mode ag powershell projectile-speedbar ecb pug-mode magit elpy))
 '(projectile-speedbar-enable t)
 '(pug-tab-width 2)
 '(python-indent-guess-indent-offset nil)
 '(speedbar-default-position 'left)
 '(speedbar-directory-unshown-regexp "^$")
 '(speedbar-show-unknown-files t)
 '(speedbar-verbosity-level 0)
 '(sr-speedbar-default-width 27)
 '(sr-speedbar-right-side nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(vue-html-tab-width 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "outline" :slant normal :weight normal :height 158 :width normal)))))

;;
;; Keyboard stuff
(setq w32-apps-modifier 'super)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "s-s") 'isearch-forward)
(define-key isearch-mode-map (kbd "s-s") 'isearch-repeat-forward)
(global-set-key (kbd "s-m") 'magit)

;;
;; Package management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;;
;; Python
(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'auto-virtualenv)
(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
;; Activate on changing buffers
(add-hook 'window-configuration-change-hook 'auto-virtualenv-set-virtualenv)
;; Activate on focus in
(add-hook 'focus-in-hook 'auto-virtualenv-set-virtualenv)

(define-key elpy-mode-map (kbd "<C-tab>") 'elpy-company-backend)
(define-key elpy-mode-map (kbd "C-M-\\") 'python-black-buffer)

(add-hook 'python-mode-hook (add-to-list 'company-backends 'company-jedi))                           

;;
;; Node/Vue
(require 'lsp-mode)
(add-hook 'vue-mode 'prettier-js-mode)
(add-hook 'vue-mode-hook 'lsp-vetur)


;;
;; Selectrum
(selectrum-mode +1)
(selectrum-prescient-mode +1)
(prescient-persist-mode +1)
(savehist-mode)

;;
;; Projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-enable-caching t)

;;
;; Speedbar
;; (global-set-key (kbd "s-d") 'projectile-speedbar-toggle)
;; (require 'sr-speedbar)
;; (require 'projectile-speedbar)

;;
;; NeoTree 
(require 'neotree)
(global-set-key (kbd "s-d") 'neotree-toggle) 
(setq projectile-switch-project-action 'neotree-projectile-action)

;;
;; Local settings
(setq local-settings-file "~/.emacs.d/local.el")
(when (file-exists-p local-settings-file)
  (load-file local-settings-file))

;;
;; Windows PATH stuff
(when (string-equal system-type "windows-nt")
  (setenv "PATH" (concat "C:/Program Files/Git/usr/bin;" (getenv "PATH")))
  (setenv "PATH" (concat "C:/Users/m/AppData/Roaming/Python/Python39/Scripts;" (getenv "PATH")))
  (add-to-list 'exec-path "C:/Program Files/Git/usr/bin")
  (add-to-list 'exec-path "C:/Users/m/AppData/Roaming/Python/Python39/Scripts"))

;;
;; Some last things
(grep-compute-defaults)
(setq-default buffer-file-coding-system 'utf-8-unix)
