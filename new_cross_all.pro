;.....................................CALLING FUNCTION FOR GENERATION OF NEW CROSS_SECTIONS...............................................

bloc='/home/srimoyee/Desktop/bailey_bins/'
floc='/home/srimoyee/Desktop/nrl_files/sav_files/'


;Base Cross-section files

ionzabs_file =  floc+'ion&abs_cross_files.sav'
restore, ionzabs_file
;File has:
; wave_o,wave_o2,wave_n2
; totionz_o,totionz_o2,totionz_n2
; totabs_o,totabs_o2,totabs_n2


;Base Cross-section states files

basestate_file= floc+'baseline_states.sav'
restore,basestate_file
;  File has:
;  O_crss_states,O2_crss_states,N2_crss_states
;  first column is wavelength

;Output files

out_ionsabs_sav='new_crosssec.sav'
out_O_dat='new_Obins.dat'
out_O2_dat='new_O2bins.dat'
out_N2_dat='new_N2bins.dat'


out_states_sav='new_prob_states.sav'
out_Ost_dat='newO_prob.dat'
out_O2st_dat='newO2_prob.dat'
out_N2st_dat='newN2_prob.dat'


enwv_const= 12397.

; Ionisation and Absorption Thresholds
at_n2= 986.30 ; Angstroms
at_o2= 2000.00 ; max bins we will be having
at_o = 913.00
it_n2= 798.00
it_o2= 1025.72 ; keep this at Ly Beta wvln as long as Fennally compilation used
;it_o2= 1032.2  ; from Watanbe 2004
it_o = at_o




tpot=[[13.6, 16.9, 18.6, 28.50, 40.00, 531.70,0.0,0.0,0.0,0.0],$  ; tpot(states,species)
  [12.1, 16.10, 18.20, 20.3,23.2,27.2, 33.0,39.8,531.70,0.0],$    ;Conway 1988
  [15.60,16.70, 18.80, 25.3,29.0,33.40,36.80,37.8, 43.6,400.]]

;______________________________________________________________________________________________________________________


;INPUT SPECTRA

; CHOOSE 1
; #1  NRL solar spectrum..............................

;file_ssflux='C:\Users\srimo\Desktop\nrl_files\sample_spectra.sav'
;file_ssflux='C:\Users\srimo\Desktop\nrl_files\sav_files\irradiance_23jul2016.sav'
;file_ssflux='C:\Users\srimo\Desktop\nrl_files\sav_files\irradiance_04nov2003.sav'
;
;restore, file_ssflux
;  Sav file has:
;  wavelength=(wavelength_low+wavelength_high)/2.
; wavelength_low
; wavelength_high
;spectrum1,spectrum2,spectrum3,spectrum4,spectrum5,background_spectrum
; SQ05 with and without Fe line

;file_ssflux='/home/srimoyee/Desktop/nrl_files/sav_files/x9_stanbands_myver.sav'
;;file_ssflux='/home/srimoyee/Desktop/nrl_files/sav_files/m5_stanbands_myver.sav'
;; file has: wave_lo, wave_hi,spectrum
;restore, file_ssflux
;wavelength_low=wave_lo
;wavelength_high=wave_hi
;wavelength=(wavelength_low+wavelength_high)/2.


;#2 EUVAC spectrum.................................................
;restore,'C:\Users\Srimoyee\Desktop\nrl_files\sav_files\euvac_spec.sav'
;;save file has :ssflux, wv1,wv2,wv_avg
;wavelength_low=wv1
;wavelength_high=wv2
;wavelength=wv_avg

;# 3 Solomon & Qian 2005
;restore,'/home/srimoyee/Desktop/nrl_files/sav_files/Solomon_Qian2005.sav'
;;file has:
;;A_fac, fref, wavelength_low, wavelength_high
;wavelength=(wavelength_low+wavelength_high)/2.

;#4 New Nrl spectra
;restore, floc+ 'newspectra.sav'
;;file has: wave_gcm1,wave_gcm2,meanpeakx9,peakm5
;wavelength_low=wave_gcm1
;wavelength_high=wave_gcm2
;wavelength=(wavelength_low+wavelength_high)/2.

;#5 FISM Spectra

filenam= floc+'fism_1606_253sep17.txt'
  
  openr,lun_fism, filenam, /get_lun
  n_wv=32   ;wavelength bins
  wave1=fltarr(n_wv)  ;in nm ?
  wave2=fltarr(n_wv)  ;in nm ?
  fismflux=dblarr(n_wv)  ;in  photons/cm2/s
  skip_lun, lun_fism, 2, /LINES
  count=0

  while not eof(lun_fism) do begin
    readf,lun_fism,a,b,c
    wave1(count)=a
    wave2(count)=b
    fismflux(count)=c
    count++
  endwhile
  free_lun,lun_fism
  wavelength_low=wave_gcm1
  wavelength_high=wave_gcm2
  wavelength=(wavelength_low+wavelength_high)/2.



;_____________________________________________________________________________________________________________________

;  Hinteregger solar flux  model- used for flux weighting
;
file_hint= bloc+'sc21refw.dat'
openr,lun_hint, file_hint, /get_lun
n_hint=1661   ;wavelength bins
hintwvln=dblarr(n_hint)  ;in angstrom
hintflux=dblarr(n_hint)  ;in  photons/cm2/s

format='$(f8.2,f8.1,a11,i1,f10.6)'
l=''
for i=0,n_hint-1 do begin
  readf,lun_hint,format,a,b,l,c,d
  hintwvln(i)=a
  hintflux(i)=b*1.e9 /1000.  ; to be in units of photons/cm2/s
endfor
free_lun,lun_hint
hintener=enwv_const/hintwvln



;______________________________________________________________________________________________________________________

;Creating new ionz abs abs cross-section file here

new_ion_abs_crossections, enwv_const,at_o,it_o,wavelength, wavelength_low,wavelength_high,meanpeakx9,hintwvln,hintflux,wave_o,totabs_o,totionz_o,sigi_o,sigab_o
new_ion_abs_crossections, enwv_const,at_o2,it_o2,wavelength, wavelength_low,wavelength_high,meanpeakx9,hintwvln,hintflux,wave_o2,totabs_o2,totionz_o2,sigi_o2,sigab_o2
new_ion_abs_crossections, enwv_const,at_n2,it_n2,wavelength, wavelength_low,wavelength_high,meanpeakx9,hintwvln,hintflux,wave_n2,totabs_n2,totionz_n2,sigi_n2,sigab_n2

;______________________________________________________________________________________________________________________

;Saving data
spec_wave=wavelength
save, spec_wave,sigi_o,sigi_o2,sigi_n2,sigab_o,sigab_o2,sigab_n2,$
  filename= floc+ out_ionsabs_sav




openw,lun_O, floc+out_O_dat,/get_lun
printf, lun_O,'Wavelength (A)','Energy (eV)','O Ion(photons/cm^2/s)','O Abs(photons/cm^2/s)'
for i=0,n_elements(wavelength)-1 do $
  printf,lun_O,wavelength(i),'  ',12397./wavelength(i),'  ',sigi_o(i),'  ',sigab_o(i)

openw,lun_O2,floc+out_O2_dat,/get_lun
printf, lun_O2,'Wavelength (A)','Energy (eV)','O2 Ion(photons/cm^2/s)','O2 Abs(photons/cm^2/s)'
for i=0,n_elements(wavelength)-1 do $
  printf,lun_O2,wavelength(i),'  ',12397./wavelength(i),'  ',sigi_o2(i),'  ',sigab_o2(i)

openw,lun_N2,floc+out_N2_dat,/get_lun
printf, lun_N2,'Wavelength (A)','Energy (eV)','N2 Ion(photons/cm^2/s)','N2 Abs(photons/cm^2/s)'
for i=0,n_elements(wavelength)-1 do $
  printf,lun_N2,wavelength(i),'  ',12397./wavelength(i),'  ',sigi_n2(i),'  ',sigab_n2(i)

free_lun,lun_O,lun_O2,lun_N2



close,/all



;_________________________________________________________________________________________________________________
;_________________________________________________________________________________________________________________

;Creating new states files here

; O base-line files
print,'O'
new_bins_forstates, enwv_const,12397./reform(tpot[*,0]),wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,O_crss_states,O_prob_state,O_tot_ionz

; O base-line files
print,'O2'
new_bins_forstates, enwv_const,12397./reform(tpot[*,1]),wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,O2_crss_states,O2_prob_state,O2_tot_ionz

; O base-line files
print,'N2'
new_bins_forstates, enwv_const,12397./reform(tpot[*,2]),wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,N2_crss_states,N2_prob_state,N2_tot_ionz

;_________________________________________________________________________________________________________________

;Saving data
save, O_prob_state,O2_prob_state,N2_prob_state,$
  filename= floc+out_states_sav



;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;openw,lun_O,floc+out_Ost_dat,/get_lun
;printf, lun_O,'Wavelength (A)','4So ','2Do ','2Po ','4P ','2P ','K '
;for i=0,n_elements(O_prob_state[0,*])-1 do $
;    printf,lun_o, O_prob_state[0,i],'  ',O_prob_state[1,i],'  ',O_prob_state[2,i],'  ',O_prob_state[3,i],' ',$
;                   O_prob_state[4,i],'  ',O_prob_state[5,i],'  ',O_prob_state[6,i]
;
;
;openw,lun_O2,floc+out_O2st_dat,/get_lun
;printf, lun_O2,'Wavlength','X ','a+A ','b ','B ','2pi+c ','2sig ','33 eV ','2,4sig ','K '
;
;for i=0,n_elements(O2_prob_state[0,*])-1 do $
;    printf,lun_o2, O2_prob_state[0,i],'  ',O2_prob_state[1,i],'  ',O2_prob_state[2,i],'  ',$
;                   O2_prob_state[3,i],'  ',O2_prob_state[4,i],'  ',O2_prob_state[5,i],'  ',$
;                   O2_prob_state[6,i],'  ',O2_prob_state[7,i],'  ',O2_prob_state[8,i],'  ',$
;                   O2_prob_state[9,i]
;
;openw,lun_N2,floc+out_N2st_dat,/get_lun
;printf, lun_N2,'Wavlength ', 'X ','A ','B ','C ','F ','G+E','HP ','H ','N2++ ','K '
;for i=0,n_elements(N2_prob_state[0,*])-1 do $
;    printf,lun_n2, N2_prob_state[0,i],'  ',N2_prob_state[1,i],'  ',N2_prob_state[2,i],'  ',$
;                   N2_prob_state[3,i],'  ',N2_prob_state[4,i],'  ',N2_prob_state[5,i],'  ',$
;                   N2_prob_state[6,i],'  ',N2_prob_state[7,i],'  ',N2_prob_state[8,i],'  ',$
;                   N2_prob_state[9,i],'  ',N2_prob_state[10,i]
;
;free_lun,lun_O,lun_O2,lun_N2
;

;+++++++++++++++++++++++++++++++++++++++++++++++++OR++++++++++++++++++++++++++++++++++++++++++++++

openw,lun_O,floc+out_Ost_dat,/get_lun
printf, lun_O,'Wavelength (A)','4So ','2Do ','2Po '
for i=0,n_elements(O_prob_state[0,*])-1 do $
  printf,lun_o, O_prob_state[0,i],'  ',O_prob_state[1,i],'  ',O_prob_state[2,i],'  ',O_prob_state[3,i]


openw,lun_O2,floc+out_O2st_dat,/get_lun
printf, lun_O2,'Wavlength ','O2+ ','Frag(D.I) '

for i=0,n_elements(O2_prob_state[0,*])-1 do $
  printf,lun_o2, O2_prob_state[0,i],'  ',O2_prob_state[1,i],'  ',O2_prob_state[2,i]


openw,lun_N2,floc+out_N2st_dat,/get_lun
printf, lun_N2,'Wavlength ', 'N2+ ','Frag(D.I) '
for i=0,n_elements(N2_prob_state[0,*])-1 do $
  printf,lun_n2, N2_prob_state[0,i],'  ',N2_prob_state[1,i],'  ',N2_prob_state[2,i]

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

close,/all



end
