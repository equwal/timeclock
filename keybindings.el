(defvar timeclock-log-dirs '(("g" "~/.emacs.d/private/timelogs/gsp-log")
                             ("p" "~/.emacs.d/private/timelogs/private-log")))
(defvar timeclock-in-dir (if (boundp 'timeclock-file)
                             timeclock-file
                           (setf timeclock-file (cadar timeclock-log-dirs))))
(defvar timeclock-temp-file timeclock-file)
(defun timeclock-in-selector ()
  (interactive)
  (labels ((inner
            (warn-next)
            (let ((selection (downcase (read-from-minibuffer
                                        (if warn-next
                                            "INVALID; [G]sp or [P]rivate timelog? [p/g]"
                                          "[G]sp or [P]rivate timelog? [p/g]")))))
              (if (member selection (mapcar #'car timeclock-log-dirs))
                  (progn (setf timeclock-temp-file timeclock-file)
                         (setf timeclock-file (cadr (assoc selection timeclock-log-dirs)))
                         (timeclock-in 0 nil t))
                (inner t)))))
    (inner nil)))
(defun timeclock-out-selector ()
  (interactive)
  ;; KLUDGE: This function should not need to exist. timeclock-in-selector is
  ;; the only special one that should be needed.
  (timeclock-out 0 nil t)
  (setf timeclock-file timeclock-temp-file))
(spacemacs/declare-prefix "tt" "timeclock")
(spacemacs/set-leader-keys
   "tti" 'timeclock-in-selector
   "tto" 'timeclock-out-selector
   "ttc" 'timeclock-change
   "ttr" 'timeclock-reread-log
   "ttu" 'timeclock-update-mode-line
   "ttw" 'timeclock-when-to-leave-string
   "tts" 'timeclock-status-string
   "ttm" 'timeclock-modeline-display
   "ttg" 'timeclock-workday-remaining-string
   "tte" 'timeclock-workday-elapsed-string
   "ttl" 'timeclock-when-to-leave-string)
