(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(create-lockfiles nil)
 '(custom-enabled-themes '(manoj-dark))
 '(display-buffer-base-action '((display-buffer-reuse-window)))
 '(ecb-options-version "2.50")
 '(ecb-source-path '("D:\\Software"))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(jedi:complete-on-dot t)
 '(js-indent-level 4)
 '(js-jsx-indent-level 4)
 '(magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
 '(make-backup-files nil)
 '(neo-hidden-regexp-list
   '("\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.o$" "^\\.git$" "^\\.pytest_cache$" "^node_modules$" "^__pycache__$"))
 '(package-selected-packages
   '(elixir-mode vue-mode prettier-js company-jedi auto-virtualenv python-black flymake flymake-python-pyflakes selectrum selectrum-prescient neotree lsp-ui lsp-mode realgud ido-vertical-mode ag powershell projectile-speedbar ecb pug-mode magit elpy))
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
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "outline" :slant normal :weight normal :height 158 :width normal)))))

(add-to-list 'load-path "~/.emacs.d/elisp")

;;
;; Keyboard stuff
(setq w32-apps-modifier 'super)
(define-key isearch-mode-map (kbd "s-s") 'isearch-repeat-forward)
(global-set-key (kbd "C-l") 'downcase-word)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-l") 'sort-lines)
(global-set-key (kbd "s-m") 'magit)
(global-set-key (kbd "s-s") 'isearch-forward)

;;
;; Package management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;;
;; Ligatures
(require 'ligature)

;; Enable ligatures in programming modes
(defvar my/ligatures '(
                       "++" "--" "/=" "&&" "||" "||="
                       "->" "=>" "::" "__"
                       "==" "===" "!=" "=/=" "!=="
                       "<=" ">=" "<=>"
                       "/*" "*/" "//" "///"
                       "\\n" "\\\\" "\\\\\\"
                       "<<" "<<<" "<<=" ">>" ">>>" ">>-" "|=" "^="
                       "0x"
                       "**" "?."
                       "</" "<!--" "</>" "-->" "/>" "www"
                       "##" "###" "####" "#####" "######"
                       "--" "---" "----" "-----" "------"
                       "==" "===" "====" "=====" "======"
                       "<>" "<~>"
                       "??"
                       ".." "..." "=~" "!~" "<=>"
                       ":=" "<-" "<--"
                       ))

(ligature-set-ligatures 'vue-mode my/ligatures)
(ligature-set-ligatures 'prog-mode my/ligatures)

(global-ligature-mode 't)

;;
;; Python
(elpy-enable)
(require 'company-jedi)
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

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)        

;;
;; Elixir
(add-hook 'elixir-mode-hook
          (lambda ()
            (push '(">=" . ?\u2265) prettify-symbols-alist)
            (push '("<=" . ?\u2264) prettify-symbols-alist)
            (push '("!=" . ?\u2260) prettify-symbols-alist)
            (push '("==" . ?\u2A75) prettify-symbols-alist)
            (push '("=~" . ?\u2245) prettify-symbols-alist)
            (push '("<-" . ?\u2190) prettify-symbols-alist)
            (push '("->" . ?\u2192) prettify-symbols-alist)
            (push '("<-" . ?\u2190) prettify-symbols-alist)
            (push '("|>" . ?\u25B7) prettify-symbols-alist)))
;;
;; Node/Vue
(require 'mmm-mode)
(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face "black")))
(add-hook 'vue-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face "black")))

(require 'prettier-js)
(add-hook 'mmm-mode-hook 'prettier-js)
(define-key mmm-mode-map (kbd "C-M-\\") 'prettier-js)
;;(add-hook 'js-mode-hook 'prettier-js)
;;(define-key js-mode-map (kbd "C-M-\\") 'prettier-js)

(require 'vue-mode)
(require 'lsp-mode)
(add-hook 'vue-mode-hook 'lsp)

;;
;; Selectrum
;;(selectrum-mode +1)
;;(selectrum-prescient-mode +1)
;;(prescient-persist-mode +1)
;;(savehist-mode)

;;
;; Projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-enable-caching t)

;;
;; Speedbar
(global-set-key (kbd "s-d") 'projectile-speedbar-toggle)
(require 'sr-speedbar)
(require 'projectile-speedbar)

;;
;; NeoTree 
;; (require 'neotree)
;; (global-set-key (kbd "s-d") 'neotree-toggle) 
;; (setq projectile-switch-project-action 'neotree-projectile-action)

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
(setq global-auto-revert-mode 't)
