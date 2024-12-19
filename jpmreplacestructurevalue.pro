;+
; NAME:
;   JPMReplaceStructureValue
;
; PURPOSE:
;   Add tags to a structure
;
; INPUTS:
;   structure [structure]: The source structure to add tags to
;   tagsToAdd [strarr]:    Names of tags to add as strings
;   valueType [string]:    The type for the value. Allowed values are:
;                          'byte', 'bytarr'
;                          'int', 'intarr'
;                          'float', 'fltarr'
;                          'double', 'dblarr',
;                          'string', 'strarr'.
;                          If using any array type then MUST also provide numElements input.
;
; OPTIONAL INPUTS:
;   insertIndex [integer]: Provide this to insert the new tag into the specified
;                          position rather than tacking it on at the end
;   numElements [integer]: The number of elements to use if valueType is an array.
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   Returns structure with new tags of values type added
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   hk = JPMAddTagsToStructure(hk, 'jd_time', 'double')
;
; MODIFICATION HISTORY:
;   2024-12-18: James Paul Mason: Wrote script.
;-
FUNCTION JPMReplaceStructureValue, input_struct, tag_name, new_value

; IDL forces stuff to be uppercase so just make sure the user stuff is too 
tag_name = strup(tag_name)

bla = JPMRemoveTags(input_struct, tag_name)

yar1 = create_struct(tag_name, new_value)
yar2 = create_struct(bla, yar1)

return, yar2

END
