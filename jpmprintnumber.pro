;+
; NAME:
;   JPMPrintNumber
;
; PURPOSE:
;   IDL likes to print numbers with tons of white space and an absurd number of decimals. This function deals with that. 
;
; INPUTS:
;   numberToFormat [float, double]: The number you want converted to a string
;
; OPTIONAL INPUTS:
;   NUMBER_OF_DECIMALS [integer]: The number of decimal places to output. Default is 2. 
;
; KEYWORD PARAMETERS:
;   NO_DECIMALS: Set this to return a string number with no decimals
;
; OUTPUTS:
;   formattedNumber [string]: The number converted to a string and formatted to be reasonable
;
; OPTIONAL OUTPUTS:
;   NONE
;
; RESTRICTIONS:
;   NONE
;
; EXAMPLE:
;   sin45String = JPMPrintNumber(sin(45), NUMBER_OF_DECIMALS = 3)
;
; MODIFICATION HISTORY:
;   2012/07/05: James Paul Mason: Wrote procedure
;   2012/07/06: James Paul Mason: Added peanut butter and jelly
;   2015/04/24: James Paul Mason: If not a floating point number, then don't use a decimal value at all
;   2015/05/29: James Paul Mason: Added NO_DECIMALS keyword since setting NUMBER_OF_DECIMALS to 0 get interpreted as it being not set. 
;-
FUNCTION JPMPrintNumber, numberToFormat, NUMBER_OF_DECIMALS = number_of_decimals, NO_DECIMALS = NO_DECIMALS

; Defaults
IF ~keyword_set(NUMBER_OF_DECIMALS) THEN number_of_decimals = 2

trimmed = strtrim(string(numberToFormat), 2)
pos = strpos(trimmed, '.')
IF pos NE -1 THEN BEGIN
  IF ~keyword_set(NO_DECIMALS) THEN return, strjoin(strmid(trimmed, 0, pos) + strmid(trimmed, pos, number_of_decimals + 1)) ELSE $
                                    return, strjoin(strmid(trimmed, 0, pos))
ENDIF ELSE BEGIN
  return, trimmed
ENDELSE

END