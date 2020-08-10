;+
; NAME:
;   rms
;
; PURPOSE:
;   Take the root mean square of an array
;
; INPUTS:
;   numbers [array]: Any kind of numerical array
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   rms [double]: The root mean square of the input array
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   rms1 = rms(findgen(10))
;
; MODIFICATION HISTORY:
;   2019-07-19: James Paul Mason: Wrote script.
;-
FUNCTION rms, numbers

  return, sqrt(total(numbers^2.d) / n_elements(numbers))
  
END