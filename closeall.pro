; Program to close all IDL 8 plot windows. 
;
; p is an array containing all of the plot objects
;   e.g. p=[p1,p3,p5]
;
; James Paul Mason
; 9/22/2011



PRO closeall, p

FOR i=0,n_elements(p)-1 DO p(i).close

END