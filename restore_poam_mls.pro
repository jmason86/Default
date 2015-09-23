; Program to restore POAM and MLS data for difference dates and return
; them with unique variable names. 
; James Paul Mason 11/7/10

PRO restore_poam_mls, name, data_struc

IF keyword_set(name) EQ 0 THEN BEGIN
  print, 'Error: no data specified. Enter in the form: InstrumentDayofMonth e.g. MLS02'
  err = 1
  return
ENDIF

data_loc = '/Users/jmason86/IDLWorkspace80/POAM_MLS/'

IF name EQ 'MLS01' OR name EQ 'mls01' THEN BEGIN
  flnamecat = 'cat_mls_20051001.sav' & flnameo3 = 'o3_mls_20051001.sav'
ENDIF
IF name EQ 'MLS02' or name EQ 'mls02' THEN BEGIN
  flnamecat = 'cat_mls_20051002.sav' & flnameo3 = 'o3_mls_20051002.sav'
ENDIF
IF name EQ 'MLS03' or name EQ 'mls03' THEN BEGIN
  flnamecat = 'cat_mls_20051003.sav' & flnameo3 = 'o3_mls_20051003.sav'
ENDIF
IF name EQ 'MLS04' or name EQ 'mls04' THEN BEGIN
  flnamecat = 'cat_mls_20051004.sav' & flnameo3 = 'o3_mls_20051004.sav'
ENDIF
IF name EQ 'POAM' or name EQ 'poam' THEN BEGIN
  flnamecat = 'cat_poam3_v4.0.2005' & flnameo3 = 'o3_poam3_v4.0.2005'
ENDIF

RESTORE, data_loc+flnamecat
RESTORE, data_loc+flnameo3

data_struc = CREATE_STRUCT(NAME = name, 'ALT', ALTITUDE, 'COMMENT', COMMENT,$
                           'DATE', DATE, 'ERR', ERR, 'FDOY', FDOY, 'ID', ID, $
                           'LAT', LATITUDE, 'LON', LONGITUDE, 'MASK', MASK, $
                           'MIX', MIX, 'TIME', TIME)


END