;+
; NAME:
;   JPMseconds2hhmmss
;
; PURPOSE:
;   Convert a number of seconds to hours minutes seconds (hhmmss).
;
; INPUTS:
;   seconds [integer]: The number of seconds to be converted. May be an array of seconds
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   RETURN_STRING: Set this to get a string instead of a structure returned. Has format: hh:mm:ss
;
; OUTPUTS:
;   Returns structure in the form: {hour, minute, second} with those tags. If input was an array, output
;   is an array of structures.
;
; OPTIONAL OUTPUTS:
;   See RETURN_STRING keyword description above.
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   hhmmss = JPMseconds2hhmmss(8700, /RETURN_STRING)
;
; MODIFICATION HISTORY:
;   2016-10-05: James Paul Mason: Wrote script, largely copied from JPMsod2hhmmss, just now can handle inputs > 86400
;-
FUNCTION JPMseconds2hhmmss, seconds, RETURN_STRING = RETURN_STRING

IF n_elements(seconds) GT 1 THEN inputIsArray = 1 ELSE inputIsArray = 0

hour = floor(seconds / 3600.)
minuteFraction = (seconds / 3600. - hour) * 60
minute = floor(minuteFraction)
second = round((minuteFraction - minute) * 60)
FOR i = 0, n_elements(second) - 1 DO BEGIN
  IF second[i] EQ 60 THEN BEGIN
    minute[i]++
    second[i] = 0
  ENDIF
ENDFOR
FOR i = 0, n_elements(minute) - 1 DO BEGIN
  IF minute[i] EQ 60 THEN BEGIN
    hour[i]++
    minute[i] = 0
  ENDIF
ENDFOR

IF ~keyword_set(RETURN_STRING) THEN BEGIN
  IF inputIsArray NE 1 THEN return, {hhmmss, hour:hour, minute:minute, second:second} ELSE BEGIN
    hhmmss = {hour:hour[0], minute:minute[0], second:second[0]}
    FOR i = 1, n_elements(seconds) - 1 DO hhmmss = [hhmmss, {hour:hour[i], minute:minute[i], second:second[i]}]
    return, hhmmss
  ENDELSE
ENDIF ELSE BEGIN
  IF inputIsArray NE 1 THEN BEGIN
    IF hour   LT 10 THEN hourString   = '0' + JPMPrintNumber(hour,   /NO_DECIMALS) ELSE hourString   = JPMPrintNumber(hour,   /NO_DECIMALS)
    IF minute LT 10 THEN minuteString = '0' + JPMPrintNumber(minute, /NO_DECIMALS) ELSE minuteString = JPMPrintNumber(minute, /NO_DECIMALS)
    IF second LT 10 THEN secondString = '0' + JPMPrintNumber(second, /NO_DECIMALS) ELSE secondString = JPMPrintNumber(second, /NO_DECIMALS)
    return, hourString + ':' + minuteString + ':' + secondString
  ENDIF ELSE BEGIN
    hhmmss = strarr(n_elements(seconds))
    FOR i = 0, n_elements(seconds) - 1 DO BEGIN
      IF hour[i]   LT 10 THEN hourString   = '0' + JPMPrintNumber(hour[i],   /NO_DECIMALS) ELSE hourString   = JPMPrintNumber(hour[i],   /NO_DECIMALS)
      IF minute[i] LT 10 THEN minuteString = '0' + JPMPrintNumber(minute[i], /NO_DECIMALS) ELSE minuteString = JPMPrintNumber(minute[i], /NO_DECIMALS)
      IF second[i] LT 10 THEN secondString = '0' + JPMPrintNumber(second[i], /NO_DECIMALS) ELSE secondString = JPMPrintNumber(second[i], /NO_DECIMALS)
      hhmmss[i] = hourString + ':' + minuteString + ':' + secondString
    ENDFOR
    return, hhmmss
  ENDELSE
ENDELSE

END