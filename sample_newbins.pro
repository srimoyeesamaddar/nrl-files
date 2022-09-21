pro sample_newbins

; Testing out the new cross-section bins

enwv_const= 12397.

;  NRL solar spectrum..............................

file_ssflux='C:\Users\srimo\Desktop\nrl_files\sample_spectra.sav'
restore, file_ssflux
;  Sav file has:
;  wavelength=(wavelength_low+wavelength_high)/2.
; wavelength_low
; wavelength_high
;spectrum1,spectrum2,spectrum3,spectrum4,spectrum5,background_spectrum



;New cross-section files..................................
restore, 'C:\Users\srimo\Desktop\nrl_files\sav_files\new_crosssec.sav'
; file has the following variables:
;  spec_wave: wavelengths (A)
;  Ionisation cross-sections (cm^2):sigi_o,sigi_o2,sigi_n2
;  Absorption cross-section: (cm^2):sigab_o,sigab_o2,sigab_n2
spec_wave=spec_wave[0:137]
sigi_o=sigi_o[0:137]
sigi_o2=sigi_o2[0:137]
sigi_n2=sigi_n2[0:137]
sigab_o=sigab_o[0:137]
sigab_o2=sigab_o2[0:137]
sigab_n2=sigab_n2[0:137]
;  Hinteregger test model............................

file_hint= 'C:\Users\srimo\Desktop\bailey_bins\sc21refw.dat'
openr,lun_hint, file_hint, /get_lun
n_hint=1661   ;wavelength bins
hintwvln=fltarr(n_hint)  ;in angstrom
hintflux=fltarr(n_hint)  ;in  photons/cm2/s

format='$(f8.2,f8.1,a11,i1,f10.6)'
l=''
for i=0,n_hint-1 do begin
  readf,lun_hint,format,a,b,l,c,d
  hintwvln(i)=a
  hintflux(i)=b*1.e9 /1000.  ; to be in units of photons/cm2/s
endfor
free_lun,lun_hint
hintener=enwv_const/hintwvln

;Cross -sections interpolated to Hinteregger spectrum..............
restore,'C:\Users\srimo\Desktop\nrl_files\sav_files\cross_hint.sav'
;file contains:
;hintwvln,result_ionz_o,result_ionz_o2,result_ionz_n2,result_abs_o,result_abs_o2,result_abs_n2

hintwvln=hintwvln[0:779]
result_ionz_o=result_ionz_o[0:779]
result_ionz_o2=result_ionz_o2[0:779]
result_ionz_n2=result_ionz_n2[0:779]
result_abs_o=result_abs_o[0:779]
result_abs_o2=result_abs_o2[0:779]
result_abs_n2=result_abs_n2[0:779]

;Plot variables...............
colors=['pur5','pur8','orange','red','dodger blue','purple',$
        'slate blue','blue','ygb4','navy','crimson','deep pink']
pos1=[0.1,0.1,0.9,0.4]
pos2=[0.1,0.5,0.9,0.9]
xr_wv=[0.1,1.5e3] ;xr=[1.,1.5e4]
yr_wv=[1.e-24,1.e-16];[0.,6.e-17]  
xr_en=[1.e1,1.e4];xr_en=[0.,100.]   
yr_en=[1.e-20,1.e-16];[0.,6.e-17]    
xlg=1
ylg=1
xt_e='Energy (eV)'
xt_wv='Wavelength (Angstrom)'
yt='Cross section (cm^2)'
maj=['O- ','O2- ','N2- ']
tilt=' cross sections'
thck=3
symb=-46
box_loc_l=[0.45, 0.85]
box_loc_r=[0.9, 0.40]
legend_algn=1

loc='C:\Users\srimo\Desktop\nrl_files\plots2\'
ext=['.ps','.pdf','.jpeg']
filenames=['o_cross','o2_cross','n2_cross']

; PLOTS......

;Ionisation & absorption
cgdisplay,1000,1000, /free

;cgps_open, filename=loc+'cross_sec_plots.ps'
cgplot,enwv_const/spec_wave,sigi_o,thick=thck,color=colors[0],$
       xtitle=xt_e,ytitle=yt,psym=symb,$
       position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,enwv_const/spec_wave,sigab_o,thick=thck,color=colors[1],/overplot
cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
  symcolors=colors[0:1],alignment=legend_algn,/box,Location=box_loc_r


cgplot,spec_wave,sigi_o,thick=thck,color=colors[0],/noerase,$  
       xtitle=xt_wv,ytitle=yt,title=maj[0]+tilt,psym=symb,$
       position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,spec_wave,sigab_o,thick=thck,color=colors[1],/overplot
cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
  symcolors=colors[0:1],alignment=legend_algn,/box,Location=box_loc_l
;cgPS_Close, /PNG, /Delete_PS   
;cgps2pdf,loc+filenames[0]+ext[0],$
;         loc+filenames[0]+ext[1], gs_path='C:\Program Files\gs\gs9.27'
;cgps_close,/pdf


cgdisplay,1000,1000, /free
;cgps_open, filename=loc+filenames[1]+ext[0]
cgplot,enwv_const/spec_wave,sigi_o2,thick=thck,color=colors[2],$
  xtitle=xt_e,ytitle=yt,psym=symb,$
  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,enwv_const/spec_wave,sigab_o2,thick=thck,color=colors[3],/overplot
cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
  symcolors=colors[2:3],alignment=legend_algn,/box,Location=box_loc_r


cgplot,spec_wave,sigi_o2,thick=thck,color=colors[2],/noerase,$
  xtitle=xt_wv,ytitle=yt,title=maj[1]+tilt,psym=symb,$
  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,spec_wave,sigab_o2,thick=thck,color=colors[3],/overplot  
cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
  symcolors=colors[2:3],alignment=legend_algn,/box,Location=box_loc_l

;cgPS_Close, /PNG, /Delete_PS, Width=600

;cgps2pdf,loc+filenames[1]+ext[0],$
;         loc+filenames[1]+ext[1], gs_path='C:\Program Files\gs\gs9.27'
;cgps_close,/pdf


cgdisplay,1000,1000, /free
;cgps_open, filename=loc+filenames[2]+ext[0]
cgplot,enwv_const/spec_wave,sigi_n2,thick=thck,color=colors[4],$
  xtitle=xt_e,ytitle=yt,psym=symb,$
  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,enwv_const/spec_wave,sigab_n2,thick=thck,color=colors[5],/overplot
cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
  symcolors=colors[4:5],alignment=legend_algn,/box,Location=box_loc_r


cgplot,spec_wave,sigi_n2,thick=thck,color=colors[4],/noerase,$
  xtitle=xt_wv,ytitle=yt,title=maj[2]+tilt,psym=symb,$
  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,spec_wave,sigab_n2,thick=thck,color=colors[5],/overplot
cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
  symcolors=colors[4:5],alignment=legend_algn,/box,Location=box_loc_l



;....................................................................................................
;....................................................................................................
sp_ind = [0:137]; not putting a check in the counting cuz there are extra bins in the nrl spectra!!
wavelength=wavelength(sp_ind)
spectrum1=spectrum1(sp_ind)
spectrum2=spectrum2(sp_ind)
spectrum3=spectrum3(sp_ind)
spectrum4=spectrum4(sp_ind)
spectrum5=spectrum5(sp_ind)
background_spectrum=background_spectrum(sp_ind)
spectrum=abs(background_spectrum(sp_ind)-spectrum1(sp_ind))  ; change this to get different spectra





;Plot variables...............

xr_wv=[0.1,1.5e3] ;xr=[1.,1.5e4]
yr_wv=[1.e-20,1.e-6];[0.,3.e-16]  
xr_en=[1.e1,2.e4];xr_en=[0.,100.]   
yr_en=[1.e-20,1.e-6]  ;  
xlg=1
ylg=1

yt='flux*area (#/s)'
tilt='spectral flux* cross sections (NRL & Hinteregger) '
leg_tilt=['NRL Ionz','NRL Absorp','Hint Ioniz','Hint Absorp']
plt_sym=[15,15,15,15]
thck1=1

box_loc_l=[0.45, 0.90]
box_loc_r=[0.9, 0.41]

;Ionisation & absorption X solar flux
;#1
cgdisplay,1000,1000, /free
cgplot,enwv_const/spec_wave,spectrum*sigi_o,thick=thck,color=colors[0],$
  xtitle=xt_e,ytitle=yt,psym=symb,$
  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,enwv_const/spec_wave,spectrum*sigab_o,thick=thck,color=colors[1],/overplot
cgplot,enwv_const/hintwvln,hintflux*result_ionz_o,thick=thck,color=colors[6],/overplot,psym=symb
cgplot,enwv_const/hintwvln,hintflux*result_abs_o,thick=thck1,color=colors[7],/overplot
cglegend, titles=leg_tilt,psyms=plt_sym,$
  symcolors=[colors[0:1],colors[6:7]],alignment=legend_algn,/box,Location=box_loc_r

cgplot,spec_wave,spectrum*sigi_o,thick=thck,color=colors[0],/noerase,$
  xtitle=xt_wv,ytitle=yt,title=maj[0]+tilt,psym=symb,$
  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,spec_wave,spectrum*sigab_o,thick=thck,color=colors[1],/overplot
cgplot,hintwvln,hintflux*result_ionz_o,thick=thck,color=colors[6],/overplot,psym=symb
cgplot,hintwvln,hintflux*result_abs_o,thick=thck1,color=colors[7],/overplot
cglegend, titles=leg_tilt,psyms=plt_sym,$
  symcolors=[colors[0:1],colors[6:7]],alignment=legend_algn,/box,Location=box_loc_l


;#2
cgdisplay,1000,1000, /free
cgplot,enwv_const/spec_wave,spectrum*sigi_o2,thick=thck,color=colors[2],$
  xtitle=xt_e,ytitle=yt,psym=symb,$
  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,enwv_const/spec_wave,spectrum*sigab_o2,thick=thck,color=colors[3],/overplot
cgplot,enwv_const/hintwvln,hintflux*result_ionz_o2,thick=thck,color=colors[8],/overplot,psym=symb
cgplot,enwv_const/hintwvln,hintflux*result_abs_o2,thick=thck1,color=colors[9],/overplot
cglegend, titles=leg_tilt,psyms=plt_sym,$
  symcolors=[colors[2:3],colors[8:9]],alignment=legend_algn,/box,Location=box_loc_r

cgplot,spec_wave,spectrum*sigi_o2,thick=thck,color=colors[2],/noerase,$
  xtitle=xt_wv,ytitle=yt,title=maj[1]+tilt,psym=symb,$
  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,spec_wave,spectrum*sigab_o2,thick=thck,color=colors[3],/overplot
cgplot,hintwvln,hintflux*result_ionz_o2,thick=thck,color=colors[8],/overplot,psym=symb
cgplot,hintwvln,hintflux*result_abs_o2,thick=thck1,color=colors[9],/overplot
cglegend, titles=leg_tilt,psyms=plt_sym,$
  symcolors=[colors[2:3],colors[8:9]],alignment=legend_algn,/box,Location=box_loc_l


;#3
cgdisplay,1000,1000, /free

cgplot,enwv_const/spec_wave,spectrum*sigi_n2,thick=thck,color=colors[4],$
  xtitle=xt_e,ytitle=yt,psym=symb,$
  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,enwv_const/spec_wave,spectrum*sigab_n2,thick=thck,color=colors[5],/overplot
cgplot,enwv_const/hintwvln,hintflux*result_ionz_n2,thick=thck,color=colors[10],/overplot,psym=symb
cgplot,enwv_const/hintwvln,hintflux*result_abs_n2,thick=thck1,color=colors[11],/overplot
cglegend, titles=leg_tilt,psyms=plt_sym,$
  symcolors=[colors[4:5],colors[10:11]],alignment=legend_algn,/box,Location=box_loc_r


cgplot,spec_wave,spectrum*sigi_n2,thick=thck,color=colors[4],/noerase,$
  xtitle=xt_wv,ytitle=yt,title=maj[2]+tilt,psym=symb,$
  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
cgplot,spec_wave,spectrum*sigab_n2,thick=thck,color=colors[5],/overplot
cgplot,hintwvln,hintflux*result_ionz_n2,thick=thck,color=colors[10],/overplot,psym=symb
cgplot,hintwvln,hintflux*result_abs_n2,thick=thck1,color=colors[11],/overplot
cglegend, titles=leg_tilt,psyms=plt_sym,$
  symcolors=[colors[4:5],colors[10:11]],alignment=legend_algn,/box,Location=box_loc_l




  ; NRL Spectrum plot


  cgdisplay,1000,1000, /free
  cgplot,enwv_const/wavelength,spectrum,thick=thck,color=colors[0],$
    xtitle=xt_e,ytitle='Solar Flux (photons/cm^2/s)',$
    position=pos1,xr=[1.e0,1.e5],yr=[1.e-5,1.e15], xlog=1,ylog=1,/xs,/ys

  cgplot,wavelength,spectrum,thick=thck,color=colors[0],/noerase,$
    xtitle=xt_wv,ytitle='Solar Flux (photons/cm^2/s)',title='Solar Spectrum',$
    position=pos2,xr=[0.1,1750.],yr=[1.e-5,1.e15], xlog=1,ylog=1,/xs,/ys



;Interpolating hinteregger to new cross-sections bins....................
;result_hint=exp(interpol(alog(hintflux),alog(hintwvln),alog(spec_wave)))

;xr_wv=[0.1,1.5e3] ;xr=[1.,1.5e4]
;yr_wv=[1.e-20,1.e-6];[0.,3.e-16]
;xr_en=[1.e1,2.e4];xr_en=[0.,100.]
;yr_en=[1.e-20,1.e-6]  ;
;xlg=1
;ylg=1

;yt='spectral flux*Cross section (#/s)'
;tilt='Interpolation with Hinteregger flux '
;filenames=['o_fluxcross','o2_fluxcross','n2_fluxcross']


cgdisplay,1000,1000, /free
cgplot,enwv_const/hintwvln,hintflux,thick=thck,color=colors[0],$
  xtitle=xt_e,ytitle='Solar Flux (photons/cm^2/s)',$
  position=pos1,xr=[1.e0,1.e3],yr=[1.e4,1.e12], xlog=1,ylog=1,/xs,/ys

cgplot,hintwvln,hintflux,thick=thck,color=colors[0],/noerase,$
  xtitle=xt_wv,ytitle='Solar Flux (photons/cm^2/s)',title='Hinteregger Solar Spectrum',$
  position=pos2,xr=[1.e1,5.e3],yr=[1.e4,1.e12], xlog=1,ylog=1,/xs,/ys



;;Ionisation & absorption X solar flux
;cgdisplay,1000,1000, /free
;;cgps_open, filename=loc+filenames[0]+ext[0]
;cgplot,enwv_const/spec_wave,result_hint*sigi_o,thick=thck,color=colors[0],$
;  xtitle=xt_e,ytitle=yt,psym=symb,$
;  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
;cgplot,enwv_const/spec_wave,result_hint*sigab_o,thick=thck,color=colors[1],/overplot
;cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
;  symcolors=colors[0:1],alignment=legend_algn,/box,Location=box_loc_r
;
;cgplot,spec_wave,result_hint*sigi_o,thick=thck,color=colors[0],/noerase,$
;  xtitle=xt_wv,ytitle=yt,title=maj[0]+tilt,psym=symb,$
;  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
;cgplot,spec_wave,result_hint*sigab_o,thick=thck,color=colors[1],/overplot
;cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
;  symcolors=colors[0:1],alignment=legend_algn,/box,Location=box_loc_l
;
;
;
;cgdisplay,1000,1000, /free
;;cgps_open, filename=loc+filenames[1]+ext[0]
;cgplot,enwv_const/spec_wave,result_hint*sigi_o2,thick=thck,color=colors[2],$
;  xtitle=xt_e,ytitle=yt,psym=symb,$
;  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
;cgplot,enwv_const/spec_wave,result_hint*sigab_o2,thick=thck,color=colors[3],/overplot
;cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
;  symcolors=colors[2:3],alignment=legend_algn,/box,Location=box_loc_r
;
;cgplot,spec_wave,result_hint*sigi_o2,thick=thck,color=colors[2],/noerase,$
;  xtitle=xt_wv,ytitle=yt,title=maj[1]+tilt,psym=symb,$
;  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
;cgplot,spec_wave,result_hint*sigab_o2,thick=thck,color=colors[3],/overplot
;cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
;  symcolors=colors[2:3],alignment=legend_algn,/box,Location=box_loc_l
;
;
;cgdisplay,1000,1000, /free
;cgplot,enwv_const/spec_wave,result_hint*sigi_n2,thick=thck,color=colors[4],$
;  xtitle=xt_e,ytitle=yt,psym=symb,$
;  position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
;cgplot,enwv_const/spec_wave,result_hint*sigab_n2,thick=thck,color=colors[5],/overplot
;cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
;  symcolors=colors[4:5],alignment=legend_algn,/box,Location=box_loc_r
;
;cgplot,spec_wave,result_hint*sigi_n2,thick=thck,color=colors[4],/noerase,$
;  xtitle=xt_wv,ytitle=yt,title=maj[2]+tilt,psym=symb,$
;  position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
;cgplot,spec_wave,result_hint*sigab_n2,thick=thck,color=colors[5],/overplot
;cglegend, titles=['Ionisation','Absorption'],psyms=[15,15],$
;  symcolors=colors[4:5],alignment=legend_algn,/box,Location=box_loc_l
;
;
;

;cgps2pdf,loc+'cross_sec_plots.ps',$
;  loc+'cross_sec_plots.pdf', gs_path='C:\Program Files\gs\gs9.27'
;cgps_close,/pdf



end

