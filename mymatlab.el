;; ;; An attempt to make my own matlab ts-mode
;; ;; Basically following the awesome instruction here:
;; ;; https://www.masteringemacs.org/article/lets-write-a-treesitter-major-mode

;; ;; this is completely stolen from the syntax table from the original matlab-mode
;; (defvar matlab-syntax-table
;;   (let ((st (make-syntax-table (standard-syntax-table))))
;;     ;; Comment Handling:
;;     ;;   Multiline comments:   %{ text %}
;;     ;;   Single line comments: % text (single char start)
;;     ;;   Ellipsis omments:     ... text (comment char is 1st char after 3rd dot)
;;     ;;                            ^ handled in `matlab--syntax-propertize'
;;     (modify-syntax-entry ?%  "< 13" st)
;;     (modify-syntax-entry ?{  "(} 2c" st)
;;     (modify-syntax-entry ?}  "){ 4c" st)
;;     (modify-syntax-entry ?\n ">"    st)

;;     ;; String Handling:
;;     ;;   Character vector:    'text'
;;     ;;   String:              "text"
;;     ;;       These next syntaxes are handled with `matlab--syntax-propertize'
;;     ;;   Transpose:           varname'
;;     ;;   Quoted quotes:       ' don''t '    or " this "" "
;;     ;;   Unterminated Char V: ' text
;;     (modify-syntax-entry ?'  "\"" st)
;;     (modify-syntax-entry ?\" "\"" st)

;;     ;; Words and Symbols:
;;     (modify-syntax-entry ?_  "_" st)

;;     ;; Punctuation:
;;     (modify-syntax-entry ?\\ "." st)
;;     (modify-syntax-entry ?\t " " st)
;;     (modify-syntax-entry ?+  "." st)
;;     (modify-syntax-entry ?-  "." st)
;;     (modify-syntax-entry ?*  "." st)
;;     (modify-syntax-entry ?/  "." st)
;;     (modify-syntax-entry ?=  "." st)
;;     (modify-syntax-entry ?<  "." st)
;;     (modify-syntax-entry ?>  "." st)
;;     (modify-syntax-entry ?&  "." st)
;;     (modify-syntax-entry ?|  "." st)

;;     ;; Parentheticl blocks:
;;     ;;   Note: these are in standard syntax table, repeated here for completeness.
;;     (modify-syntax-entry ?\(  "()" st)
;;     (modify-syntax-entry ?\)  ")(" st)
;;     (modify-syntax-entry ?\[  "(]" st)
;;     (modify-syntax-entry ?\]  ")[" st)
;;     ;;(modify-syntax-entry ?{  "(}" st) - Handled as part of comments
;;     ;;(modify-syntax-entry ?}  "){" st)

;;     st)
;;   "MATLAB syntax table")

;; (define-derived-mode matlab-ts-mode prog-mode "MATLAB[ts]"
;;   "Major mode for editing MATLAB with tree-sitter"
;;   :syntax-table matlab-syntax-table
;;   (setq-local font-lock-defaults nil)
;;   (when (treesit-ready-p 'matlab)
;;     (treesit-parser-create 'matlab)
;;     (matlab-ts-setup))
;;   )

;; (defun matlab-ts-setup ()
;;   "Setup tree-sit for matlab-ts-mode"
;;   ;; Our tree-sitter setup goes here.

;;   ;; This handles font locking -- more on that below.
;;   (setq-local treesit-font-lock-settings
;;               (apply #'treesit-font-lock-rules
;;                      html-ts-font-lock-rules))

;; ;; This handles indentation -- again, (message "message" format-args)ore on that below.
;;   (setq-local treesit-simple-indent-rules html-ts-indent-rules)

;;   ;; ... everything else we talk about go here also ...

;;   ;; End with this
;;   (treesit-major-mode-setup)
;;   )

;; (setq-local treesit-font-lock-feature-list
;;             '((comment)
;;               ;; (classdef)
;;               ))

;; (defvar matlab-ts-mode-font-lock-rules
;;   `(;; MATLAB font locking
;;     :language matlab
;;     :feature comment
;;     ((comment) @font-lock-comment-face)

;;     ;; :language matlab
;;     ;; :feature (declaration)
;;     ;; ((declaration) @font-lock-function-name-face)
;;     )
;;   )

;; (setq-local tree-sitfont-lock-settings
;;             (apply #'treesit-font-lock-rules
;;                    matlab-ts-font-lock-rules))
