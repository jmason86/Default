;+
; NAME:
;   JPMindexOfValueCrossing
;
; PURPOSE:
;   Find the indices in an input array nearest where a crossing across a particular input value occur. 
;   For example, return the index where the array [-1, -0.24, 3.11, 5.63] most nearly crosses 0, which would 
;   return [1]. 
;
; INPUTS:
;   inputArray [numeric array]: The array to search for boundary crossings. Integer, float, and double types are valid. 
;   inputValue [numeric type]:  The boundary value that defines where crossings occur. Integer, float, and double types are valid. 
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   FIRST: Set this to only return the first instance where a value crossing occurs
;   LAST:  Set this to only return the last instance where a value crossing occurs
;
; OUTPUTS:
;   indicesOfValueCrossings [intarr]: The indices within inputArray that most nearly cross inputValue. Returns [-1] if no value
;                                     crossings are found. 
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   first0CrossingIndex = JPMindexOfValueCrossing([-14.5, -43.5, -2.4, 1.2, 5.6], 0., /FIRST)
;
; MODIFICATION HISTORY:
;   2016-09-12: James Paul Mason: Wrote script.
;-
FUNCTION JPMindexOfValueCrossing, inputArray, inputValue, $
                                  FIRST = FIRST, LAST = LAST
tic
; Loop through all elements of array to search for crossings
indicesOfValueCrossings = !NULL
FOR i = 1, n_elements(inputArray) - 1 DO BEGIN
  leftPoint = inputArray[i - 1]
  rightPoint = inputArray[i]
  
  matchFound = 0
  IF leftPoint LT inputValue AND rightPoint GT inputValue THEN matchFound = 1
  IF leftPoint GT inputValue AND rightPoint LT inputValue THEN matchFound = 1
  IF matchFound EQ 1 THEN BEGIN 
    ; If still here, then the crossing is happening between the left and right points, but which is closer? 
    IF abs(inputArray[i] - inputValue) LT abs(inputValue - inputArray[i - 1]) THEN closerIndex = i ELSE closerIndex = i - 1
    
    ; Concatenate the closest discovered crossing index in case there are numerous value crossings
    indicesOfValueCrossings = [indicesOfValueCrossings, closerIndex]
  ENDIF
ENDFOR
;message, /INFO, 'Processing time: ' + JPMPrintNumber(toc()) + ' seconds'

; If didn't find anything then set to [-1]
IF indicesOfValueCrossings EQ !NULL THEN return, [-1]

; Optionally return just the first or last indices discovered 
IF keyword_set(FIRST) THEN return, indicesOfValueCrossings[0]
IF keyword_set(LAST) THEN return, indicesOfValueCrossings[-1]

; Return all the indices found that most nearly cross the value boundary

return, indicesOfValueCrossings

END