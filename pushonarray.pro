;+
; NAME:
;   PushOnArray
;
; PURPOSE:
;   Add a new element to an array, even if the array currently does not exist. Ideal for calling within a loop. 
;
; INPUTS:
;   array      [array]: The array to push the new element onto. If array doesn't exist, the first element is returned. 
;   element [any type]: The element to push onto the array. 
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   A new array with the element appended. 
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   array = PushOnArray(array, 85.24)
;
; MODIFICATION HISTORY:
;   Written by:
;     James Paul Mason
;     2013/5/29
;-
FUNCTION PushOnArray, array, element

return, (n_elements(array) EQ 0) ? element : [array, element]
  
END