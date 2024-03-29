(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;;(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
          '("melpa" . "http://melpa.milkbox.net/packages/") t)




(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages
  '(;; Clojure & friends
    clojure-mode
    cider
    align-cljlet
    clj-refactor
    cider-eval-sexp-fu
    html-to-hiccup
    ;; Lisps
    rainbow-delimiters
    paxedit
    ;; Completion popup
    company
    popup
    ;; Project navigation
    flx-ido
    projectile
    ;; Misc.
    markdown-mode
    color-theme-sanityinc-tomorrow
    powerline
    buffer-move
    color-identifiers-mode
    highlight
    git-link
    flycheck-joker
    helm
    helm-projectile
    helm-cider
    helm-swoop
    idle-highlight-mode
    ace-window
    magit
    neotree)
  "A list of packages to ensure are installed at launch.")



(global-set-key (kbd "M-o") 'ace-window)



(setq frame-title-format
      (list '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))



(setq inhibit-startup-screen t)

(setq cider-repl-print-length nil)

(setq whitespace-style '(trailing lines space-before-tab
                                  face indentation space-after-tab))

(defun idle-highlight-hook ()
  (idle-highlight-mode t))

(add-hook 'emacs-lisp-mode-hook 'idle-highlight-hook)
(add-hook 'clojure-mode-hook 'idle-highlight-hook)

;; Automaticaly install any missing packages
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Load key bindings.
;;(load (concat user-emacs-directory "keybinds.el"))

(require 'flycheck-joker)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'clojure-mode-hook 'flycheck-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)

(setq cider-font-lock-reader-conditionals nil)
(setq cider-test-show-report-on-success nil)
(setq cider-repl-use-pretty-printing t)
(setq cider-repl-display-help-banner nil)

(tool-bar-mode -1)
(toggle-scroll-bar -1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-warning-face ((((class color) (min-colors 89)) (:weight bold :foreground "#cc0000"))))
 '(idle-highlight ((t (:inherit region :background "maroon4")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(blink-matching-paren nil)
 '(cider-buffer-name-show-port t)
 '(cider-repl-print-length nil t)
 '(cider-repl-use-pretty-printing t)
 '(cljr-favor-prefix-notation nil)
 '(cljr-favor-private-functions nil)
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(delete-selection-mode t)
 '(fci-rule-color "#393939")
 '(git-link-open-in-browser t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(nrepl-host "localhost")
 '(package-selected-packages
   (quote
    (color-theme-solarized rainbow-delimiters powerline paxedit neotree markdown-mode magit idle-highlight-mode html-to-hiccup highlight helm-swoop helm-projectile helm-cider git-link flycheck-joker flx-ido company color-theme-sanityinc-tomorrow color-identifiers-mode clj-refactor cider-eval-sexp-fu buffer-move align-cljlet)))
 '(projectile-use-git-grep t)
 '(safe-local-variable-values
   (quote
    ((cider-ns-refresh-after-fn . "cognician.datomic-doc.service/start-web")
     (cider-ns-refresh-before-fn . "cognician.datomic-doc.service/stop-web")
     (cider-ns-refresh-after-fn . "user/start-web")
     (cider-ns-refresh-before-fn . "user/stop-web")
     (cider-ns-refresh-after-fn . "cognician.builder2.dev-server/start-service!")
     (cider-ns-refresh-before-fn . "cognician.builder2.dev-server/stop-service!")
     (cider-ns-refresh-after-fn . "cognician.manage.dev-server/start-service!")
     (cider-ns-refresh-before-fn . "cognician.manage.dev-server/stop-service!")
     (cider-ns-refresh-after-fn . "integrant.repl/resume")
     (cider-ns-refresh-before-fn . "integrant.repl/suspend")
     (cider-ns-refresh-after-fn . "cognician.variables.dev-server/start-service!")
     (cider-ns-refresh-before-fn . "cognician.variables.dev-server/stop-service!")
     (cider-ns-refresh-after-fn . "cognician.manage.dev-server/start-service!")
     (cider-ns-refresh-before-fn . "cognician.manage.dev-server/stop-service!")
     (cider-ns-refresh-after-fn . "user/start-service!")
     (cider-ns-refresh-before-fn . "user/stop-service!")
     (cider-ns-refresh-after-fn . "user/start-web!")
     (cider-ns-refresh-before-fn . "user/stop-web!")
     (cider-cljs-lein-repl . "(do (dev) (go) (cljs-repl))")
     (cider-ns-refresh-after-fn . "reloaded.repl/resume")
     (cider-ns-refresh-before-fn . "reloaded.repl/suspend")
     (whitespace-line-column . 80)
     (lexical-binding . t))))
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))


(require 'flx-ido)
(ido-mode 1)
;(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)



;;splitting the windows into 3 parts
;; (defun split-4-ways ()
;;   (interactive)
;;   (delete-other-windows)
;;   (split-window-right)
;;   (split-window-below)
;;   (windmove-right)
;;   (windmove-left))

;;(split-4-ways)

(menu-bar-mode t)

(global-company-mode)
(global-color-identifiers-mode)
(global-whitespace-mode)

(add-hook 'prog-mode-hook 'hs-minor-mode)

(add-hook 'clojure-mode-hook
          (lambda ()
            (clj-refactor-mode 1)
            (paxedit-mode)
            (cljr-add-keybindings-with-prefix "s-r")))

;; Add an extra newline to separate commit message from git commentary

(defun magit-commit-mode-init ()
  (when (looking-at "\n")
    (open-line 1)))

(add-hook 'git-commit-mode-hook 'magit-commit-mode-init)

(setq-default whitespace-line-column 200)

(require 'cider)
(setq cider-pprint-fn 'pprint)

(auto-save-mode t)

;; Save when out of focus
(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)

(defvar cleanup-buffer t)

(defun toggle-fmt-on-clean ()
  (interactive)
  (if cleanup-buffer
      (setq cleanup-buffer nil)
    (setq cleanup-buffer t)))

(defun cleanup-buffer ()
  (interactive)
  (when cleanup-buffer
    (whitespace-cleanup)
    (untabify (point-min) (point-max))
    ;;(indent-region (point-min) (point-max))
    ;;(cider-format-buffer)
    ))

(add-hook 'before-save-hook 'cleanup-buffer)

(eval-when-compile (require 'cl-lib))

;;; Turn on expression highlighting

(show-paren-mode 1)
(setq-default blink-matching-paren nil
              show-paren-style 'parenthesis
              show-paren-delay 0)

(require 'cl)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  (cl-flet ((process-list ())) ad-do-it))

(define-clojure-indent
  ;; compojure
  (context 'defun)
  (GET 'defun)
  (POST 'defun)
  ;; component
  (start 'defun)
  (stop 'defun)
  (init 'defun)
  (db 'defun)
  (conn 'defun)
  ;; datalog
  (and-join 'defun)
  (or-join 'defun)
  (not-join 'defun)
  ;; tufte
  (tufte/p 'defun)
  (tufte/profile 'defun)
  ;;re-frame
  (rf/reg-event-db 'defun)
  (rf/reg-event-fx 'defun)
  (rf/reg-sub 'defun)
  (rf/reg-fx 'defun))



(font-lock-add-keywords
 nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
        1 font-lock-warning-face t)))

;; General
(setq initial-scratch-message nil)
(when (locate-library "clojure-mode")
  (setq initial-major-mode 'clojure-mode))

(projectile-global-mode)
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)

;; Visual
(load-theme 'tango-dark t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

(global-linum-mode t)
(setq linum-format "%3d ")

(setq-default tab-width 2)
(fset 'yes-or-no-p 'y-or-n-p)

(setq visible-bell nil)
(setq ring-bell-function #'ignore)

(require 'powerline)
(powerline-center-theme)

;; Clojure
(setq auto-mode-alist (cons '("\\.hiccup$" . clojure-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.joker$" . clojure-mode) auto-mode-alist))

(require 'clojure-mode)
(setq clojure-align-forms-automatically t)

(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(add-to-list 'same-window-buffer-names "*cider")

(setq nrepl-buffer-name-show-port t)
(setq cider-save-file-on-load nil)

(require 'cider-eval-sexp-fu)

(load-library "hideshow")
(setq hs-hide-comments t)
;; Ido-mode customizations
(setq ido-decorations
      (quote
       ("\n-> "           ; Opening bracket around prospect list
        ""                ; Closing bracket around prospect list
        "\n   "           ; separator between prospects
        "\n   ..."        ; appears at end of truncated list of prospects
        "["               ; opening bracket around common match string
        "]"               ; closing bracket around common match string
        " [No match]"     ; displayed when there is no match
        " [Matched]"      ; displayed if there is a single match
        " [Not readable]" ; current diretory is not readable
        " [Too big]"      ; directory too big
        " [Confirm]")))   ; confirm creation of new file or buffer

(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map [down] 'ido-next-match)
            (define-key ido-completion-map [up] 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)))

;;; Fira code
;;(set-frame-font "Fira Code 16")

(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)"))))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))



(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq mouse-wheel-progressive-speed nil)

(defun hs-clojure-mode-hook ()
  (interactive)
  (hs-minor-mode 1)
  )

(add-hook 'clojure-mode-hook 'hs-clojure-mode-hook)

;;Helm key settings
(helm-mode 1)
(helm-cider-mode 1)
(require 'helm-projectile)
(helm-projectile-on)


;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)

;; Don't change the font for some headings and titles
(setq solarized-use-variable-pitch nil)

;; make the modeline high contrast
(setq solarized-high-contrast-mode-line t)

;; Use less bolding
(setq solarized-use-less-bold t)

;; Use more italics
(setq solarized-use-more-italic t)

;; Use less colors for indicators such as git:gutter, flycheck and similar
(setq solarized-emphasize-indicators nil)

;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)

;; Avoid all font-size changes
(setq solarized-height-minus-1 1.0)
(setq solarized-height-plus-1 1.0)
(setq solarized-height-plus-2 1.0)
(setq solarized-height-plus-3 1.0)
(setq solarized-height-plus-4 1.0)

(load-theme 'solarized-dark t)


(projectile-global-mode)
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)


(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (add-to-list 'exec-path "/usr/local/bin")
    (setq exec-path (split-string path-from-shell path-separator))))



(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(add-to-list 'exec-path "/usr/local/bin")
