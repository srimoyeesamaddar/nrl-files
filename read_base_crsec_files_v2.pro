pro read_base_crsec_files_v2

  ; Reading photoionisation, photodissociation and photoabsorption cross-sections from new Leiden database

   loc='C:\Users\srimo\Desktop\nrl_files\sav_files\new_cross\'
;   file_o=loc+'O.txt'
;   file_o2=loc+'O2.txt'
;   file_n2=loc+'N2.txt'
   
   file_o=loc+'O_pt1nm.txt'
   file_o2=loc+'O2_pt1nm.txt'
   file_n2=loc+'N2_pt1nm.txt'

   
  ;O file:...........................
  ;Column 1: wavelength
  ;Column 2:photoionisation
  
wv_o=[]
ionz_o=[]
rows_o=0
wv=0.0
ionz=0.0

tic

openr, lun_o, file_o, /get_lun
skip_lun, lun_o, 9, /lines ; 9 header lines 1nm pt. file
;skip_lun, lun_o, 8, /lines ; 8 header lines 
  while (~eof(lun_o)) do begin
        readf, lun_o ,wv,ionz
        wv_o=[wv_o,wv]
        ionz_o=[ionz_o,ionz]
        rows_o+=1
  endwhile
;  print,rows_o
  free_lun, lun_o
abs_o=ionz_o

;O2 file:...........................      
;Column 1: wavelength
;Column 2:photoabsorption
;Column 3:photodissociation
;Column 4:photoionisation

wv_o2=[]
abs_o2=[]
diss_o2=[]
ionz_o2=[]
rows_o2=0
wv=0.0
absp=0.
diss=0.
ionz=0.0

openr, lun_o2, file_o2, /get_lun
skip_lun, lun_o2, 9, /lines ; 9 header lines
  while (wv le 200.) do begin  ; reading till 200 nm
        readf, lun_o2 ,wv,absp,diss,ionz
        wv_o2=[wv_o2,wv]
        abs_o2=[abs_o2,absp]
        diss_o2=[diss_o2,diss]
        ionz_o2=[ionz_o2,ionz]
        rows_o2+=1
  endwhile
  free_lun, lun_o2
  
;  o2data=dblarr(4,650002)
;  wv_o2=[]
;  abs_o2=[]
;  diss_o2=[]
;  ionz_o2=[]
;
;  openr, lun_o2, file_o2,/get_lun
;  skip_lun,lun_o2,8,/lines ;8 header lines
;  readf, lun_o2,o2data
;  wv_o2=reform(o2data[0,*])
;  abs_o2=reform(o2data[1,*])
;  diss_o2=reform(o2data[2,*])
;  ionz_o2=reform(o2data[3,*])
;  free_lun, lun_o2
  
  ;N2 file:...........................
  ;Column 1: wavelength
  ;Column 2:photoabsorption
  ;Column 3:photodissociation
  ;Column 4:photoionisation

  wv_n2=[]
  abs_n2=[]
  diss_n2=[]
  ionz_n2=[]
  rows_n2=0L
  wv=0.0
  absp=0.
  diss=0.
  ionz=0.0

  openr, lun_n2, file_n2, /get_lun
  skip_lun, lun_n2, 11, /lines ; 11 header lines 1nm pts file
  while (~eof(lun_n2)) do begin
    readf, lun_n2 ,wv,absp,diss,ionz
    wv_n2=[wv_n2,wv]
    abs_n2=[abs_n2,absp]
    diss_n2=[diss_n2,diss]
    ionz_n2=[ionz_n2,ionz]
    rows_n2+=1
  endwhile
;  print,rows_n2
  
;  n2data=dblarr(4,1906027)
;  wv_n2=[]
;  abs_n2=[]
;  diss_n2=[]
;  ionz_n2=[]
;  
;  openr, lun_n2, file_n2, /get_lun
;  skip_lun, lun_n2, 10, /lines ; 10 header lines
;  readf, lun_n2, n2data
;  wv_n2=reform(n2data[0,*])
;  abs_n2=reform(n2data[1,*])
;  diss_n2=reform(n2data[2,*])
;  ionz_n2=reform(n2data[3,*])
;
 
  free_lun, lun_n2



toc

;Converting Leiden wavelengths from nm to A
wv_o= wv_o*10.
wv_o2=wv_o2*10.
wv_n2=wv_n2*10.

;Comparing Fennely to Leiden cross-sections
restore , filename= 'C:\Users\srimo\Desktop\nrl_files\sav_files\ion&abs_cross_files.sav'
;file has:
;wave_o,wave_o2,wave_n2
;totionz_o,totionz_o2,totionz_n2
;totabs_o,totabs_o2,totabs_n2
            
xr=[0.1,2000.]
pos1=[0.1,0.1,0.9,0.4]
pos2=[0.1,0.5,0.9,0.9]


cgps_open, filename='C:\Users\srimo\Desktop\nrl_files\plots2\cross_leiden_1nm.ps'

;#1
cgdisplay, 1000,1000,/free
cgplot, wv_o,ionz_o,color='violet',thick=3,xrange=xr,$
        xtitle='wavelength',ytitle='O Ionisation cross-sections'
cgplot, wave_o,totionz_o,color='turquoise',thick=3,/overplot
cglegend, titles=['Leiden','Henke+Fennely'],psyms=[15,15],$
         symcolors=['violet','turquoise'],alignment=1,/box,Location=[0.85, 0.9]

cgdisplay, 1000,1000,/free
cgplot, wv_o,ionz_o,color='violet',thick=3,xrange=xr,$
         xtitle='wavelength',ytitle='O Ionz cross-sections (Leiden)'

cgdisplay, 1000,1000,/free
cgplot, wave_o,totionz_o,color='turquoise',thick=3,xrange=xr,$
         xtitle='wavelength',ytitle='O Ionz cross-sections (H+F)'

;#2
cgdisplay, 1000,1000,/free
cgplot, wv_o2,ionz_o2,color='purple',thick=3,xrange=xr,$
        xtitle='wavelength',ytitle='O2 Ionisation cross-sections'
cgplot, wave_o2,totionz_o2,color='dodger blue',thick=3,/overplot
cglegend, titles=['Leiden','Henke+Fennely'],psyms=[15,15],$
  symcolors=['purple','dodger  blue'],alignment=1,/box,Location=[0.85, 0.9]

cgdisplay, 1000,1000,/free
cgplot, wv_o2,ionz_o2,color='purple',thick=3,xrange=xr,$
    xtitle='wavelength',ytitle='O2 Ionz cross-sections (Leiden)'

cgdisplay, 1000,1000,/free
cgplot, wave_o2,totionz_o2,color='dodger blue',thick=3,xrange=xr,$
    xtitle='wavelength',ytitle='O2 Ionz cross-sections (H+F)'

;#3
cgdisplay, 1000,1000,/free
cgplot, wv_n2,ionz_n2,color='red',thick=3,xrange=xr,$
  xtitle='wavelength',ytitle='N2 Ionisation cross-sections'
cgplot, wave_n2,totionz_n2,color='magenta',/overplot
cglegend, titles=['Leiden','Henke+Fennely'],psyms=[15,15],thick=3,$
          symcolors=['red','magenta'],alignment=1,/box,Location=[0.85, 0.9]

cgdisplay, 1000,1000,/free
cgplot, wv_n2,ionz_n2,color='red',thick=3,xrange=xr,$
          xtitle='wavelength',ytitle='N2 Ionz cross-sections (Leiden)'

cgdisplay, 1000,1000,/free
cgplot, wave_n2,totionz_n2,color='magenta',thick=3,xrange=xr,$
        xtitle='wavelength',ytitle='N2 Ionz cross-sections (H+F)'

;#4

cgdisplay, 1000,1000,/free
cgplot, wv_o,abs_o,color='violet',thick=3,xrange=xr,$
        xtitle='wavelength',ytitle='O Absorption cross-sections'
cgplot,wave_o,totabs_o,color='turquoise',thick=3,/overplot
cglegend, titles=['Leiden','Henke+Fennely'],psyms=[15,15],$
          symcolors=['violet','turquoise'],alignment=1,/box,Location=[0.85, 0.9]

cgdisplay, 1000,1000,/free
cgplot, wv_o,abs_o,color='violet',thick=3,xrange=xr,$
        xtitle='wavelength',ytitle='O Absp cross-sections (Leiden)'

cgdisplay, 1000,1000,/free
cgplot, wave_o,totabs_o,color='turquoise',thick=3,xrange=xr,$
        xtitle='wavelength',ytitle='O Absp cross-sections (H+F)'

;#5
cgdisplay, 1000,1000,/free
cgplot, wv_o2,abs_o2,color='purple',thick=3,xrange=xr,$
        xtitle='wavelength',ytitle='O2 Absorption cross-sections'
cgplot, wave_o2,totabs_o2,color='dodger blue',/overplot
cglegend, titles=['Leiden','Henke+Fennely'],psyms=[15,15],$
          symcolors=['purple','dodger blue'],alignment=1,/box,Location=[0.85, 0.9]

cgdisplay, 1000,1000,/free
cgplot, wv_o2,abs_o2,color='purple',thick=3,xrange=xr,$
          xtitle='wavelength',ytitle='O2 Absp cross-sections (Leiden)'

cgdisplay, 1000,1000,/free
cgplot, wave_o2,totabs_o2,color='dodger blue',thick=3,xrange=xr,$
          xtitle='wavelength',ytitle='O2 Absp cross-sections (H+F)'

;#6
cgdisplay, 1000,1000,/free
cgplot, wv_n2,abs_n2,color='red',thick=3,xrange=xr,$
         xtitle='wavelength',ytitle='N2 Absorption cross-sections'
cgplot, wave_n2,totabs_n2,color='magenta',thick=3,/overplot
cglegend, titles=['Leiden','Henke+Fennely'],psyms=[15,15],$
symcolors=['red','magenta'],alignment=1,/box,Location=[0.85, 0.9]

cgdisplay, 1000,1000,/free
cgplot, wv_n2,abs_n2,color='red',thick=3,xrange=xr,$
  xtitle='wavelength',ytitle='N2 Absp cross-sections (Leiden)'

cgdisplay, 1000,1000,/free
cgplot, wave_n2,totabs_n2,color='magenta',thick=3,xrange=xr,$
  xtitle='wavelength',ytitle='N2 Absp cross-sections (H+F)'

;#7
cgdisplay, 1000,1000,/free
cgplot, wv_o2,ionz_o2,color='purple',thick=3,xrange=xr,$
   xtitle='wavelength',ytitle='O2 Leiden cross-sections'
cgplot, wv_o2,diss_o2,color='dodger blue',/overplot
cglegend, titles=['Ionsation','Dissociaton'],psyms=[15,15],$
   symcolors=['purple','dodger blue'],alignment=1,/box,Location=[0.85, 0.9]

;#8
cgdisplay, 1000,1000,/free
cgplot, wv_n2,ionz_n2,color='red',thick=3,xrange=xr,$
    xtitle='wavelength',ytitle='N2 Leiden cross-sections'
cgplot, wv_n2,diss_n2,color='magenta',/overplot
cglegend, titles=['Ionsation','Dissociaton'],psyms=[15,15],$
    symcolors=['red','magenta'],alignment=1,/box,Location=[0.85, 0.9]



cgps2pdf,'C:\Users\srimo\Desktop\nrl_files\plots2\cross_leiden_1nm.ps',$
          'C:\Users\srimo\Desktop\nrl_files\plots2\cross_leiden_1nm.pdf', gs_path='C:\Program Files\gs\gs9.27'
 cgps_close,/pdf

close,/all


; Henke data for shorter wavelengths, from Henke 1993................

henke_wvl=[0.4,0.5,0.6,0.7,0.8,1.3,1.5,1.7,1.8, 2.1,2.3,2.5,2.7,3.4,4.2,$
  4.7,5.4,6.1,7.1,8.3,9.9,10.4,11.9,12.3,13.3,14.6,16.0,17.6,$
  18.3,19.5,21.6,23.6]; in Angstrom

henke_ener=12397./henke_wvl  ;in eV

henke_n2=[9.75e-2,1.67e-1,2.98e-1,5.6e-1,9.29e-1,3.56,6.85,8.65,1.1e1,$
  1.82e1,2.37e1,3.13e1,4.17e1,7.69e1,1.46e2,2.14e2,3.18e2,4.46e2,$
  7.08e2,1.11e3,1.79e3,2.07e3,2.97e3,3.2e3,4.02e3,5.07e3,6.49e3,8.31e3,$
  9.22e3,1.07e4,1.41e4,1.73e4]*2.*23.26*1.e-24  ;ionisation cross sections in cm^2

henke_o=[1.6e-1,2.72e-1,4.83e-1,9.02e-1,1.49,5.73e,1.1e1,1.39e1,1.76e1,2.89e1,$
  3.76e1,4.94e1,6.57e1,1.2e2,2.24e2,3.25e2,4.76e2,6.61e2,1.03e3,1.6e3,$
  2.53e3,2.92e3,4.15e3,4.48e3,5.59e3,6.97e3,8.87e3,1.13e4,1.24e4,1.45e4,$
  1.87e4,1.2e4]*26.57*1.e-24  ;ionisation cross sections in cm^2

henke_o2=henke_o*2.

;New base-cross-section files version 2 (from Henke and Leiden)

wave_o=[henke_wvl,wv_o]
wave_o2=[henke_wvl,wv_o2]
wave_n2=[henke_wvl,wv_n2]
totionz_o=[henke_o,ionz_o]
totionz_o2=[henke_o2,ionz_o2]
totionz_n2=[henke_n2,ionz_n2]
totabs_o=[henke_o,abs_o]
totabs_o2=[henke_o2,abs_o2]
totabs_n2=[henke_n2,abs_n2]



save, wave_o,wave_o2,wave_n2,totionz_o,totionz_o2,totionz_n2,totabs_o,totabs_o2,totabs_n2,$
      filename= 'C:\Users\srimo\Desktop\nrl_files\sav_files\ion&abs_cross_files_v2.sav'



end











