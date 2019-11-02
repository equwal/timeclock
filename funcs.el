(defun timeclock-report ()
  "Creates and displays a daily report of timeclock entries."
  (interactive)
  (let* ((pub (let ((in (char-input '("p" "r")
                                    "Public[p] or private[r]? "
                                    "Insert 'P' or 'R'! Public[p] or private[r]? ")))
                (cond ((string-equal "p" in) t)
                      ((string-equal "r" in) nil))))
         (logdir (if pub public-log-dir private-log-dir))
         (expdir (if pub public-export-dir private-export-dir)))
    (message "%s %s %s" pub public-log-dir public-export-dir)
    (shell-command (concat "generate.pl --log-dir='"
                           logdir
                           "' --export-dir='"
                           expdir
                           "'"))
    (browse-url-firefox (concat expdir "/timelog.html"))
    (browse-url-firefox (concat expdir "/changelog.html"))))

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


;;;; --------UTILITIES------------------------------------------
(defun insist-format (valid-format second-p first-prompt &optional second-prompt)
  "Insist on a valid input."
  (let ((res (read-from-minibuffer (if second-p
                                       (if second-prompt
                                           second-prompt
                                         first-prompt)
                                     first-prompt))))
    (if (funcall valid-format res)
        res
      (insist-format valid-format t  first-prompt second-prompt))))
(defun char-input (chars first-prompt &optional second-prompt)
  "Insist on a character, then return it."
  (insist-format (lambda (x)
                   (some (lambda (y)
                           (string= x (downcase y)))
                         (mapcar #'downcase chars)))
                 nil
                 first-prompt second-prompt))
