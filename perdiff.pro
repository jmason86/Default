;+
; NAME:
;   perdiff
;
; PURPOSE:
;   Program to calculate the percent difference/change between va1, val2 (val1 - val2)/val1
;
; INPUTS:
;   val1 [float]: the value to be taken with respect to
;   val2 [float]: the value changed to
;
; OPTIONAL INPUTS:
;   measurementError [float]: If this value is provided, calculated uncertaintiesOut will be provided. 
;
; KEYWORD PARAMETERS:
;   RELATIVE: Set to instead use the equation (val1 - val1[0] / val2). Requires that val1 is an array with at least 2 elements
;
; OUTPUTS:
;   Percent change between val1 and val2
;
; OPTIONAL OUTPUTS:
;   uncertantiesOut [fltarr]: An array of the same dimensions as the output and val2 containing the computed uncertainty for each point in the output series. 
;
; RESTRICTIONS:
;   If /RELATIVE then val1 must be an array with at least 2 elements
;
; EXAMPLE:
;   percentValue = perdiff(10.4, 20.5)
;
; MODIFICATION HISTORY:
;   2010/11/07: James Paul Mason: Wrote script. 
;   2013/07/22: James Paul Mason: Added /RELATIVE keyword
;   2013/09/25: James Paul Mason: Changed standard return from (val1 - val2) / val1 to (val2 - val1) / val1, which it should've been all along. 
;                                 This may break some code written prior
;   2015/02/13: James Paul Mason: Added measurementError optional input and uncertaintiesOut optional output and code to support. 
;-
FUNCTION perdiff, val1, val2, RELATIVE = relative, measurementError = measurementError, $ 
                  uncertaintiesOut = uncertainties

IF keyword_set(val1) EQ 0 AND keyword_set(val2) EQ 0 THEN BEGIN
  print, 'Error: val1 and val2 not specified.'
  return, !VALUES.F_NAN
ENDIF
IF keyword_set(val1) EQ 0 THEN BEGIN
  print, 'Error: val1 not specified.'
  return, !VALUES.F_NAN
ENDIF
IF keyword_set(val2) EQ 0 THEN BEGIN
  print, 'Error: val2 not specified.'
  return, !VALUES.F_NAN
ENDIF

IF keyword_set(relative) THEN return, 100 * (val1 - val1[0]) / val2 ELSE BEGIN
  ; Handle parameters being passed in backwards
  IF n_elements(val2) EQ 1 THEN BEGIN
    val3 = val2
    val2 = val1
    val1 = val3
  ENDIF
  
  ; Calculate uncertainty if user requested. Algebra required to derive the uncertainty on %change = (a-b)/b
  IF measurementError NE !NULL THEN BEGIN
    uncertainties = fltarr(n_elements(val2))
    FOR i = 0, n_elements(val2) - 1 DO BEGIN
      x = val2[i] & y = val1
      sigma_x = measurementError * x & sigma_y = measurementError * y
      uncertainties[i] = sqrt(sigma_x^2 * (100./y)^2 + sigma_y^2 * (100.*x/y^2)^2) ; W/m^2 units
    ENDFOR
  ENDIF
  
  ; Calculate %change
  percentChange = fltarr(n_elements(val2))
  FOR i = 0, n_elements(val2) - 1 DO percentChange[i] = 100 * (val2[i] - val1) / val1
  
  return, percentChange
ENDELSE
  
END