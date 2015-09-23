PRO mv_img, img, scl=scl, ind_scl = ind_scl, rate = rate, no_block = no_block    
if not keyword_set(rate) then rate = 50 
if not keyword_set(no_block) then no_block = 0 else no_block = 1
sz = size(img)
if not keyword_set(ind_scl) then ind_scl = 0
;if (sz(sz(0)+1) ne 1) then if not (ind_scl) then scl = 1 
if not keyword_set(scl) then scl = 0
if not keyword_set(ind_scl) then ind_scl = 0
;LOADCT, 8, BOTTOM=LONG(.3*!d.n_colors)
;if (scl) then img1 = bscl(img>.5)
size_b0 = SIZE(img)
tv, bscl((img(*,*,0)>.01))
XINTERANIMATE, SET=size_b0(1:3), /SHOW ,/track 
;if (ind_scl) then $ 
;FOR ii=0,size_b0(3)-1 DO XINTERANIMATE, FRAME=ii, IMAGE=bscl(img(*,*,ii)>.5) $
;else $
;   else if (scl) then $
;FOR ii=0,size_b0(3)-1 DO XINTERANIMATE, FRAME=ii, IMAGE=img1(*,*,ii)  else $
FOR ii=0,size_b0(3)-1 DO XINTERANIMATE, FRAME=ii, IMAGE=img(*,*,ii)  

XINTERANIMATE, rate ,/keep
END   
