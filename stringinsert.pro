;+
; NAME:
;   StringInsert
;
; PURPOSE:
;   IDL's default str_put replaces rather than inserts. This function will insert stringToInsert into originalString at position (end of string by default i.e. string append)
;
; INPUTS:
;   originalString [string]: the string you wish to have something inserted into
;   stringToInsert [string]: the string that you wish to insert
;
; OPTIONAL INPUTS:
;   position [int]: the position you wish to place stringToInsert within originalString, appends to end by default
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   [string] with stringToInsert inside originalString at position
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   newString = StringInsert('This is a string', 'good ', POSITION = 10)
;
; MODIFICATION HISTORY:
;   Written by:
;     James Paul Mason
;     2013/08/28
;-
FUNCTION StringInsert, originalString, stringToInsert, POSITION = position

IF ~keyword_set(POSITION) THEN position = strlen(originalString)

leftString = strmid(originalString, 0, position)
rightString = strmid(originalString, position)

return, leftString + stringToInsert + rightString

END