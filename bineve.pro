; Program to bin the EVE data to 1nm resolution
;
; 5/25/11: Modified to make more general.
;
; James Paul Mason
; 12/4/10

PRO bineve, eveflux, evewave, binflux, binwave

binflux = findgen(n_elements(evewave)) & binflux(*)=-1 & binwave = binflux
FOR i=0, n_elements(evewave)-1 DO BEGIN

  currwavedex = where(evewave GE i AND evewave LT i+1)
  IF currwavedex NE [-1] THEN BEGIN
    notmissingdex = where(eveflux(currwavedex) NE -1)
    fluxmean = mean(eveflux(currwavedex(notmissingdex)))
    wavemean = mean(evewave(currwavedex))
    binflux(i) = fluxmean
    binwave(i) = wavemean-0.5
  ENDIF

ENDFOR ;i loop


END