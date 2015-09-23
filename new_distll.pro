; Function to find the distance between points. 
; Needed for oi code, but could not find online. 
; 
; James Paul Mason
; 
; 4/5/11

FUNCTION new_distLL, x1,y1,x2,y2

R = sqrt( (x2-x1)^2 + (y2-y1)^2 )

RETURN, R
END