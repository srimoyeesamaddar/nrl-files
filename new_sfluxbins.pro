 pro new_sfluxbins

; code for new solar flux bins in x-ray range
; has the Auger wavelengths as the edges of the bins

wv=[23.,23.,30.,43.6]  ;wv in angstrom 0-O, 1-O2, 2-N2, 3-C; Auger edges
en=12397./wv  ; in eV
;print, en

;Setting up new energy bins.........................

;#1
a_1=alog(en[0]) ;binning is made with log(energy) bins
d=0.1    ;difference in energy bins 0.1 log eV
n=40
en_series_1=a_1+findgen(n)*d
wv_series_1=exp(alog(12397.)-en_series_1)
;print, en_series_1
wv_1=reverse(wv_series_1)
;print,wv_1


;#2
;Adding the EUVAC bins longward of 44A to new bin file

lmax = 123 ; number of wavelength bins in EUVAC
waves=fltarr(lmax)
wavel=fltarr(lmax)
rflux=fltarr(lmax)
a=fltarr(lmax)

openr,lun,'C:\Users\srimo\Desktop\localpe\ssflux_euvac.dat',/get_lun
s='a string'
readf,lun,s
for l=0,lmax-1 do begin
  readf,lun,wvs,wvl,fg,aa
  waves(l)=wvs
  wavel(l)=wvl
  rflux(l)=fg
  a(l)=aa
endfor
free_lun,lun

euvac_begin_wv=44. ;taking euvac bins starting from this wavlength
wvs_ind= where(waves eq euvac_begin_wv)

;print,n_elements(waves[wvs_ind:-1])

; Final new wavelength bins
wave1=[wv_1,wv[2],waves[wvs_ind:-1]]
wave2=[wv_1(1:-1),wv[2],euvac_begin_wv,wavel[wvs_ind:-1]]
;print,wave1
;print,''
;print,wave2
;print, n_elements(wave1),n_elements(wave2)


save, wave1, wave2, filename='C:\Users\srimo\Desktop\nrl_files\sav_files\new_wv_bins.sav'


openw,lun_bins,'C:\Users\srimo\Desktop\nrl_files\sav_files\new_wv_bins.dat',/get_lun
printf, lun_bins,'Wavelength (A)'
for i=0,n_elements(wave2)-1 do $
  printf,lun_bins,wave1(i),' - ',wave2(i)

free_lun,lun_bins,lun



end