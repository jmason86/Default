;+
; NAME:
; StringParse
;
; PURPOSE:
;   This function parses a string using an optionally specified delimiter or 
;   by default, the space (' ') token.
;
; CATEGORY:
;  String Processing.
;
; CALLING SEQUENCE:
;   Result = STRPARSE( String )
;
; INPUTS:
;   String:  The string to be parsed.
;        
; OPTIONAL INPUTS:
;   DELIMITER: [string] Character or set of characters to be used for parsing
;
; EXAMPLE:
;        Create a string variable S:
;
;        S = 'This is a string with !@#$% in it.'
;
;        Now parse S by entering:
;
;        ss = STRPARSE(S)
;        help,ss
;        print,TRANSPOSE(ss)
;
;        IDL prints:
;
;        SS              STRING    = Array(8)
;        This
;        is
;        a
;        string
;        with
;        !@#$%
;        in
;        it.
;
; MODIFICATION HISTORY:
;        Written by:    Han Wen, May 1996.
;        2012/7/5, James Paul Mason: Added optional input DELIMITER and edited formatting of code. 
;-
FUNCTION StringParse, stringToProcess, delimiter=delimiter

IF ~keyword_set(delimiter) THEN delimiter = ' '

inf  = 100000
Strs = ''
Str  = STRTRIM(stringToProcess,2)
pSPC = STRPOS(Str, delimiter)
if (pSPC eq -1) then return, Str

REPEAT BEGIN
  s    = STRMID(Str,0,pSPC)
  Strs = [Strs,s]
  Str  = STRTRIM(STRMID(Str,pSPC+1,inf),1)
  pSPC = STRPOS(Str,delimiter)
ENDREP UNTIL (pSPC EQ -1)
IF (Str NE '') THEN Strs = [Strs,Str]

return, Strs(1:*)
END