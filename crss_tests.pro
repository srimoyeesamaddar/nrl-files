pro crss_tests


;  Dr. Bailey's bins
  ;    Column_0: Low Wavelength Bin
  ;    Column_1: High Wavelength Bin(A)]
  ;    Column_2: X
  ;    Column_3: A
  ;    Column_4: B
  ;    Column_5: C
  ;    Column_6: F
  ;    Column_7: Diss
  ;    Column_8: TotIon
  ;    Column_9: TotAbs
  
  lmax=156
  nmaj=3
  nst=6

  format="$((1x,f7.2,3x,f7.2,6(3x,f4.2),1x,f9.5,1x,f9.5))"
  n_rows= lmax
  n_columns=10

  data_n2=  fltarr(n_columns,n_rows)
  data_o2=fltarr(n_columns,n_rows)
  data_o=fltarr(n_columns,n_rows)

  file_n2='C:\Users\Srimoyee\Desktop\bailey_bins\newbins_n2.dat'
  openr, lun_n2, file_n2, /get_lun
  skip_lun, lun_n2, 4, /lines ;4 comment lines
  readf, lun_n2 , data_n2,format=format
  free_lun, lun_n2

  file_o2='C:\Users\Srimoyee\Desktop\bailey_bins\newbins_o2.dat'
  openr, lun_o2, file_o2, /get_lun
  skip_lun, lun_o2, 4, /lines ;4 comment lines
  readf, lun_o2 , data_o2,format=format
  free_lun, lun_o2

  file_o='C:\Users\Srimoyee\Desktop\bailey_bins\newbins_o.dat'
  openr, lun_o, file_o, /get_lun
  skip_lun, lun_o, 4, /lines ;4 comment lines
  readf, lun_o , data_o,format=format
  free_lun, lun_o



  wave_n2=(data_n2[0,*]+data_n2[1,*])/2.
  wave_o2=(data_o2[0,*]+data_o2[1,*])/2.
  wave_o=(data_o[0,*]+data_o[1,*])/2.
  
  ;C SIGABS  photoabsorption cross sections, O, O2, N2; cm2
  ;C SIGIONx  photoionization cross sections, O, O2, N2; cm2
  bailey_sigabs=dblarr(nmaj,lmax) ;0 for O, 1 for O2, 2 for N2, 123 for wavelengths
  bailey_sigionx=dblarr(nmaj,lmax) ;making this x so that it is not the same as the function sigion

  bailey_sigabs(0,*)=reform(data_o[9,*])*1e-18
  bailey_sigabs(1,*)=reform(data_o2[9,*])*1e-18
  bailey_sigabs(2,*)=reform(data_n2[9,*])*1e-18
  bailey_sigionx(0,*)=reform(data_o[8,*])*1e-18
  bailey_sigionx(1,*)=reform(data_o2[8,*])*1e-18
  bailey_sigionx(2,*)=reform(data_n2[8,*])*1e-18
  


  ;C PROB    branching ratios for each state, species, and wavelength bin:
  ;C         O+ states: 4S, 2Do, 2Po, 4Pe, 2Pe
  ;C         O2+ states: X, a+A, b, dissoc.
  ;C         N2+ states: X, A, B, C, F, dissoc.

  bailey_prob=dblarr(nst,nmaj,lmax) ;states species and energies
 
  for l=0,lmax-1 do begin
    for k=0,nst-1 do begin
      bailey_prob(k,0,l)=data_o(k+2,l)
      bailey_prob(k,1,l)=data_o2(k+2,l)
      bailey_prob(k,2,l)=data_n2(k+2,l)
    endfor
  endfor


save , bailey_sigabs,bailey_sigionx,bailey_prob, filename='C:\Users\Srimoyee\Desktop\nrl_files\sav_files\twocrss_comp.sav'






end
