;+
; NAME:
;   JPMjd2sod
;
; PURPOSE:
;   Convert from JD to second of day. Ignores the date. 
;
; INPUTS:
;   jd [double]: The julian date e.g, 245525.25
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   Returns seconds of day in integer. 
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   sod = JPMjd2sod(245536.53)
;
; MODIFICATION HISTORY:
;   2015/07/15: James Paul Mason: Wrote script.
;-
FUNCTION JPMjd2sod, jd

fractionOfDay = double(jd - floor(jd))
return, round(fractionOfDay * 24. * 3600.)

END