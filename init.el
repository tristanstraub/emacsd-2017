(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/"))
;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade.ferrier.me.uk"))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'load-path (expand-file-name "el-get/el-get" "~/.emacs.d"))

;;(setq el-get-recipe-path-emacswiki nil)

(unless (require 'el-get nil t)
  (setq el-get-install-branch "master")
  (load-file (expand-file-name "el-get-install.el" "~/.emacs.d"))
  ;;(el-get-emacswiki-refresh el-get-recipe-path-emacswiki t)
  (unless (file-directory-p el-get-recipe-path-elpa)
    (el-get-elpa-build-local-recipes)))


(defun ensure-package (package)
  (when (not (require package nil t))
    (el-get 'sync package)
    (require package nil t)))

(setq el-get-sources '(
                       ;; (:name org-mode
                       ;;        :description "Org mode."
                       ;;        :type git
                       ;;        :url "git://orgmode.org/org-mode.git")
                       (:name seq
                              :pkgname "NicolasPetton/seq.el"
                              :type github)
                       (:name counsel-dash
                              :pkgname "nathankot/counsel-dash"
                              :type github)

                       (:name cargo
                              :pkgname "kwrooijen/cargo.el"
                              :type github)

                       (:name rust-mode
                              :pkgname "rust-lang/rust-mode"
                              :type github)

                       (:name replace-colorthemes
                              :description "Replacement color themes."
                              :type github
                              :pkgname "emacs-jp/replace-colorthemes")

                       (:name js-lookup
                              :description "Lookup javascript symbols on MDN"
                              :type github
                              :pkgname "skeeto/js-lookup")

                       (:name swiper
                              :description "ido at point"
                              :type github
                              :pkgname "abo-abo/swiper")

                       (:name ido-at-point
                              :description "ido at point"
                              :type github
                              :pkgname "katspaugh/ido-at-point")

                       )
      )

;; needed for ecb
(setq stack-trace-on-error t)

(setq el-get-verbose t)

;; org
(ensure-package 'org-mode)
(require 'ob-clojure)

(add-hook 'after-init-hook
          `(lambda ()
             ;; remember this directory
             (setq init-dir
                   ,(file-name-directory (or load-file-name (buffer-file-name))))
             ;; load up the starter kit
             (org-babel-load-file (expand-file-name "tristan.emacs/index.org" init-dir))
             ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-interval 5)
 '(auto-revert-use-notify nil)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(cider-boot-command "/Users/tristanstraub/bin/boot")
 '(cider-lein-command "/Users/tristanstraub/bin/lein")
 '(cider-lein-parameters "with-profile +spec repl :headless :host ::")
 '(cider-prompt-for-symbol nil)
 '(cider-repl-use-pretty-printing t)
 '(cider-special-mode-truncate-lines nil)
 '(cljr-favor-private-functions nil)
 '(cljr-warn-on-eval nil)
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "2cc9ecf74dd307cdf856a2f47f6149583d6cca9616a0f4ecc058bafa57e4ffa3" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" default)))
 '(desktop-path (quote ("~/.emacs.d/" "~/.emacs.d/desktop" "~")))
 '(ecb-excluded-directories-regexps
   (quote
    ("^\\(CVS\\|\\.[^xX]*\\)$" "^target$" "^dev-resources$" "^checkouts$")))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-source-path
   (quote
    (("/home/tristan/me/projects/games/dripdrip" "games/dripdrip")
     ("/home/tristan/me/projects/libs/allthethings_games" "allthethings_games")
     ("inspace" "/home/tristan/me/projects/games/inspace"))))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(global-auto-revert-mode t)
 '(helm-grep-default-command "LC_ALL=C grep --color=always -a -d skip %e -n%cH -e %p %f")
 '(iedit-occurrence-face (quote highlight-iedit))
 '(iedit-transient-mark-sensitive nil)
 '(org-mode-hook
   (quote
    (er/add-org-mode-expansions
     (lambda nil
       (org-set-local
	(quote yas/trigger-key)
	[tab])
       (define-key yas/keymap
	 [tab]
	 (quote yas/next-field-or-maybe-expand)))
     #[nil "\300\301\302\303\304$\207"
	   [org-add-hook change-major-mode-hook org-show-block-all append local]
	   5]
     #[nil "\300\301\302\303\304$\207"
	   [org-add-hook change-major-mode-hook org-babel-show-result-all append local]
	   5]
     org-babel-result-hide-spec org-babel-hide-all-hashes org-eldoc-load)))
 '(package-selected-packages
   (quote
    (unbound queue inflections spacemacs-theme alect-themes)))
 '(ring-bell-function (quote ignore))
 '(safe-local-variable-values
   (quote
    ((eval setq-local org-babel-default-header-args:sql
	   (quote
	    ((:cmdline . "-U cbt_development")
	     (:engine . "postgresql"))))
     (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
	   (add-hook
	    (quote write-contents-functions)
	    (lambda nil
	      (delete-trailing-whitespace)
	      nil))
	   (require
	    (quote whitespace))
	   "Sometimes the mode needs to be toggled off and on."
	   (whitespace-mode 0)
	   (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face tabs trailing lines-tail))))
 '(show-paren-mode t)
 '(temporary-file-directory "/tmp/")
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 123 :width normal))))
 '(mode-line ((t (:background "saddle brown" :foreground "gainsboro" :box (:line-width 1 :style released-button)))))
 '(mode-line-buffer-id ((t (:foreground "white" :weight bold)))))
(put 'narrow-to-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
