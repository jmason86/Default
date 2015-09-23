;+
; NAME:
;   JPMhhmmss2sod
;
; PURPOSE:
;   Convert hours minutes seconds (hhmmss) to second of day (sod). 
;
; INPUTS:
;   hhmmss [string or structure]: Time to convert.
;                                 If string input then must be in format 'hh:mm:ss'. Assumes that values < 10 have a leading 0 e.g., 6:15:4 must be 06:15:04
;                                 If structure input then must use the tags: {hour, minute, second}. 
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   RETURN_STRING: Set this to get a string instead of a structure returned.
;
; OUTPUTS:
;   Returns the corresponding second of day. 
;
; OPTIONAL OUTPUTS:
;   See RETURN_STRING keyword description above.
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   sod = JPMhhmmss2sod('14:04:40', /RETURN_STRING)
;
; MODIFICATION HISTORY:
;   2015/06/01: James Paul Mason: Wrote script.
;-
FUNCTION JPMhhmmss2sod, hhmmss, RETURN_STRING = RETURN_STRING

IF isa(hhmmss, /STRING) THEN BEGIN
  hour = strmid(hhmmss, 0, 2)
  minute = strmid(hhmmss, 3, 2)
  second = strmid(hhmmss, 6, 2)
ENDIF ELSE BEGIN
  hour = hhmmss.hour
  minute = hhmmss.minute
  second = hhmmss.second
ENDELSE

IF ~keyword_set(RETURN_STRING) THEN BEGIN
  return, round(hour * 3600. + minute * 60. + second)
ENDIF ELSE BEGIN
  return, JPMPrintNumber(round(hour * 3600. + minute * 60. + second), /NO_DECIMALS)
ENDELSE

END