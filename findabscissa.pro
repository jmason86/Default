; Program to "reverse interpolate". 
; Given two points, provide the x (abscissa) for a specified y (ordinate). 
; Uses a linear interpolation, so points should be close together.
; 
; INPUT: X1 = abscissa of first point
;        Y1 = ordinate of first point
;        X2 = abscissa of second point
;        Y2 = ordinate of second point
;        Yval = desired ordinate to be interpolated
; OUTPUT: Xval = linearly interpolated abscissa
; 
; James Paul Mason
; 4/8/11

FUNCTION findabscissa, X1,Y1,X2,Y2,Yval

rise = Y2 - Y1 
run = X2 - X1 
slope = rise/run
yint = Y2 - slope*X2

Xval = (Yval - yint)/slope


RETURN, Xval

END
