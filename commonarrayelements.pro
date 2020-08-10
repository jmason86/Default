;+
; NAME:
;   CommonArrayElements
;
; PURPOSE:
;   Obtain the common elements in two arrays. For example, 
;   A = [1,2,8,9,10,3,4,5] 
;   B = [5,3,4,11,12] 
;   Function returns [3,4,5]
;   Pulled source code from: http://www.harrisgeospatial.com/Support/Forums/tabid/184/forumid/7/threadid/7022/scope/posts/Default.aspx
;
; INPUTS:
;   array1 [numeric array]: The first array containing numbers to be compared. Can be float, int, double but must be positive. 
;   array2 [numeric array]: The second array "" 
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   None
;
; OUTPUTS:
;   Returns the common elements of the two arrays
;
; OPTIONAL OUTPUTS:
;   count [integer]: The number of common elements
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   commonElements = CommonArrayElements(findgen(10), findgen(10) + 5)
;
; MODIFICATION HISTORY:
;   2016-10-11: James Paul Mason: Wrote script.
;-
FUNCTION CommonArrayElements, array1, array2, $
                              count = count
  minab = min(array1, MAX=maxa) > min(array2, MAX=maxb) ;Only need intersection of ranges
  maxab = maxa < maxb

  ;If either set is empty, or their ranges don't intersect: result = NULL.
  if maxab lt minab or maxab lt 0 then return, -1
  r = where((histogram(array1, MIN=minab, MAX=maxab) ne 0) and  $
    (histogram(array2, MIN=minab, MAX=maxab) ne 0), count)
  if count eq 0 then return, -1 else return, r + minab
END