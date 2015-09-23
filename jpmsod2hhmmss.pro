;+
; NAME:
;   JPMsod2hhmmss
;
; PURPOSE:
;   Convert second of day (sod) to hours minutes seconds (hhmmss). 
;
; INPUTS:
;   sod [integer]: The second of day to be converted. Must be less than 86400 (24 hours)
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   RETURN_STRING: Set this to get a string instead of a structure returned. Has format: hh:mm:ss
;
; OUTPUTS:
;   Returns structure in the form: {hour, minute, second} with those tags. 
;
; OPTIONAL OUTPUTS:
;   See RETURN_STRING keyword description above. 
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   hhmmss = sod2hhmmss(76432, /RETURN_STRING)
;
; MODIFICATION HISTORY:
;   2015/05/29: James Paul Mason: Wrote script.
;-
FUNCTION JPMsod2hhmmss, sod, RETURN_STRING = RETURN_STRING

IF sod GT 86400 THEN BEGIN
  message, /INFO, 'Input second of day greater than 86400 (24 hours). What did you do wrong?!'
  return, -1
ENDIF

hour = floor(sod / 3600.)
minuteFraction = (sod/3600. - hour) * 60
minute = floor(minuteFraction)
second = round((minuteFraction - minute) * 60)

IF ~keyword_set(RETURN_STRING) THEN BEGIN
  return, {hhmmss, hour:hour, minute:minute, second:second}
ENDIF ELSE BEGIN
  IF hour   LT 10 THEN hourString   = '0' + JPMPrintNumber(hour,   /NO_DECIMALS) ELSE hourString   = JPMPrintNumber(hour,   /NO_DECIMALS)
  IF minute LT 10 THEN minuteString = '0' + JPMPrintNumber(minute, /NO_DECIMALS) ELSE minuteString = JPMPrintNumber(minute, /NO_DECIMALS)
  IF second LT 10 THEN secondString = '0' + JPMPrintNumber(second, /NO_DECIMALS) ELSE secondString = JPMPrintNumber(second, /NO_DECIMALS)
  return, hourString + ':' + minuteString + ':' + secondString
ENDELSE

END