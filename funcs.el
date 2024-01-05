(defun spacemacs/matlab-shell-run-buffer ()
  "Runs the current buffer in MATLAB."
  (interactive)
  (matlab-shell-run-region 1 (+ (buffer-size) 1))
  ;; (let ((file-name (buffer-file-name)))
  ;;   (matlab-shell-run-command (format "emacsrunregion('%s',1,%s)" file-name (buffer-size)))
  )

(defun spacemacs/matlab-shell-run-above ()
  "Runs the current buffer in MATLAB."
  (interactive)
  (matlab-shell-run-region 1 (matlab-point-at-eol))
  ;; (let ((file-name (buffer-file-name)))
  ;;   (matlab-shell-run-command (format "emacsrunregion('%s',1,%s)" file-name (point))))
  )

(defun spacemacs/matlab-shell-doc-command (command)
  "Describe COMMAND textually by fetching it's doc from the MATLAB shell.
This uses the lookfor command to find viable commands.
This command requires an active MATLAB shell."
  (interactive
   (let ((fn (matlab-function-called-at-point))
	       val)
     (setq val (read-string (if fn
				                        (format "Describe function (default %s): " fn)
			                        "Describe function: ")))
     (if (string= val "") (list fn) (list val))))
  (let ((doc (matlab-shell-collect-command-output (concat "doc " command))))
    (matlab-output-to-temp-buffer "*MATLAB Help*" doc)))
