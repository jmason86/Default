;+
; NAME:
;   JPMtype
;
; PURPOSE:
;   Get the data type of a variable and if it is an array, include that. 
;
; INPUTS:
;   variable [any]: the variable you want to get the type for
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   Returns a string: 
;     'byte', 'bytarr'
;     'int', 'intarr'
;     'long', 'lonarr'
;     'float', 'fltarr'
;     'double', 'dblarr',
;     'string', 'strarr'
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   type = jpmtype(findgen(10))
;
; MODIFICATION HISTORY:
;   2024-12-18: James Paul Mason: Wrote script.
;-
FUNCTION JPMtype, variable
  ; Get the base data type as a string and convert to lowercase
  base_type = strlowcase(size(variable, /TNAME))

  ; Check if the variable is an array (dimensions > 0)
  is_array = size(variable, /N_DIMENSIONS) GT 0

  ; Special cases for abbreviations if it's an array
  IF is_array THEN BEGIN
    IF base_type EQ 'float' THEN base_type = 'flt'
    IF base_type EQ 'byte' THEN base_type = 'byt'
    IF base_type EQ 'long' THEN base_type = 'lon'
    IF base_type EQ 'double' THEN base_type = 'dbl'
    IF base_type EQ 'string' THEN base_type = 'str'
  ENDIF

  ; Append 'arr' if it's an array
  IF is_array THEN base_type += 'arr'

  RETURN, base_type
END
