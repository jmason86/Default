;+
; NAME:
;   jp_Serializer
;
; PURPOSE:
;   Serialize/deserialize data for streaming over network. Pulled from:
;   http://www.exelisvis.com/Home/NewsUpdates/TabId/170/ArtMID/735/ArticleID/14201/Serializing-IDL-Objects-and-Structures.aspx
;
; INPUTS:
;
;
; OPTIONAL INPUTS:
;
;
; KEYWORD PARAMETERS:
;
;
; OUTPUTS:
;
;
; OPTIONAL OUTPUTS:
;
;
; RESTRICTIONS:
;
;
; EXAMPLE:
;
;
; MODIFICATION HISTORY:
;   2015/02/26: James Paul Mason: Copied code from website above. 
;-
FUNCTION jp_Serializer::Deserialize, var, DIM = dim, TYPECODE = typeCode
  COMPILE_OPT STATIC
  IF (typeCode EQ 8 || typeCode eq 11) THEN BEGIN
    tempFile = FILEPATH('temp.sav', /TMP)
    OPENW, lun, tempFile, /GET_LUN
    WRITEU, lun, ZLIB_UNCOMPRESS(IDL_BASE64(var), TYPE = 1)
    FREE_LUN, lun
    RESTORE, tempFile
    FILE_DELETE, tempFile
    RETURN, v
  ENDIF ELSE BEGIN
    RETURN, ZLIB_UNCOMPRESS(IDL_BASE64(var), DIM = dim, TYPE = typeCode)
  ENDELSE
END

FUNCTION jp_Serializer::Serialize, v, DIM = Dim, TYPECODE = TypeCode
  COMPILE_OPT STATIC
  dim = v.Dim
  typeCode = v.TypeCode
  IF (typeCode EQ 8 || typeCode EQ 11) THEN BEGIN
    tempFile = FILEPATH('temp.sav', /TMP)
    SAVE, v, /COMPRESS, FILE = tempFile
    b = READ_BINARY(tempfile, DATATYPE = 1)
    FILE_DELETE, tempfile
    RETURN, IDL_BASE64(ZLIB_COMPRESS(b))
  ENDIF ELSE BEGIN
    RETURN, IDL_BASE64(ZLIB_COMPRESS(v))
  ENDELSE
END

PRO jp_Serializer__Define
  !null = {jp_Serializer, _ : 0B}
END

