; Function to parse a path/filename into a structure containing the path and the filename
;
; INPUT: 
;   combined = a string that is the combined path and filename e.g. '/root/dir1/dir2/filename'
; 
; OUTPUT: 
;   A structure with the path and the filename separated (TAGS: path, filename)
;   
; James Paul Mason
; 2012/3/1

FUNCTION ParsePathAndFilename, combined

; Get the position of the / separater
position = strpos(combined,'/',/reverse_search)

filename = strmid(combined,position+1)
path = strmid(combined,0,position+1)

return, create_struct('path',path,'filename',filename)

END