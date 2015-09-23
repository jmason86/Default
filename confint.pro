; Program to compute 90% and 95% confidence intervals
; (From Martinez, J. and Iglewicz, I., 1981, Biometrika, 68, 331-333.)
; 
; INPUT: N = number of points 
;        sig = choice of significance level -- 90 or 95
; OUTPUT: the significance interval
; 
; NOTE: Only works for a limit of a few hundred N
; 
; 
; James Paul Mason 
; 2/24/11

FUNCTION confint,N,sig

IF n_elements(sig) EQ 0 THEN sig=95 ;Default to 95% confidence interval if no input given

M=ALOG10(N-1) ; N = number of points

IF sig EQ 90 THEN $
interval=ABS(.6376-1.1535*M+.1266*M^2) ;90% confidence interval

IF sig EQ 95 THEN $
interval=ABS( 0.7824-1.1021*M+.1021*M^2) ;95% confidence interval

return,interval

STOP
END