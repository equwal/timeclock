(setq private-log-dir "~/.emacs.d/private/timelogs/private"
      public-log-dir "~/.emacs.d/private/timelogs/public"
      public-export-dir "~/timelogging-intern"
      private-export-dir "~/.emacs.d/private/timelogs/private")
(defvar timeclock-log-dirs `(("p" ,public-log-dir)
                             ("r" ,private-log-dir)))
(setf timeclock-file (concat public-log-dir "/" "timelog"))
(defvar timeclock-in-dir timeclock-file)
(defvar timeclock-temp-file timeclock-file)
