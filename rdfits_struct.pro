PRO rdfits_struct, filename, struct,SILENT = silent, HEADER_ONLY = header_only,$
  EXTEN = exten
  ;+
  ; NAME:
  ;      RDFITS_STRUCT
  ; PURPOSE:
  ;      Read an entire FITS file (all extensions) into a single IDL structure.
  ; EXPLANATION:
  ;      Each header, image or table array is placed in a separate structure
  ;      tag.
  ;
  ; CALLING SEQUENCE:
  ;      RDFITS_STRUCT, filename, struct, /SILENT, /HEADER_ONLY, EXTEN= ]
  ;
  ; INPUT:
  ;      FILENAME = Scalar string giving the name of the FITS file.
  ;                 One can also specify a gzip (.gz) compressed file
  ;
  ; OPTIONAL KEYWORD:
  ;      /HEADER_ONLY - If set, then only the FITS headers (and not the data)
  ;                are read into the structure.
  ;      /SILENT - Set this keyword to suppress informational displays at the
  ;               terminal.
  ; OUTPUT:
  ;      struct = structure into which FITS data is read.   The primary header
  ;             and image are placed into tag names HDR0 and IM0.   The ith
  ;             extension is placed into the tag names HDRi, and either TABi
  ;             (if it is a binary or ASCII table) or IMi (if it is an image
  ;             extension)
  ;
  ;             If /HEADER_ONLY is set, then struct will contain tags HDR0, HDR1
  ;             ....HDRn containing all the headers of a FITS file with n
  ;             extensions
  ; OPTIONAL INPUT KEYWORD:
  ;       EXTEN - positive integer array specifying which extensions to read.
  ;             Default is to read all extensions.
  ; PROCEDURES USED:
  ;       FITS_OPEN, FITS_READ, FITS_CLOSE
  ;
  ; METHOD:
  ;       The file is opened with FITS_OPEN which return information on the
  ;       number and type of each extension.    The CREATE_STRUCT() function
  ;       is used iteratively, with FITS_READ calls to build the final structure.
  ;
  ; EXAMPLE:
  ;       Read the FITS file 'm33.fits' into an IDL structure, st
  ;
  ;       IDL> rdfits_struct, 'm33.fits', st
  ;       IDL> help, /str, st                   ;Display info about the structure
  ;
  ;       To just read the second and fourth extensions
  ;       IDL> rdfits_struct, 'm33.fits', st, exten=[2,4]
  ; RESTRICTIONS:
  ;       Does not handle random groups or variable length binary tables
  ; MODIFICATION HISTORY:
  ;       Written K. Venkatakrishna, STX April 1992
  ;       Code cleaned up a bit  W. Landsman  STX  October 92
  ;       Modified for MacOS     I.  Freedman  HSTX April 1994
  ;       Work under Windows 95  W. Landsman   HSTX  January 1996
  ;       Use anonymous structures, skip extensions without data WBL April 1998
  ;       Converted to IDL V5.0, W. Landsman, April 1998
  ;       OS-independent deletion of temporary file  W. Landsman  Jan 1999
  ;       Major rewrite to use FITS_OPEN and CREATE_STRUCT() W. Landsman Sep 2002
  ;       Added /HEADER_ONLY keyword   W. Landsman  October 2003
  ;       Do not copy primary header into extension headers W. Landsman Dec 2004
  ;       Do not modify NAXIS when using /HEADER_ONLY W. Landsman Jan 2005
  ;       Added EXTEN keyword  W. Landsman July 2009
  ;-

  COMPILE_OPT idl2
  IF N_Params() LT 2 THEN BEGIN
    print,'Syntax - RDFITS_STRUCT, file, struct, [ /SILENT, /HEADER_ONLY ]'
    return
  ENDIF

  fits_open, filename, fcb                ; Get the description of the file
  IF ~keyword_set(silent) THEN $
    message,/inf,'Now reading file ' + filename + ' with ' + $
    strtrim(fcb.nextend,2) + ' extensions'

  h_only = keyword_set(header_only)
  IF h_only THEN BEGIN
    fits_read,fcb,0,h,/header_only,exten_no=0
    struct = {hdr0:h}
  ENDIF ELSE BEGIN
    fits_read,fcb,d,h,exten_no=0
    struct = {hdr0:h,im0:temporary(d)}
  ENDELSE

  IF fcb.nextend EQ 0 THEN BEGIN
    fits_close,fcb
    return
  ENDIF

  n = N_elements(exten)
  IF N_elements(exten) EQ 0 THEN BEGIN
    n = fcb.nextend
    exten = indgen(n)+1
  ENDIF ELSE BEGIN
    IF max(exten) GT fcb.nextend THEN message, $
      'ERROR - extension ' + strtrim(max(exten),2) + ' does not exist'
  ENDELSE
  FOR i= 0, n-1 DO BEGIN
    j = exten[i]
    jj  = strtrim(j,2)
    IF h_only THEN BEGIN
      fits_read,fcb,0,h,/header_only,/no_pdu,exten=j
      struct = create_struct(temporary(struct), 'hdr' + jj, $
        temporary(h))
    ENDIF ELSE BEGIN
      fits_read,fcb,d,h,/no_pdu,exten=j
      IF fcb.xtension[j] EQ 'IMAGE' THEN tag = 'im' + jj $
      ELSE tag = 'tab' + jj
      struct = create_struct(temporary(struct), 'hdr' + jj, $
        temporary(h),tag, temporary(d))
    ENDELSE
  ENDFOR

  fits_close,fcb
  return
END