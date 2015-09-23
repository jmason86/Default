; Program to reset the mouse to the state it holds before any clicks have occurred.
; 
; James Paul Mason
; 2012/7/3

PRO ResetMouse

!MOUSE.BUTTON = 0
!MOUSE.TIME = 0
!MOUSE.X = 0
!MOUSE.Y = 0

END