;+
; NAME:
;   JPMfod2hhmmss
;
; PURPOSE:
;   Convert time in fraction of day format to 'hh-mm-ss'
;
; INPUTS:
;   fod [float]: Fraction of day
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   hhmmss [string]: Hours minutes seconds as either 'hh-mm-ss'
;                    Return an array if the input was an array
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   hhmmss = JPMfod2hhmmss(0.25)
;
; MODIFICATION HISTORY:
;   2018-08-16: James Paul Mason: Wrote script.
;-
FUNCTION JPMfod2hhmmss, fod

hhmmss = !NULL
FOR i = 0, n_elements(fod) - 1 DO BEGIN
  
  ; Convert fod to hours, minutes, seconds
  hour = fix(fod[i] * 24.)
  minute = fix((fod[i] * 24. - hour) * 60)
  second = fix(((fod[i] * 24. - hour) * 60. - minute) * 60.)
  
  hh = (hour LT 10) ? '0' +  strtrim(hour, 2) : strtrim(hour, 2)
  mm = (minute LT 10) ? '0' + strtrim(minute, 2) : strtrim(minute, 2)
  ss = (second LT 10) ? '0' + strtrim(second, 2) : strtrim(second, 2)
  
  ; Stick times together with colons and concatenate array
  hhmmss = [hhmmss, hh + ':' + mm + ':' + ss]
  
ENDFOR

return, hhmmss

END