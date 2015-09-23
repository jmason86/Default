; routine to make a text file containing all the IDL-defined procedure
; and function names, for incorporation into the text module for TextWrangler
;
; 20060621 WJP:	initial write
; 2012/3/15 James Paul Mason: Added custom code and solar soft

PRO GET_ROUTINE_NAMES, outputFile, LCASE = lcase

IF (N_ELEMENTS(outputFile) EQ 0) THEN outputFile = DIALOG_PICKFILE(/write)

IF (N_ELEMENTS(outputFile) EQ 0) THEN BEGIN
	MESSAGE, 'No output file specified, exiting', /INFORMATIONAL
	RETURN
ENDIF

IF ~FILE_TEST(FILE_DIRNAME(outputFile), /DIRECTORY) THEN BEGIN
	MESSAGE, 'Unable to access directory: ' + file_dirname(outputFile), /INFORMATIONAL
	RETURN
ENDIF

OPENW, lun, outputFile, /GET_LUN

procedures = ROUTINE_INFO(/SYSTEM)
functions  = ROUTINE_INFO(/SYSTEM, /FUNCTIONS)

; JPM: Grab custom procedures and functions
spawn,'ls /Users/jama6159/Dropbox/IDLWorkspace81/*/ > '+file_dirname(outputFile)+'/CustomCodeList'
readcol, file_dirname(outputFile)+'/CustomCodeList', CustomCodeList,format='a'
spawn, 'rm '+file_dirname(outputFile)+'/CustomCodeList'
CustomCodeListEdited = strarr(n_elements(CustomCodeList))
j=0
FOR i=0,n_elements(CustomCodeList)-1 DO BEGIN 
  position = strpos(CustomCodeList(i),'.pro',/reverse_search)
  IF position NE -1 THEN BEGIN
    CustomCodeListEdited(j) = strmid(CustomCodeList(i),0,position)
    j=j+1
  ENDIF
ENDFOR ;i loop
CustomCodeListEdited = CustomCodeListEdited(where(CustomCodeListEdited NE ''))
; JPM: End custom procedures and functions

; JPM: Grab solar soft (SSW) routines
spawn, 'find /Users/jama6159/ssw/* .pro > '+file_dirname(outputFile)+'/SSWCodeList'
readcol, file_dirname(outputFile)+'/SSWCodeList', SSWCodeList,format='a'
spawn, 'rm '+file_dirname(outputFile)+'/SSWCodeList'
SSWCodeListEdited = strarr(n_elements(SSWCodeList))
j=0
FOR i=0,n_elements(SSWCodeList)-1 DO BEGIN 
  position = strpos(SSWCodeList(i),'.pro',/reverse_search)
  IF position NE -1 THEN BEGIN
    SSWCodeListEdited(j) = strmid(SSWCodeList(i),0,position)
    SSWCodeListEdited(j) = file_basename(SSWCodeListEdited(j))
    j=j+1
  ENDIF
ENDFOR ;i loop
SSWCodeListEdited = SSWCodeListEdited(where(SSWCodeListEdited NE ''))
; JPM: End SSW procedures and functions

IF KEYWORD_SET(lcase) THEN procedures           = STRLOWCASE(TEMPORARY(procedures))
IF KEYWORD_SET(lcase) THEN functions            = STRLOWCASE(TEMPORARY(functions))
IF KEYWORD_SET(lcase) THEN CustomCodeListEdited = STRLOWCASE(TEMPORARY(CustomCodeListEdited))

PRINTF, lun, '<!-- System Procedures -->'
FOR ii = 0, N_ELEMENTS(procedures) - 1 do $
	PRINTF, lun, '<string>' + procedures[ii] + '</string>'

PRINTF, lun, ''
PRINTF, lun, '<!-- System Functions -->'
FOR ii = 0, N_ELEMENTS(functions) - 1 do $
	PRINTF, lun, '<string>' + functions[ii] + '</string>'

; JPM: Print the custom procedures and functions
PRINTF, lun, ''
PRINTF, lun, '<!-- Custom Procedures and Functions -->'
FOR ii = 0, N_ELEMENTS(CustomCodeListEdited) - 1 do $
  PRINTF, lun, '<string>' + CustomCodeListEdited[ii] + '</string>'
  
; JPM: Print the SSW procedures and functions
PRINTF, lun, ''
PRINTF, lun, '<!-- SSW Procedures and Functions -->'
FOR ii = 0, N_ELEMENTS(SSWCodeListEdited) - 1 do $
  PRINTF, lun, '<string>' + SSWCodeListEdited[ii] + '</string>'
FREE_LUN, lun

;	PRINTF, lun, '<!-- Library Procedures -->'
;	PRINTF, lun, '<!-- Library Functions -->'

MESSAGE, 'System procedures and functions written to ' + outputFile, /INFORMATIONAL

RETURN

END
