;Comparing the different solar flux available
;Hinteregger, SQ'05 and NRL stanbands




;_____________________________________ #1 Hinteregger solar flux__________________________________________________-

file_hint= '/home/srimoyee/Desktop/bailey_bins/sc21refw.dat'
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




;___________________________________________#2 Solomon and Qian 2005_______________________________________________

filename='/home/srimoyee/Desktop/nrl_files/sav_files/Solomon_Qian2005.sav'
;file has:A_fac, fref, wavelength_low, wavelength_high
restore, filename
F107=100.
F107a=100.

P107 = (F107+F107A)/2.
n_wvl=n_elements(a_fac)
SQ_ssflux= fltarr(n_wvl)

for L=0,n_wvl-1 do begin
  SQ_SSFLUX(L) = fref(L) * (1. + A_fac(L)*(P107-80.))
  IF (SQ_SSFLUX(L) LT 0.8*fref(L)) then SQ_SSFLUX(L) = 0.8*fref(L)
endfor



;______________________________________________#3 NRL with  Fe line________________________________________________

file='/home/srimoyee/Desktop/nrl_files/sav_files/x9_stanbands_myver.sav'
; file has: wave_lo, wave_hi,spectrum
restore, file
x9_wv1=wave_lo
X9_wv2=wave_hi
X9_ssflux=spectrum[*,720]


file='/home/srimoyee/Desktop/nrl_files/sav_files/m5_stanbands_myver.sav'
; file has: wave_lo, wave_hi,spectrum
restore, file
m5_wv1=wave_lo
m5_wv2=wave_hi
m5_ssflux=spectrum[*,316]

;_______________________________________________________________________________________________________________________________________________

restore, '/home/srimoyee/Desktop/nrl_files/sav_files/newspectra.sav'

;file has: wave_gcm1,wave_gcm2,meanpeakx9,peakm5





;____________________________________________________PLOTS______________________________________________________________________________________

plt_loc="/home/srimoyee/Desktop/nrl_files/ssflux_comp/"

;Universal Plot variables

xg=0 ;gridstyles
yg=0
xtl=1.  ;ticklen
ytl=1.
xsg=1
ysg=1
xstl=1.
ystl=1.
colors=['red','black','dodger blue','olive']
lstyl=[0,2,3,4,1]
postop=[0.1,0.5,0.45,0.95]
posbot=[0.1,0.1,0.45,0.45]
hst=1 ;for histogram
thck=5.
leg_loc=[0.90, 0.85]
leg_loc_left=[0.35, 0.87]
leg_nam=['Hinteregger ','SQ2005 ','NRL M5 ','NRL X9']

;__________________________________________________________________


;Spectra plots

xr=[min([hintwvln,wavelength_low,m5_wv1,x9_wv2]),max([hintwvln,wavelength_low,m5_wv1,x9_wv2])]
;yr=[1.e4,1.e12]
yr=[min([hintflux,SQ_ssflux,m5_ssflux,x9_ssflux]),max([hintflux,SQ_ssflux,m5_ssflux,x9_ssflux])]
xt='Wavelength ($\AA$)'
yt='Solar Flux (Photons cm!U-2!N s!U-1!N))'
titl="Solar Flux Comparison"


w1=window(window_title='Solar Flux',dimension=[800,800])

s1=plot(hintwvln, hintflux, name=leg_nam[0],$
         xtitle=xt,ytitle=yt,title=titl,$
         xrange=xr,yrange=yr,ylog=1,ystyle=1,xlog=1,xstyle=1,$;xrange=xr,yrange=yr,
         xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
         thick=thck,histogram=hst,color=colors[0],linestyle=lstyl[0],/current)

s2=plot(wavelength_low, SQ_ssflux, name=leg_nam[1],$
         thick=thck,histogram=hst,color=colors[1],linestyle=lstyl[1],/overplot)

s3=plot(m5_wv1, m5_ssflux, name=leg_nam[2],$
         thick=thck,histogram=hst,color=colors[2],linestyle=lstyl[2],/overplot)

s4=plot(x9_wv1, x9_ssflux, name=leg_nam[3],$
         thick=thck,histogram=hst,color=colors[3],linestyle=lstyl[3],/overplot)

;a1 = ARROW([1.9,1.9], [max(spectrum),min(spectrum)], COLOR='blue', /DATA, /CURRENT)
;t1 = TEXT(0.27,0.67,'Fe line', /normal,font_size=14, font_color='blue')

leg1 = LEGEND(TARGET=[s1,s2,s3,s4], POSITION=leg_loc_left,/normal)

w1.Save, plt_loc+"solarflux_comp.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT







xr=[min(wave_gcm1),max(wave_gcm2)]
yr=[1.e4,1.e12]
;yr=[min([hintflux,SQ_ssflux,m5_ssflux,x9_ssflux]),max([hintflux,SQ_ssflux,m5_ssflux,x9_ssflux])]
xt='Wavelength ($\AA$)'
yt='Solar Flux (Photons cm!U-2!N s!U-1!N))'
titl="X9 Sept6, 2017 Solar Flux"


w2=window(window_title='Solar Flux',dimension=[600,600])

s1=plot(wave_gcm1,meanpeakx9,$
  xtitle=xt,ytitle=yt,title=titl,$
  xrange=xr,yrange=yr,ylog=1,ystyle=1,xlog=1,xstyle=1,$;xrange=xr,yrange=yr,
  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
  thick=thck,histogram=hst,color=colors[0],linestyle=lstyl[0],/current)








end