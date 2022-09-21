pro read_ionstates_data_fenn

  ; Reading the ionisation states from Fennely data and making new partial ionsiation baseline files
  ;Should contain all the states as in Fennely data starting from 23 A but does not  extended to lower wavelenghts

  ;_____________________________________________________________________________________________________________

  floc='/home/srimoyee/Desktop/bailey_bins/'
  savloc='/home/srimoyee/Desktop/nrl_files/sav_files/'

  ;_____________________________________________________________________________________________________________

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

  ;_____________________________________________________________________________________________________________

  
  ;    Divide the states into two - O2+ and O+(D.I)
  
  
      O2_crss_states=fltarr(3,n_rows_fenn)
  
      O2_crss_states[0,*]=fenncross_data[0,*]           ;wavelength
      O2_crss_states[1,*]=fenncross_data[6,*]*1.e-18    ;O2+
      O2_crss_states[2,*]=fenncross_data[7,*]*1.e-18    ;O+
  
  
  ;_____________________________________________________________________________________________________________

  ;    Divide the states into two - N2+ and N+
  
  
        N2_crss_states=fltarr(3,n_rows_fenn)
  
        N2_crss_states[0,*]=fenncross_data[0,*]           ;wavelength
        N2_crss_states[1,*]=fenncross_data[2,*]*1.e-18    ;N2+
        N2_crss_states[2,*]=fenncross_data[3,*]*1.e-18    ;N+

  ;____________________________________________________________________________________________________________
  ;_____________________________________________________________________________________________________________
  
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
  
  ;_____________________________________________________________________________________________________________

  ;  Take the states as in SQ'05 - 4S,2D,2P
  
    O_crss_states=fltarr(4,n_rows_fenno)
  
    O_crss_states[0,*]=fennocross_data[0,*]         ;wavelength
    O_crss_states[1,*]=fennocross_data[1,*]*1.e-18  ;4So
    O_crss_states[2,*]=fennocross_data[2,*]*1.e-18  ;2Do
    O_crss_states[3,*]=fennocross_data[3,*]*1.e-18  ;2Po
    
  ;_____________________________________________________________________________________________________________
  ;_____________________________________________________________________________________________________________

   ; Save the baseline files here


  save, O_crss_states,O2_crss_states,N2_crss_states,$
    filename= savloc+'baseline_states.sav'

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