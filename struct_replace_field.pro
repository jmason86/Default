PRO struct_replace_field, struct, tag, data, newtag=newtag
  ;Change the type, dimensionality, and contents of an existing structure
  ; field. The tag name may be changed in the process.
  ;
  ;Inputs:
  ; tag (string) Case insensitive tag name describing structure field to
  ;  modify. Leading and trailing spaces will be ignored. If the field does
  ;  not exist, the structure is not changed and an error is reported.
  ; data (any) data that will replace current contents  of
  ; [newtag=] (string) new tag name for field being replaced. If not
  ;  specified, the original tag name will be retained.
  ;
  ;Input/Output:
  ; struct (structure) structure to be modified.
  ;
  ;Examples:
  ;
  ; Replace sme.wave with the arbitrary contents of wave:
  ;
  ;   IDL> struct_replace_field, sme, 'wave', wave
  ;
  ; The tag name for a field can be changed without altering the data:
  ;
  ;   IDL> struct_replace_field, clients, 'NMAE', clients.nmae, newtag='Name'
  ;
  ;History:
  ; 2003-Jul-20 Valenti  Initial coding

  IF n_params() LT 3 THEN BEGIN
    print, 'syntax: struct_replace_field, struct, tag, data [,newtag=]'
    return
  ENDIF

  ;Check that input is a structure.
  IF size(struct, /tname) NE 'STRUCT' THEN BEGIN
    message, 'first argument is not a structure'
  ENDIF

  ;Get list of structure tags.
  tags = tag_names(struct)
  ntags = n_elements(tags)

  ;Check that requested field exists in input structure.
  ctag = strupcase(strtrim(tag, 2))   ;canoncial form of tag
  itag = where(tags EQ ctag, nmatch)
  IF nmatch EQ 0 THEN BEGIN
    message, 'structure does not contain ' + ctag + ' field'
    return
  ENDIF
  itag = itag[0]        ;convert to scalar

  ;Choose tag name for the output structure.
  IF keyword_set(newtag) THEN otag = newtag ELSE otag = ctag

  ;Copy any fields that precede target field. Then add target field.
  IF itag EQ 0 THEN BEGIN     ;target field occurs first
    new = create_struct(otag, data)
  ENDIF ELSE BEGIN        ;other fields before target
    new = create_struct(tags[0], struct.(0))  ;initialize structure
    FOR i=1, itag-1 DO BEGIN      ;insert leading unchange
      new = create_struct(new, tags[i], struct.(i))
    ENDFOR
    new = create_struct(new, otag, data)  ;insert new data
  ENDELSE

  ;Replicate remainder of structure after desired tag.
  FOR i=itag+1, ntags-1 DO BEGIN
    new = create_struct(new, tags[i], struct.(i))
  ENDFOR

  ;Replace input structure with new structure.
  struct = new

END