;+
; NAME: 
;   WhereToEat
;   
; PURPOSE:
;   Stop trying to pick a place to eat and let chance decide. 
;   
; INPUTS: 
;   None
;   
; OPTIONAL INPUTS:
;   None
;   
; KEYWORD PARAMETERS:
;   QUICK: only include options that are quick and typically cheaper
;   
; OUTPUTS:
;   Randomly selected place to eat
;   
; OPTIONAL OUTPUTS: 
;   None
;   
; RESTRICTIONS:
;   None
;   
; EXAMPLE: 
;   WhereToEat, /QUICK
;   
; MODIFICATION HISTORY: 
;   Written by: 
;     James Paul Mason 
;     2013/4/3
;-
PRO WhereToEat, QUICK = quick

quickOptions = ['McDonalds', 'Taco Bell', 'Silvermine', 'Garbanzo', 'Qdoba', 'Tiffins', 'Curry and Kabob']
slowOptions = ['Olive Garden', 'Dennys', 'Efrains', 'Tsing Tao', 'BeauJos'] 
IF keyword_set(quick) THEN options = quickOptions ELSE options = [quickOptions, slowOptions]

choiceIndex = floor(randomu(seed) * n_elements(options))
print, 'Eat at ' + options[choiceIndex]

END