;+
; NAME:
;   JPMColors
;
; PURPOSE:
;   Get the string name for a color by passing in an index. Useful for plot function e.g. p = plot(findgen(10), color = JPMColors(i))
;
; INPUTS:
;   Index [int]: An integer value less than 149
;
; OPTIONAL INPUTS:
;   None
;
; KEYWORD PARAMETERS:
;   SIMPLE: Get 10 basic colors: black, red, green, blue, magenta, orange, blue violet, saddle brown, cyan, yellow green
;   GREENS: Get 16 different shades of green
;   
; OUTPUTS:
;   colorString [string]: A string containing the name of an IDL 8 color
;
; OPTIONAL OUTPUTS:
;   None
;
; RESTRICTIONS:
;   None
;
; EXAMPLE:
;   FOR i = 0, 148 DO p = plot([0,1], [i, i], COLOR = JPMColors(i), THICK = 5, /OVERPLOT, YRANGE = [-1, i+1])
;
; MODIFICATION HISTORY:
;   Written by:
;     James Paul Mason
;     2013/2/25
;-
FUNCTION JPMColors, index, SIMPLE = simple, GREENS = greens

IF index GE 149 THEN BEGIN 
  print, 'Please specify an index < 149 for a color other than black. '
  RETURN, 'Black'
ENDIF

IF keyword_set(SIMPLE) THEN $
colors = ['black', 'red', 'green', 'blue', 'magenta', 'orange', 'blue_violet', 'saddle_brown', 'cyan', 'yellow_green'] ELSE $
IF keyword_set(GREENS) THEN $
colors = ['dark_green', 'dark_sea_green', 'forest_green', 'green_yellow', 'green', 'lawn_green', 'dark_olive_green', 'light_green', 'light_sea_green', $
          'lime_green', 'medium_sea_green', 'medium_spring_green', 'pale_green', 'sea_green', 'spring_green', 'yellow_green'] ELSE $
colors = ['alice_blue','antique_white','aqua','aquamarine','azure','beige','bisque','black','blanched_almond','blue','blue_violet','brown',$
  'burlywood','cadet_blue','chartreuse','chocolate','coral','cornflower','cornsilk','crimson','cyan','dark_blue','dark_cyan','dark_goldenrod',$
  'dark_gray','dark_grey','dark_green','dark_khaki','dark_magenta','dark_olive_green','dark_orange','dark_orchid','dark_red','dark_salmon',$
  'dark_sea_green','dark_slate_blue','dark_slate_gray','dark_slate_grey','dark_turquoise','dark_violet','deep_pink','deep_sky_blue','dim_gray',$
  'dim_grey','dodger_blue','firebrick','floral_white','forest_green','fuchsia','gainsboro','ghost_white','gold','goldenrod','gray','grey','green',$
  'green_yellow','gray','honeydew','hot_pink','indian_red','indigo','ivory','khaki','lavender','lavender_blush','lawn_green','lemon_chiffon',$
  'light_blue','light_coral','light_cyan','light_goldenrod','light_gray','light_green','light_gray','light_grey','light_pink','light_salmon',$
  'light_sea_green','light_sky_blue','light_slate_gray','light_slate_grey','light_steel_blue','light_yellow','lime','lime_green','linen','magenta',$
  'maroon','medium_aquamarine','medium_blue','medium_orchid','medium_purple','medium_sea_green','medium_slate_blue','medium_spring_green',$
  'medium_turquoise','medium_violet_red','midnight_blue','mint_cream','misty_rose','moccasin','navajo_white','navy','old_lace','olive','olive_drab',$
  'orange','orange_red','orchid','pale_goldenrod','pale_green','pale_turquoise','pale_violet_red','papaya_whip','peach_puff','peru','pink','plum',$
  'powder_blue','purple','red','rosy_brown','royal_blue','saddle_brown','salmon','sandy_brown','sea_green','seashell','sienna','silver','sky_blue',$
  'slate_blue','slate_gray','slate_grey','snow','spring_green','steel_blue','tan','teal','thistle','tomato','turquoise','violet','wheat','white',$
  'white_smoke','yellow','yellow_green']
  
return, colors[index]
END