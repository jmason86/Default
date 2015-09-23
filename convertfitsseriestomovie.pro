;+
; NAME:
;   ConvertFITSSeriesToMovie
;
; PURPOSE:
;   Convert FITS files to a movie, optionally saving the frames as images to disk. Useful for things like SDO/AIA data
;
; INPUTS:
;   pathToFITSSeries
;
; OPTIONAL INPUTS:
;   pathForMovie  [string]:  path to save movie to
;   movieFilename [string]:  filename for movie including extension (e.g. 'movie.mp4')
;                            if pathForMovie not specified, then pathToFITSSeries is used
;   fps           [integer]: frames per second for movie
;   colortable    [integer]: default IDL colortable to use, from the IDL 8 graphics, defaults to linear black-white
;   aiacolortable [integer]: AIA colortable to use, specify wavelength. Uses aia_lct
;   
; KEYWORD PARAMETERS:
;   SAVE_FRAMES: Frames directory will be created and .png images saved within for each frame
;   LOG:         Use log scaling on image, useful for some images e.g. SDO/AIA
;   SQRT:        Use sqrt scaling on image, useful for some images e.g. SDO/AIA
;   
; OUTPUTS:
;   movie file in .mp4 format
;
; OPTIONAL OUTPUTS:
;   .png images of each frame if /SAVE_FRAMES keyword is set
;
; RESTRICTIONS:
;   pathTOFITSSeries must only contain FITS files for the images to be included in the movie
;   If using aiacolortable, ssw/aia instrument is required
;
; EXAMPLE:
;   ConvertFITSSeriesToMovie, '/Users/jama6159/Documents/Research/Data/SDO/AIA/FullDisk/2011047_16FEB_0146_M1.0/prepped/171/', /LOG, aiacolortable = 171
;
; MODIFICATION HISTORY:
;   Written by:
;     James Paul Mason
;     2013/5/23
;-
PRO ConvertFITSSeriesToMovie, pathToFITSSeries, pathForMovie = pathForMovie, movieFilename = movieFilename, $
                              fps = fps, bitrate = bitrate, colortable = colortable, aiacolortable = aiacolortable, $
                              SAVE_FRAMES = save_frames, LOG = log, SQRT = sqrt
TIC

; Defaults
IF keyword_set(pathForMovie) THEN BEGIN
  IF keyword_set(movieFilename) THEN $
  movieFilename = pathForMovie + movieFilename ELSE $
  movieFilename = pathForMovie + 'movie.mp4'
ENDIF ELSE BEGIN
  IF keyword_set(movieFilename) THEN $
  movieFilename = pathToFITSSeries + movieFilename ELSE $
  movieFilename = pathToFITSSeries + 'movie.mp4'
  pathForMovie = pathToFITSSeries
ENDELSE
IF NOT keyword_set(colortable) THEN colortable = 0
IF keyword_set(aiacolortable) THEN BEGIN
  aia_lct, wave = aiacolortable, r, g, b
  colortable = [[r], [g], [b]]
ENDIF
IF NOT keyword_set(fps) THEN fps = 10
IF NOT keyword_set(bitrate) THEN bitrate = 1e7
IF keyword_set(SAVE_FRAMES) THEN spawn, 'mkdir ' + pathForMovie + 'frames/'

; Get list of FITS files and read in the first image
files = file_search(pathToFITSSeries + '*.fits', COUNT = numberOfFiles)
IF numberOfFiles EQ 0 THEN BEGIN
  message, /INFO, 'No fits files found in specified directory.'
  return
ENDIF
image1 = readfits(files[0])
imageSize = size(image1)

; Setup movie
movieObject = IDLffVideoWrite(movieFilename)
xsize = imageSize[1] < 1024
ysize = imageSize[2] < 1024
vidStream = movieObject.AddVideoStream(xsize, ysize, fps, BIT_RATE = bitrate)

; Loop through files
FOR fileIndex = 0, numberOfFiles - 1 DO BEGIN
  ; Read in fits file
  fits = readfits(files[fileindex], header, /SILENT)
  
  ; Create image using scaling if specified
  IF keyword_set(LOG) THEN fits = bytscl(alog(fits), min = 2.0, max = 8.0) $ 
  ELSE IF keyword_set(SQRT) THEN fits = bytscl(alog(fits), min = 1.0, max = 32.0) $ 
  ELSE fits = bytscl(fits, min = 0.0, max = 1000)
  imageObject = image(fits, DIMENSIONS = [xsize, ysize], RGB_TABLE = colortable, MARGIN = 0, /BUFFER)
  
  ; Overlay T_OBS in corner using text function
  header = head2stc(header)
  t_obs = header.T_OBS
  t = text(0, 0, strmid(t_obs, 0, 17), color = 'w', font_size = 12)
  
  ; Insert frame into movie
  timeInMovie = movieObject.Put(vidStream, imageObject.CopyWindow()) ; time returned in seconds
  
  ; If SAVE_FRAMES is set, then save the images as .pngs to disk
  IF keyword_set(SAVE_FRAMES) THEN BEGIN
    parser = ParsePathAndFilename(files[fileindex])
    fitsFilename = parser.filename
    framesPath = pathForMovie + 'frames/'
    parser2 = StringParse(fitsFilename, DELIMITER = '.')
    filename = parser2(0)
    pngFilename = framesPath + '/' + filename + '.png'
    imageObject.save, pngFilename, BORDER = 0
  ENDIF

  ; Save memory
  imageObject.Close
  
  message, /INFO, strtrim(float(fileIndex + 1) / numberOfFiles * 100., 2) + '% complete'
ENDFOR

movieObject.Cleanup

print, '-=Program normal completion in ' + strtrim(round(TOC()), 2) + ' seconds=-'

END