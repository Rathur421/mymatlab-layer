(with-eval-after-load 'lsp-mode

  (add-to-list 'lsp-language-id-configuration '(matlab-mode . "matlab"))

  (defgroup language-matlab nil
    "Settings for the Bash Language Server."
    :group 'lsp-mode
    :link '(url-link "https://github.com/mathworks/MATLAB-language-server")
    :package-version '(lsp-mode . "8.0.1"))

 (lsp-defcustom lsp-matlab-install-path "~/.local/share/Matlab"
   "The full path to the top-level directory of the MATLAB installation you want to use with this extension. You can determine the full path to your MATLAB installation using the `matlabroot` command in MATLAB. For more information, refer to the [README](https://github.com/mathworks/MATLAB-extension-for-vscode/blob/main/README.md)."
   :type 'string
   :group 'language-matlab
   :package-version '(lsp-mode . "8.0.1")
   :lsp-path "MATLAB.installPath")

 (lsp-defcustom lsp-matlab-matlab-connection-timing "onStart"
   "Choose when this extension starts MATLAB in the background. Some functionality will be unavailable without MATLAB running in the background."
   :type '(choice (:tag onStart onDemand never))
   :group 'language-matlab
   :package-version '(lsp-mode . "8.0.1")
   :lsp-path "MATLAB.matlabConnectionTiming")

 (lsp-defcustom lsp-matlab-index-workspace t
   "Automatically index all MATLAB code files (.m) in the current workspace."
   :type 'boolean
   :group 'language-matlab
   :package-version '(lsp-mode . "8.0.1")
   :lsp-path "MATLAB.indexWorkspace")

 (lsp-defcustom lsp-matlab-telemetry nil
   "Help improve this extension by sending user experience information to MathWorks. For more information, see the [MathWorks Privacy Policy](https://www.mathworks.com/company/aboutus/policies_statements.html)."
   :type 'boolean
   :group 'language-matlab
   :package-version '(lsp-mode . "8.0.1")
   :lsp-path "MATLAB.telemetry")

 (defcustom lsp-matlab-server-command `("node"
                                        "/home/arthurvaron/.spacemacs.d/layers/matlab/MATLAB-language-server/out/index.js"
                                        "--stdio")
   "Command to start eslint server."
   :risky t
   :type '(repeat string))


 (lsp-register-client
  (make-lsp-client
   :new-connection (lsp-stdio-connection (lambda () lsp-matlab-server-command))
   :major-modes '(matlab-mode)
   :activation-fn (lsp-activate-on "matlab")
   :library-folders-fn (lambda (_workspace) lsp-clients-matlab-library-directories)
   :server-id 'matlab-language-server))
 )


(with-eval-after-load 'matlab
  ;; Keybindings
  (spacemacs/declare-prefix-for-mode 'matlab-mode "ms" "repl")
  (spacemacs/declare-prefix-for-mode 'matlab-mode "mh" "help")
  (spacemacs/declare-prefix-for-mode 'matlab-mode "mi" "insert")
  (spacemacs/declare-prefix-for-mode 'matlab-mode "mil" "logics")
  (spacemacs/set-leader-keys-for-major-mode 'matlab-mode
    "si" 'matlab-shell
    "ss" 'matlab-show-matlab-shell-buffer
    "sr" 'matlab-shell-run-region
    "sl" 'matlab-shell-run-region-or-line
    "sf" 'matlab-shell-run-region-function
    "sc" 'matlab-shell-run-cell
    "sa" 'spacemacs/matlab-shell-run-above
    "sb" 'spacemacs/matlab-shell-run-buffer
    "hh" 'matlab-shell-describe-command
    "hH" 'spacemacs/matlab-shell-doc-command
    "ha" 'maltab-shell-apropos
    "hv" 'matlab-shell-describe-variable
    "ie" 'matlab-insert-end-block
    "if" 'tempo-template-matlab-function
    "ilf" 'tempo-template-matlab-for
    "ilw" 'tempo-template-matlab-while
    "ili" 'tempo-template-matlab-if
    "ile" 'tempo-template-matlab-if-else)

  ;; matlab-shell-mode
  (spacemacs/declare-prefix-for-mode 'matlab-shell-mode "mh" "help")
  (spacemacs/set-leader-keys-for-major-mode 'matlab-shell-mode
    "hh" 'matlab-shell-describe-command
    "hH" 'spacemacs/matlab-shell-doc-command
    "ha" 'maltab-shell-apropos
    "hv" 'matlab-shell-describe-variable)

  (add-hook 'matlab-mode-hook #'tree-sitter-indent-mode)
  (add-hook 'matlab-mode-hook #'lsp)

  (add-hook 'matlab-shell-mode-hook #'company-mode)
  (add-hook 'matlab-shell-mode-hook #'(lambda ()
                                        (buffer-disable-undo)
                                        (setq comint-process-echoes t)))
  )
