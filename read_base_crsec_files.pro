 pro read_base_crsec_files

; Reading old cross-section  files and making new baseline cross-section files for O, O2 and N2
 ;____________________________________________________________________________________________________________

floc='/home/srimoyee/Desktop/bailey_bins/'
savloc='/home/srimoyee/Desktop/nrl_files/sav_files/'
 ;____________________________________________________________________________________________________________

 
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


 ;____________________________________________________________________________________________________________
 ;____________________________________________________________________________________________________________

; Fennely data from 23A
   
  ;N2 and O2:
  ;Column 1: wavelength      **
  ;Column 2:N2 absorption    **
  ;Column 3:N2+
  ;Column 4: N+ (from N2)
  ;Column 5: N2 ionisation   **
  ;Column 6: O2 absorption   **
  ;Column 7: O2+
  ;Column 8: O+ (from O2)
  ;Column 9:O2 ionsation     **
  ;Column 10:N ionsation
  
  n_rows_fenn= 1944
  n_columns_fenn=10
  
  fenncross_data=dblarr(n_columns_fenn,n_rows_fenn)

  file_fenn=floc+'phfenn.tab'
  openr, lun_fenn, file_fenn, /get_lun
  skip_lun, lun_fenn, 2, /lines ; 2 header lines
  readf, lun_fenn ,fenncross_data
  free_lun, lun_fenn
  
  ;____________________________________________________________________________________________________________
  
  ;O:
  ;Column 1: wavelength     **
  ;Column 2:O+(4So)
  ;Column 3:O+(2Do)
  ;Column 4:O+(2Po)
  ;Column 5: O+(4Pe)
  ;Column 6: O+(2Pe)
  ;Column 7: O++
  ;Column 8: O+(total)      **

  n_rows_fenno= 1944
  n_columns_fenno= 8
  
  fennocross_data=dblarr(n_columns_fenno,n_rows_fenno)

  file_fenno=floc+'phfenno.tab'
  openr, lun_fenno, file_fenno, /get_lun
  skip_lun, lun_fenno, 2, /lines ; 2 header lines
  readf, lun_fenno ,fennocross_data
  free_lun, lun_fenno
;____________________________________________________________________________________________________________

  
;  Adding some extra bins for O2 data from Watanbe 1956 & 1958
watanbe_wvl=[1027.6,1029.4,1030.8,1032.2,1034.3,1035.5,1036.6,1038.4,1040.,1044.2,1045.3,1047.2,1049.1,1050.7,$
             1052.3,1054.5,1055.3,1058.2,1060.2,1061.5,1063.4,1064.8,1066.,1069.4,1072.3,1074.,1076.2,$
             1079.3,1081.2,1084.1,1086.4,1088.2,1089.4,1094.2,1100.1,1104.2,$
             1107.8, 1108.3,1108.9,1109.9,1110.5,1126.9,1142.8,1143.0, 1144.3, 1145.3,1157.0,1157.4,$
             1166.1, 1166.8,1167.2,1186.6,1187.1,1187.8,1188.3,1188.9,1214.8,1215.0,1215.7,1216.5,1217.3]
           
          
n0=2.69e19 
watanbe_o2_abs=[31.1,40.5,28.,30.,34.,17.,19.,31.,46.,4.,9.,46.,61.,14.,62.,21.,14.,$
               23.,32.,17.,39.,64.,101.,2.4,24.,24.,6.,$          
               22., 54.,56.,10.,15.,16.,1.1,15.,30.,$               
               0.32,0.11, 0.25,0.35,0.48,0.53,0.26,0.33,0.65,0.70,0.51,0.60,0.52,0.27,$
               0.35, 0.35,0.18,0.25,0.39,0.64, 0.70,0.50,0.27,0.40,0.60]/n0
             
watnabe_o2_1958file='/home/srimoyee/Desktop/nrl_files/sav_files/watanabe_o2abscrosssection.csv'              
watnabe_o2_1958= READ_CSV(watnabe_o2_1958file)
watnabe_o2_1958_wv=watnabe_o2_1958.field1
watnabe_o2_1958_abs=watnabe_o2_1958.field2*1.e-18


watanbe_wvl=[watanbe_wvl,watnabe_o2_1958_wv]
watanbe_o2_abs=[watanbe_o2_abs,watnabe_o2_1958_abs]
watanbe_o2_ionz=[0.22,0.033,0.007,dblarr(n_elements(watanbe_wvl)-3)] *1.e-18
;____________________________________________________________________________________________________________
;____________________________________________________________________________________________________________


;New base cross-section files 

;New O cross-section files

wave_o=[henke_wvl,reform(fennocross_data[0,*])]
totionz_o=[henke_o,reform(fennocross_data[7,*]*1.e-18)]
totabs_o=totionz_o

;New O2 cross-section files

;wave_o2=[henke_wvl,reform(fenncross_data[0,*])]
;totionz_o2=[henke_o2,reform(fenncross_data[8,*]*1.e-18)]
;totabs_o2=[henke_o2,reform(fenncross_data[5,*]*1.e-18)]


;Adding the Watanabe Data here
wave_o2=[henke_wvl,reform(fenncross_data[0,*]),watanbe_wvl]
totionz_o2=[henke_o2,reform(fenncross_data[8,*]*1.e-18),watanbe_o2_ionz]
totabs_o2=[henke_o2,reform(fenncross_data[5,*]*1.e-18),watanbe_o2_abs]


;New N2  cross-section files

wave_n2=[henke_wvl,reform(fenncross_data[0,*])]
totionz_n2=[henke_n2,reform(fenncross_data[4,*]*1.e-18)]
totabs_n2=[henke_n2,reform(fenncross_data[1,*]*1.e-18)]

save, wave_o,wave_o2,wave_n2,totionz_o,totionz_o2,totionz_n2,totabs_o,totabs_o2,totabs_n2,$
      filename= savloc+'ion&abs_cross_files.sav'


;save, wave_o,wave_o2,wave_n2,sigi_o,sigi_o2,sigi_n2,sigab_o,sigab_o2,sigab_n2,$
;  filename= 'C:\Users\Srimoyee\Desktop\nrl_files\ion_cross_tmp.sav'

;____________________________________________________________________________________________________________
;____________________________________________________________________________________________________________

close,/all

openw,lun_nbO,savloc+'O_cross.dat',/get_lun
printf, lun_nbO,'Wavelength (A)','Energy (eV)','O Ion(cm^2)','O Abs(cm^2)'
for i=0,n_elements(wave_o)-1 do $
         printf,lun_nbO,wave_o(i),'  ',12397./wave_o(i),'  ',totionz_o(i),'  ',totabs_o(i)
         
openw,lun_nbO2,savloc+'O2_cross.dat',/get_lun
printf, lun_nbO2,'Wavelength (A)','Energy (eV)','O2 Ion(cm^2)','O2 Abs(cm^2)'
for i=0,n_elements(wave_o2)-1 do $
    printf,lun_nbO2,wave_o2(i),'  ',12397./wave_o2(i),'  ',totionz_o2(i),'  ',totabs_o2(i)

openw,lun_nbN2,savloc+'N2_cross.dat',/get_lun
printf, lun_nbN2,'Wavelength (A)','Energy (eV)','N2 Ion(cm^2)','N2 Abs(cm^2)'
for i=0,n_elements(wave_n2)-1 do $
    printf,lun_nbn2,wave_n2(i),'  ',12397./wave_n2(i),'  ',totionz_n2(i),'  ',totabs_n2(i)

free_lun,lun_nbO,lun_nbO2,lun_nbN2


end











