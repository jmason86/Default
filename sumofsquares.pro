;+
; NAME:
;   SumOfSquares
;
; PURPOSE:
;   Compute the sum of squares for an input array
;
; INPUTS:
;   inputArray [intarr, fltarr, or dblarr]: The array containing values to be squared and summed
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   sumOfSquares [float or double]: A single value that is the sum of the squares of the inputArray. 
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   sumOfSquares = SumOfSquares(findgen(100))
;
; MODIFICATION HISTORY:
;   2015/10/07: James Paul Mason: Wrote script.
;-
FUNCTION SumOfSquares, inputArray

; If input is an intarr, convert to fltarr to avoid overflow
IF typename(inputArray) EQ 'INT' THEN inputArray = float(inputArray)

; Compute the sum of squares
sumOfSquares = 0
FOR i = 0, n_elements(inputArray) - 1 DO sumOfSquares+=inputArray[i]^2 

return, sumOfSquares
END