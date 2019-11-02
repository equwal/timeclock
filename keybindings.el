(spacemacs/declare-prefix "tt" "timeclock")
(spacemacs/set-leader-keys
   "tti" 'timeclock-in
   "tto" 'timeclock-out
   "ttc" 'timeclock-change
   "ttr" 'timeclock-reread-log
   "ttu" 'timeclock-update-mode-line
   "ttw" 'timeclock-when-to-leave-string
   "tts" 'timeclock-status-string
   "ttm" 'timeclock-modeline-display
   "ttg" 'timeclock-workday-remaining-string
   "tte" 'timeclock-workday-elapsed-string
   "ttl" 'timeclock-when-to-leave-string
   "ttR" 'timelock-report)
