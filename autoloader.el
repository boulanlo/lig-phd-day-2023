(defun my/refresh-pdf (process signal)
  "Reverts the poster.pdf buffer"
  (when (memq (process-status process) '(exit signal))
    (with-current-buffer "poster.pdf"
      (revert-buffer nil t))))

(defun my/test (process signal)
  (when (memq (process-status process) '(exit signal))
    (message "done!")))

(defun my/build-pdf-and-revert ()
  "Builds the PDF with nix build and refreshes the output"
  (let* ((output-buffer (get-buffer-create "*Async shell command*"))
	 (proc
	  (start-process "build-pdf" "build-pdf" "nix" "build")))
    (if (process-live-p proc)
	(set-process-sentinel proc #'my/refresh-pdf)
      (message "No process running."))))

(add-hook 'after-save-hook (lambda () (my/build-pdf-and-revert)) nil t)

