;+
; NAME:
;   jpm_fwhm
;
; PURPOSE:
;   Calculate the full width half max given an x, y
;
; INPUTS:
;   x [fltarr]: The horizontal coordinate. Will be used to calculate the width. 
;   y [fltarr]: The vertical coordinate. Will be used to find the max (and half max). 
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   fwhm [float]: The width (x1 - x0) at the half max
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   fwhm = jpm_fwhm(wavelength, mirror_reflectivity)
;-
FUNCTION jpm_fwhm, x, y

fit = gaussfit(x, y, coeff)

amp = coeff[0]
mean = coeff[1]
sigma = coeff[2]

fwhm = 2.0 * SQRT(2.0 * alog(2.0)) * sigma

return, fwhm

END