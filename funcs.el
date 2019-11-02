(defun timeclock-in-selector ()
  (interactive)
  (labels ((inner
            (warn-next)
            (let ((selection (downcase (read-from-minibuffer
                                        (if warn-next
                                            "INVALID; [P]ublic or p[R]ivate timelog? [p/r]"
                                          "[P]ublic or p[R]ivate timelog? [p/r]")))))
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
