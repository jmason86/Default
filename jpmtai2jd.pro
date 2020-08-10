;+
; NAME:
;   JPMtai2jd
;
; PURPOSE:
;   Convert International Atomic Time (TAI) to Julian Date (JD). This is essentially just a wrapper around anytim2jd to make it more explicit and 
;   to return jd as a single value rather than a structure with int and frac tags. 
;
; INPUTS:
;   tai [dblarr]: The TAI format times to convert. Can be a single number. 
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   jd [dblarr]: The JD format times corresponding to tai input. 
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   Requires the ssw anytim2jd routine and any dependencies therein. 
;
; EXAMPLE:
;   jd = JPMtai2jd(1842048106.0000000)
;
; MODIFICATION HISTORY:
;   2016-11-16: James Paul Mason: Wrote script.
;-
FUNCTION JPMtai2jd, tai

jdStructure = anytim2jd(tai)

return, double(jdStructure.int) + jdStructure.frac

END