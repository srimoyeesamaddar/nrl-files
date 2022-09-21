pro solar_spectra

; Reads and compares different solar spectra
;adding a test comment
 
 h=6.62607015e-34 ; Planck's Constant J.s
 c=3.e8   ;velocity of light ms-1
 loc='C:\Users\srimo\Desktop\nrl_files\'
;____________________________________________________________________________________________________________________________________________________________________

;; #1 EUVAC file
;lmax = 123 ; number of wavelength bins
;waves=fltarr(lmax)
;wavel=fltarr(lmax)
;sflux=fltarr(lmax) ; solar spectrum
;rflux=fltarr(lmax)
;a=fltarr(lmax)
;
;openr,lun,'C:\Users\srimo\Desktop\ssflux_euvac.dat',/get_lun
;s='a string'
;readf,lun,s
;for l=0,lmax-1 do begin
;     readf,lun,wvs,wvl,fg,aa
;     waves(l)=wvs
;     wavel(l)=wvl
;     rflux(l)=fg
;     a(l)=aa
;endfor
;
;free_lun,lun
;
;f107=137.8
;f107a=157.077
;P107 = (F107+F107A)/2.
;
;for L=0,LMAX-1 do begin
;          SFLUX(L) = RFLUX(L) * (1. + A(L)*(P107-80.))
;          IF (SFLUX(L) LT 0.8*RFLUX(L)) then SFLUX(L) = 0.8*RFLUX(L)
;endfor
;;print,waves
;wv1=waves
;wv2=wavel
;ssflux=sflux
;print, wv1
;wv_avg=(wv1+wv2)/2.
;save, wv1,wv2,ssflux,filename=loc+'\sav_files\euvac_spec.sav'
;;____________________________________________________________________________________________________________________________________________________________________
;
;; #2 NRL spectrum  1st version
;
;
;restore, loc+'sample_spectra.sav'
;;for i=0, n_elements(wavelength)-1 do $
;;        print,i, wavelength_low(i), '-',wavelength_high(i), wavelength(i)
;
;;  Sav file has:
;;  wavelength=(wavelength_low+wavelength_high)/2.
;; wavelength_low
;; wavelength_high
;;spectrum1,spectrum2,spectrum3,spectrum4,spectrum5,background_spectrum
;
;;;NRL spectra 2nd batch of files for 23jul2016 and 04nov2003
;;Irradiance data in ergs s-1 cm-2 ;Converting into photons s-1 cm-2
;
;
;restore, loc+'\sav_files\irradiance_23jul2016.sav'
;;file has : background_spectrum, spectrum1000,spectrum2000, spectrum3000, spectrum4000,spectrum500
;;           wavelength,wavelength_high, wavelength_low
;
;
;freq= c/(wavelength*1e-10)   ;s-1
;spectrum1=spectrum1000*1e-7/(h*freq)
;spectrum2=spectrum2000*1e-7/(h*freq)
;spectrum3=spectrum3000*1e-7/(h*freq)
;spectrum4=spectrum4000*1e-7/(h*freq)
;spectrum5=spectrum500*1e-7/(h*freq)
;
;save,background_spectrum, spectrum1,spectrum2, spectrum3, spectrum4,spectrum5,$
;     wavelength,wavelength_high, wavelength_low,$
;     filename=loc+'\sav_files\irradiance_23jul2016_myver.sav'
;
;
;restore,loc+ '\sav_files\irradiance_04nov2003.sav'
;;file has : background_spectrum, spectrum1000,spectrum10000, spectrum2000, spectrum500,spectrum5000
;;           wavelength,wavelength_high, wavelength_low
;
;freq= c/(wavelength*1e-10)   ;s-1
;spectrum1=spectrum1000*1e-7/(h*freq)
;spectrum2=spectrum10000*1e-7/(h*freq)
;spectrum3= spectrum2000*1e-7/(h*freq)
;spectrum4=spectrum500*1e-7/(h*freq)
;spectrum5=spectrum5000*1e-7/(h*freq)
;
;save, background_spectrum, spectrum1,spectrum2, spectrum3, spectrum4,spectrum5,$
;      wavelength,wavelength_high, wavelength_low,$
;      filename=loc+'\sav_files\irradiance_04nov2003_myver.sav'
;
;
;restore,'C:\Users\srimo\Desktop\nrl_files\sav_files\x28_custombins.sav'
;;file has : background_spectrum, spectrum[334,156], wavelength,wavelength_high, wavelength_low
;
;freq= c/(wavelength*1e-10)   ;s-1
;spectrum_new=fltarr(334,156)
;for i=0,333 do $
;     
;     spectrum_new[i,*]=spectrum[i,*]*1e-7/(h*freq)
;    
;spectrum=spectrum_new  
;  
;save, background_spectrum, spectrum,wavelength,wavelength_high, wavelength_low,$
;  filename=loc+'\sav_files\x28_custombins_myver.sav'
;  
;;____________________________________________________________________________________________________________________________________________________________________  
;  #3 Solomon and Qian 2005
wavelength_low=[0.5,4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,650.,798.,798.,798.,913.,$
                913.,913.,975.,987.,1027.]
                
wavelength_high=[4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,798.,798.,913.,913.,913.,$
                975.,975.,975.,987.,1027.,1050.]
                
fref=[5.010e1,1.000e4,2.000e6,2.850e7,5.326e8,1.270e9,5.612e9,4.342e9,8.380e9,2.861e9,4.830e9,$
      1.459e9,1.142e9,2.364e9,3.655e9,8.448e8,3.818e8,1.028e9,7.156e8,4.482e9,4.419e9,4.235e9]
      
A_fac=[6.240e-1,3.71e-1,2.000e-1,6.247e-2,1.343e-2,9.182e-3,1.433e-2,2.575e-2,7.059e-3,1.458e-2,$
       5.857e-3,5.719e-3,3.680e-3,5.310e-3,5.261e-3,5.437e-3,4.915e-3,4.955e-3,4.422e-3,3.950e-3,$
       5.021e-3,4.825e-3] 
               
save, wavelength_low,wavelength_high,fref,A_fac,filename=loc+'\sav_files\Solomon_Qian2005.sav'

;____________________________________________________________________________________________________________________________________________________________________

;; NRL test spectrum.....SQ'05 + Fe line
;restore,  loc+'\sav_files\x9_stanbands.sav'
;
;wave_hi= fltarr(n_elements(wave_gcm1))
;ii=sort(wave_gcm1)
;wave_lo=wave_gcm1[ii]
;wave_hi[0:-2]=wave_lo[1:-1]
;wave_hi[-1]=1750. 
;spectrum= flux_qrj[ii,*]
;
;save, wave_lo, wave_hi,spectrum, filename= loc+'\sav_files\x9_stanbands_myver.sav'
;
;restore,  loc+'\sav_files\m5_stanbands.sav'
;wave_hi= fltarr(n_elements(wave_gcm1))
;ii=sort(wave_gcm1)
;wave_lo=wave_gcm1[ii]
;wave_hi[0:-2]=wave_lo[1:-1]
;wave_hi[-1]=1750.
;spectrum= flux_qrj[ii,*]
;
;save,wave_lo, wave_hi, spectrum, filename=loc+'\sav_files\m5_stanbands_myver.sav'

close,/all
;____________________________________________________________________________________________________________________________________________________________________
;____________________________________________________________________________________________________________________________________________________________________

;..........................................PLOTS.....................................................
;....................................................................................................
;;window,plot_ind, xsize=1000, ysize=1000
;cgdisplay,1000,1000, /free
;cgps_open, filename='C:\Users\srimo\Desktop\nrl_files\plots2\solar_spectra.ps'
;
;cgplot, 12397./wavelength, abs(spectrum1-background_spectrum) ,color='purple',thick=3,$
;        /yl,/ys ,yr=[1.e-5,1.e15],xr=[1.,1.e5], /xs,/xl,$
;        xtitle='Energy (eV)',ytitle='Flux (Photons cm$\up-2$ s$\up-1$)'
;cgplot, 12397./wavelength, abs(spectrum2-background_spectrum) ,color='violet',/overplot,thick=3
;cgplot, 12397./wavelength, abs(spectrum3-background_spectrum) ,color='turquoise',/overplot,thick=3
;cgplot, 12397./wavelength, abs(spectrum4-background_spectrum)  ,color='dodger blue',/overplot, thick=3.
;cgplot, 12397./wavelength, abs(spectrum5-background_spectrum) ,color='blue',/overplot,thick=3.
;cgplot, 12397./wavelength, background_spectrum ,color='charcoal',/overplot,thick=3.
;cgplot, 12397./wv_avg, ssflux ,color='red',/overplot,thick=3.
;
;cglegend, titles=['Spectrum1','Spectrum2','Spectrum3','Spectrum4','Spectrum5','Background','EUVAC'],$
;          psyms=[-15,-15,-15,-15,-15,-15,-15],$ 
;          symcolors=['purple','violet','turquoise','dodger blue','blue','charcoal','red'],$
;          alignment=1,/box,Location=[0.9, 0.9]
;
;
;
;
;cgdisplay,1000,1000, /free
;
;cgplot, wavelength, abs(spectrum1-background_spectrum) ,color='purple',thick=3,$
;       /ys,/yl ,xr=[0.,2000.], /xs,yr=[1.e4,3.e12],$;
;  xtitle='Wavelength (A)',ytitle='Flux (Photons cm$\up-2$ s$\up-1$)'
;cgplot, wavelength, abs(spectrum2-background_spectrum) ,color='violet',/overplot,thick=3
;cgplot, wavelength, abs(spectrum3-background_spectrum) ,color='turquoise',/overplot,thick=3
;cgplot, wavelength, abs(spectrum4-background_spectrum)  ,color='dodger blue',/overplot, thick=3.
;cgplot, wavelength, abs(spectrum5-background_spectrum) ,color='blue',/overplot,thick=3.
;cgplot, wavelength, background_spectrum ,color='charcoal',/overplot,thick=3.
;cgplot, wv_avg, ssflux ,color='red',/overplot,thick=3.
;
;cglegend, titles=['Spectrum1','Spectrum2','Spectrum3','Spectrum4','Spectrum5','Background','EUVAC'],$
;  psyms=[-15,-15,-15,-15,-15,-15,-15],$
;  symcolors=['purple','violet','turquoise','dodger blue','blue','charcoal','red'],$
;  alignment=1,/box,Location=[0.9, 0.9]
;
;cgps2pdf,'C:\Users\srimo\Desktop\nrl_files\plots2\solar_spectra.ps',$
;         'C:\Users\srimo\Desktop\nrl_files\plots2\solar_spectra.pdf', gs_path='C:\Program Files\gs\gs9.27'
;cgps_close,/pdf


end
