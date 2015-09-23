FUNCTION jd2anytim, inputJD, _extra = _extra

return, anytim((inputJD - julday(1, 1, 1979, 0, 0, 0)) * 24 * 3600, _extra = _extra)

END