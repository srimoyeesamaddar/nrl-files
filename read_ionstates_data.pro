pro read_ionstates_data 

; Reading the ionisation states from Conway data and making new partial ionsiation baseline files
;Should contain all the states as in Conway data starting from 18.62 A but does not  extended to lower wavelenghts

;_____________________________________________________________________________________________________________

  floc='/home/srimoyee/Desktop/bailey_bins/'
  savloc='/home/srimoyee/Desktop/nrl_files/sav_files/'

;_____________________________________________________________________________________________________________

  ;Conway data 
  
  ;Conwayo_file: O data
  ;Column 1: wavelength
  ;Column 2:Photoabsorption
  ;Column 3:4So
  ;Column 4: 2Do
  ;Column 5: 2Po
  ;Column 6: 4P
  ;Column 7: 2P
  ;Column 8: K

  n_rows_o= 645
  n_columns_o=8

  ocross_data=fltarr(n_columns_o,n_rows_o)

  file_cono=floc+'photoo.tab'
  openr, lun_cono, file_cono, /get_lun
  skip_lun, lun_cono, 2, /lines ; 2 header lines
  readf, lun_cono , ocross_data
  free_lun, lun_cono
  
  ;_____________________________________________________________________________________________________________
  
  ;    #1st method- take all the states separately
  
  O_crss_states=fltarr(7,n_rows_o)
 
  O_crss_states[0,*]=ocross_data[0,*]         ;wavelength
  O_crss_states[1,*]=ocross_data[2,*]*1.e-18  ;4So
  O_crss_states[2,*]=ocross_data[3,*]*1.e-18  ;2Do
  O_crss_states[3,*]=ocross_data[4,*]*1.e-18  ;2Po
  O_crss_states[4,*]=ocross_data[5,*]*1.e-18  ;4P
  O_crss_states[5,*]=ocross_data[6,*]*1.e-18  ;2P
  O_crss_states[6,*]=ocross_data[7,*]*1.e-18  ;K

  ;_____________________________________________________________________________________________________________

;;      #2nd method- Take the states as in SQ'05 - 4S,2D,2P
;
;  O_crss_states=fltarr(4,n_rows_o)
;
;  O_crss_states[0,*]=ocross_data[0,*]         ;wavelength
;  O_crss_states[1,*]=ocross_data[2,*]+ocross_data[7,*]*1.e-18  ;4So +K
;  O_crss_states[2,*]=ocross_data[3,*]*1.e-18  ;2Do
;  O_crss_states[3,*]=ocross_data[4,*]*1.e-18  ;2Po
  
  ;_____________________________________________________________________________________________________________
  ;_____________________________________________________________________________________________________________
  
    ;conwayo2_file: O2 data
    ;Column 1: wavelength
    ;Column 2:Photoabsorption
    ;Column 3:Photoionisation
    ;Column 4: FRAG
    ;Column 5:    O2+
    ;Column 6:   X
    ;Column 7:   a+A
    ;Column 8:    b
    ;Column 9:  B
    ;Column 10:   2pi+c
    ;Column 11:  2sig
    ;Column 12:   33 eV
    ;Column 13: 2,4sig
    ;Column 14:   K
  
    n_rows_o2= 808
    n_columns_o2=14
  
  
    o2cross_data=fltarr(n_columns_o2,n_rows_o2)
    file_cono2=floc+'photoo2.tab'
    openr, lun_cono2, file_cono2, /get_lun
    skip_lun, lun_cono2, 2, /lines ; 2 header lines
    readf, lun_cono2 , o2cross_data
    free_lun, lun_cono2
  
    
    ;_____________________________________________________________________________________________________________
    
;    #1st method- take all the states separately
    O2_crss_states=fltarr(10,n_rows_o2)
    
    O2_crss_states[0,*]=o2cross_data[0,*]           ;wavelength
    O2_crss_states[1,*]=o2cross_data[5,*]*1.e-18    ;X
    O2_crss_states[2,*]=o2cross_data[6,*]*1.e-18    ;a+A
    O2_crss_states[3,*]=o2cross_data[7,*]*1.e-18    ;b
    O2_crss_states[4,*]=o2cross_data[8,*]*1.e-18    ;B
    O2_crss_states[5,*]=o2cross_data[9,*]*1.e-18    ; 2pi+C
    O2_crss_states[6,*]=o2cross_data[10,*]*1.e-18   ;2sig
    O2_crss_states[7,*]=o2cross_data[11,*]*1.e-18   ;33eV
    O2_crss_states[8,*]=o2cross_data[12,*]*1.e-18   ;2,4 sig
    O2_crss_states[9,*]=o2cross_data[13,*]*1.e-18   ;K
    
    ;_____________________________________________________________________________________________________________
    
    ;    #2nd method- Divide the states into two - O2+ and Frag(D.I)
    ;    Note: K state is Frag
;
;    O2_crss_states=fltarr(3,n_rows_o2)
;
;    O2_crss_states[0,*]=o2cross_data[0,*]           ;wavelength
;    O2_crss_states[1,*]=o2cross_data[4,*]*1.e-18    ;O2+
;    O2_crss_states[2,*]=o2cross_data[3,*]*1.e-18    ;Frag

    
    
    
    ;_____________________________________________________________________________________________________________
    ;_____________________________________________________________________________________________________________
    
    
      ;conwayn2_file: N2 data
      ;Column 1: wavelength
      ;Column 2:Photoabsorption
      ;Column 3:Photoionisation
      ;Column 4: FRAG
      ;Column 5: N2+
      ;Column 6: X
      ;Column 7: A
      ;Column 8: B
      ;Column 9: C
      ;Column 10: F
      ;Column 11: G+E
      ;Column 12: HP
      ;Column 13: H
      ;Column 14: N2++
      ;Column 15: K
    
      n_rows_n2= 808
      n_columns_n2=15
    
      n2cross_data=fltarr(n_columns_n2,n_rows_n2)
    
      file_conn2=floc+'photon2.tab'
      openr, lun_conn2, file_conn2, /get_lun
      skip_lun, lun_conn2, 2, /lines ; 2 header lines
      readf, lun_conn2 , n2cross_data
      free_lun, lun_conn2
      
      
      
      ;_____________________________________________________________________________________________________________
    
      ;    #1st method- take all the states separately

      N2_crss_states=fltarr(11,n_rows_n2)
      
      N2_crss_states[0,*]=n2cross_data[0,*]           ;wavelength
      N2_crss_states[1,*]=n2cross_data[5,*]*1.e-18    ;X
      N2_crss_states[2,*]=n2cross_data[6,*]*1.e-18    ;A
      N2_crss_states[3,*]=n2cross_data[7,*]*1.e-18    ;B
      N2_crss_states[4,*]=n2cross_data[8,*]*1.e-18    ;C
      N2_crss_states[5,*]=n2cross_data[9,*]*1.e-18    ;F
      N2_crss_states[6,*]=n2cross_data[10,*]*1.e-18   ;G+E
      N2_crss_states[7,*]=n2cross_data[11,*]*1.e-18   ;HP
      N2_crss_states[8,*]=n2cross_data[12,*]*1.e-18   ;H
      N2_crss_states[9,*]=n2cross_data[13,*]*1.e-18   ;N2++
      N2_crss_states[10,*]=n2cross_data[14,*]*1.e-18   ;K


      ;_____________________________________________________________________________________________________________

      ;    #2nd method- Divide the states into two - N2+ and Frag(D.I)
      ;    Note: K state is Frag
;      
;      N2_crss_states=fltarr(3,n_rows_n2)
;
;      N2_crss_states[0,*]=n2cross_data[0,*]           ;wavelength
;      N2_crss_states[1,*]=n2cross_data[4,*]*1.e-18    ;N2+
;      N2_crss_states[2,*]=n2cross_data[3,*]*1.e-18    ;Frag
      
;      
;      tpot=[[13.6, 16.9, 18.6, 28.50, 40.00, 531.70,0.0,0.0,0.0,0.0],$  ;adding extra potentials for N2 and O2 for extra states
;        [12.1, 16.10, 18.20, 20.3,23.2,27.2, 33.0,39.8,531.70,0.0],$      ;Conway 1988
;        [15.60,16.70, 18.80, 25.3,29.0,33.40,36.80,37.8, 43.6,400.]] ;Srimoyee was here !!



;_____________________________________________________________________________________________________________
;_____________________________________________________________________________________________________________



; Save the baseline files here


save, O_crss_states,O2_crss_states,N2_crss_states,$
      filename= savloc+'baseline_states.sav'

;_____________________________________________________________________________________________________________

;1st Method
  
;openw,lun_O,savloc+'O_basestates.dat',/get_lun
;printf, lun_O,'Wavelength (A)','4So ','2Do ','2Po ','4P ','2P ','K'
;for i=0,n_elements(O_crss_states[0,*])-1 do $
;    printf,lun_o, O_crss_states[0,i],'  ',O_crss_states[1,i],'  ',O_crss_states[2,i],'  ',$
;                   O_crss_states[3,i],'  ',O_crss_states[4,i],'  ',O_crss_states[5,i],'  ',O_crss_states[6,i]
;
;         
;openw,lun_O2,savloc+'O2_basestates.dat',/get_lun
;printf, lun_O2,'Wavlength ','X ','a+A ','b ','B ','2pi+c ','2sig ','33 eV ','2,4sig ','K'
;
;for i=0,n_elements(O2_crss_states[0,*])-1 do $
;    printf,lun_o2, O2_crss_states[0,i],'  ',O2_crss_states[1,i],'  ',O2_crss_states[2,i],'  ',$
;                   O2_crss_states[3,i],'  ',O2_crss_states[4,i],'  ',O2_crss_states[5,i],'  ',$
;                   O2_crss_states[6,i],'  ',O2_crss_states[7,i],'  ',O2_crss_states[8,i],'  ',$
;                   O2_crss_states[9,i]
;                   
;
;openw,lun_N2,savloc+'N2_basestates.dat',/get_lun
;printf, lun_N2,'Wavlength ', 'X ','A ','B ','C ','F ','G+E','HP ','H ','N2++ ','K'
;for i=0,n_elements(N2_crss_states[0,*])-1 do $
;    printf,lun_n2, N2_crss_states[0,i],'  ',N2_crss_states[1,i],'  ',N2_crss_states[2,i],'  ',$
;                   N2_crss_states[3,i],'  ',N2_crss_states[4,i],'  ',N2_crss_states[5,i],'  ',$
;                   N2_crss_states[6,i],'  ',N2_crss_states[7,i],'  ',N2_crss_states[8,i],'  ',$
;                   N2_crss_states[9,i],'  ',N2_crss_states[10,i]
;                   
                   
;_____________________________________________________________________________________________________________

                   
;2nd Method

openw,lun_O,savloc+'O_basestates.dat',/get_lun
printf, lun_O,'Wavelength (A)','4So ','2Do ','2Po '
for i=0,n_elements(O_crss_states[0,*])-1 do $
  printf,lun_o, O_crss_states[0,i],'  ',O_crss_states[1,i],'  ',O_crss_states[2,i],'  ',O_crss_states[3,i]


openw,lun_O2,savloc+'O2_basestates.dat',/get_lun
printf, lun_O2,'Wavlength ','O2+ ','Frag(D.I) '

for i=0,n_elements(O2_crss_states[0,*])-1 do $
  printf,lun_o2, O2_crss_states[0,i],'  ',O2_crss_states[1,i],'  ',O2_crss_states[2,i]


openw,lun_N2,savloc+'N2_basestates.dat',/get_lun
printf, lun_N2,'Wavlength ', 'N2+ ','Frag(D.I) '
for i=0,n_elements(N2_crss_states[0,*])-1 do $
  printf,lun_n2, N2_crss_states[0,i],'  ',N2_crss_states[1,i],'  ',N2_crss_states[2,i]


;_____________________________________________________________________________________________________________


free_lun,lun_O,lun_O2,lun_N2
close,/all


end