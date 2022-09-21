; Making the ionisation, absorption and states cross-sections from SQ'05 and adding Fe line

loc='/home/srimoyee/Desktop/nrl_files/sav_files/'
;____________________________________________________________________________________________________________________________________________________________________

;;SQ'05 and Fe line
;wavelength_low=[0.5,2.0,4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,650.,798.,798.,798.,913.,$
;  913.,913.,975.,987.,1027.]
;
;wavelength_high=[2.,4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,798.,798.,913.,913.,913.,975.,$
;  975.,975.,987.,1027.,1050.]
;
;spec_wave=0.5*(wavelength_low+wavelength_high)
;
;; Absorption cross-sections
;;NOTE: Adding the Fe line in the first bin
;sigab_o=[.00015224609,0.0023,0.0170,0.1125,0.1050,0.3247,1.319,3.7832,6.0239,7.7205,10.7175,13.1253,8.5159,4.7889,$
;  3.0031,4.1048,3.7947,0.0,0.0,0.0,0.0,0.0,0.0]*1e-18  ;in cm^2
;sigab_o2=[0.00030449218,0.0045,0.034,0.2251,0.2101,0.6460,2.6319,7.6283,13.2125,16.8233,20.3066,27.0314,23.5669,24.9102,$
;  10.498,10.9075,13.3122,13.395,14.4042,32.5038,18.7145,1.6320,1.1500]*1e-18  ;in cm^2
;sigab_n2=[0.0005,0.0025,0.0201,0.1409,1.1370,0.3459,1.5273,5.0859,9.9375,11.7383,19.6514,23.0931,23.0346,54.5252,$
;  2.1434,13.1062,71.6931,2.1775,14.4390,115.257,2.5465,0.0,0.0]*1e-18  ;in cm^2
;
;
;; Ionisation and DI states as a fraction of absorption cross-sections
;;O : 4S, 2D, 2P
;O_state=transpose([[0.39,0.39,0.39,0.39,0.39,0.393,0.389,0.367,.35,0.346,0.317,0.298,0.655,0.930,1.0,1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0],$
;  [0.378,0.378,0.378,0.378,0.378,0.374,0.377,0.392,0.402,0.403,0.424,0.451,0.337,0.07,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],$
;  [0.224,0.224,0.224,0.224,0.224,0.226,0.227,0.233,0.241,0.246,0.260,0.252,0.009,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]])
;;O2 : Ionisation and DI
;O2_state=transpose([[0.0,0.0,0.0,0.0,0.0,0.108,0.347,0.553,0.624,0.649,0.759,0.874,0.672,0.477,0.549,0.574,0.534,0.756,0.786,0.62,0.83,0.613,0.0],$
;  [1.0,1.0,1.0,1.0,1.0,0.892,0.653,0.447,0.376,0.351,0.24,0.108,0.001,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]])
;;N2 : Ionisation and DI
;N2_state=transpose([[0.04,0.04,0.04,0.04,0.04,0.717,0.751,0.747,0.754,0.908,0.996,1.0,0.679,0.429,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],$
;  [0.96,0.96,0.96,0.96,0.96,0.282,0.249,0.253,0.246,0.093,0.05,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]])
;
;; Ionisation cross-sections
;sigi_o=total(o_state,1)*sigab_O
;sigi_o2=total(o2_state,1)*sigab_O2
;sigi_n2=total(n2_state,1)*sigab_N2
;
;; Ionisation and DI states as a fraction of ionization cross-sections
;
;O_prob_state=fltarr(4,n_elements(wavelength_low))
;O2_prob_state=fltarr(3,n_elements(wavelength_low))
;N2_prob_state=fltarr(3,n_elements(wavelength_low))
;
;o_prob_state[0,*]=spec_wave
;o_prob_state[1,*]=O_state[0,*]*sigab_O/sigi_O
;o_prob_state[2,*]=O_state[1,*]*sigab_O/sigi_O
;o_prob_state[3,*]=O_state[2,*]*sigab_O/sigi_O
;
;o2_prob_state[0,*]=spec_wave
;o2_prob_state[1,*]=O2_state[0,*]*sigab_O2/sigi_O2
;o2_prob_state[2,*]=O2_state[1,*]*sigab_O2/sigi_O2
;
;n2_prob_state[0,*]=spec_wave
;n2_prob_state[1,*]=n2_state[0,*]*sigab_n2/sigi_n2
;n2_prob_state[2,*]=n2_state[1,*]*sigab_n2/sigi_n2
;
;o_prob_state[where(~finite(o_prob_state),/null)]=0.0
;o2_prob_state[where(~finite(o2_prob_state),/null)]=0.0
;n2_prob_state[where(~finite(n2_prob_state),/null)]=0.0
;


;____________________________________________________________________________________________________________________________________________________________________
;_________________________________________________________________OR___________________________________________________________________________________________________

;SQ'05
wavelength_low=[0.5,4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,650.,798.,798.,798.,913.,$
  913.,913.,975.,987.,1027.]

wavelength_high=[4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,798.,798.,913.,913.,913.,$
  975.,975.,975.,987.,1027.,1050.]

spec_wave=0.5*(wavelength_low+wavelength_high)

; Absorption cross-sections
sigab_o=[0.0023,0.0170,0.1125,0.1050,0.3247,1.319,3.7832,6.0239,7.7205,10.7175,13.1253,8.5159,4.7889,$
  3.0031,4.1048,3.7947,0.0,0.0,0.0,0.0,0.0,0.0]*1e-18  ;in cm^2
sigab_o2=[0.0045,0.034,0.2251,0.2101,0.6460,2.6319,7.6283,13.2125,16.8233,20.3066,27.0314,23.5669,24.9102,$
  10.498,10.9075,13.3122,13.395,14.4042,32.5038,18.7145,1.6320,1.1500]*1e-18  ;in cm^2
sigab_n2=[0.0025,0.0201,0.1409,1.1370,0.3459,1.5273,5.0859,9.9375,11.7383,19.6514,23.0931,23.0346,54.5252,$
  2.1434,13.1062,71.6931,2.1775,14.4390,115.257,2.5465,0.0,0.0]*1e-18  ;in cm^2


; Ionisation and DI states as a fraction of absorption cross-sections
;O : 4S, 2D, 2P
O_state=transpose([[0.39,0.39,0.39,0.39,0.393,0.389,0.367,.35,0.346,0.317,0.298,0.655,0.930,1.0,1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0],$
  [0.378,0.378,0.378,0.378,0.374,0.377,0.392,0.402,0.403,0.424,0.451,0.337,0.07,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],$
  [0.224,0.224,0.224,0.224,0.226,0.227,0.233,0.241,0.246,0.260,0.252,0.009,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]])

; NOT SQ- just trying to make the probabilty 1
;  O_state=transpose([[0.398,0.398,0.398,0.398,0.4,0.396,0.375,.357,0.351,0.316,0.297,0.654,0.930,1.0,1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0],$
;    [0.378,0.378,0.378,0.378,0.374,0.377,0.392,0.402,0.403,0.424,0.451,0.337,0.07,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],$
;    [0.224,0.224,0.224,0.224,0.226,0.227,0.233,0.241,0.246,0.260,0.252,0.009,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]])



;O2 : Ionisation and DI
O2_state=transpose([[0.0,0.0,0.0,0.0,0.108,0.347,0.553,0.624,0.649,0.759,0.874,0.672,0.477,0.549,0.574,0.534,0.756,0.786,0.62,0.83,0.613,0.0],$
  [1.0,1.0,1.0,1.0,0.892,0.653,0.447,0.376,0.351,0.24,0.108,0.001,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]])
;N2 : Ionisation and DI
N2_state=transpose([[0.04,0.04,0.04,0.04,0.717,0.751,0.747,0.754,0.908,0.996,1.0,0.679,0.429,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],$
  [0.96,0.96,0.96,0.96,0.282,0.249,0.253,0.246,0.093,0.05,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]])
  
; Ionisation cross-sections
  sigi_o=total(o_state,1)*sigab_O
  
  
;__________________________________________checking with the dissociation states_______________________________________________________________
  
;  sigab_o=sigi_o
  dis_o2=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.017,0.327,0.524,0.451,0.426,0.466,0.244,0.214,0.380,0.17,0.387,1.0]
  dis_n2=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.32,0.571,1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.0,0.0]
;  
;  for i=0, n_elements(wavelength_low)-1 do begin
;      sigab_o2[i]=(o2_state[0,i]+o2_state[1,i]+dis_o2[i])*sigab_O2[i]
;      sigab_n2[i]=(n2_state[0,i]+n2_state[1,i]+dis_n2[i])*sigab_N2[i]
; endfor
;  _______________________________________________________________________________________________________________________________________________
  
  sigi_o2=total(o2_state,1)*sigab_O2
  sigi_n2=total(n2_state,1)*sigab_N2


; Ionisation and DI states as a fraction of ionization cross-sections

O_prob_state=fltarr(4,n_elements(wavelength_low))
O2_prob_state=fltarr(3,n_elements(wavelength_low))
N2_prob_state=fltarr(3,n_elements(wavelength_low))

o_prob_state[0,*]=spec_wave
o_prob_state[1,*]=O_state[0,*]*sigab_O/sigi_O
o_prob_state[2,*]=O_state[1,*]*sigab_O/sigi_O
o_prob_state[3,*]=O_state[2,*]*sigab_O/sigi_O

o2_prob_state[0,*]=spec_wave
o2_prob_state[1,*]=O2_state[0,*]*sigab_O2/sigi_O2
o2_prob_state[2,*]=O2_state[1,*]*sigab_O2/sigi_O2

n2_prob_state[0,*]=spec_wave
n2_prob_state[1,*]=n2_state[0,*]*sigab_n2/sigi_n2
n2_prob_state[2,*]=n2_state[1,*]*sigab_n2/sigi_n2

o_prob_state[where(~finite(o_prob_state),/null)]=0.0
o2_prob_state[where(~finite(o2_prob_state),/null)]=0.0
n2_prob_state[where(~finite(n2_prob_state),/null)]=0.0
;____________________________________________________________________________________________________________________________________________________________________
;____________________________________________________________________________________________________________________________________________________________________
; Save output varibles

save,O_prob_state,O2_prob_state,N2_prob_state, filename= loc+'new_prob_states_SQ05.sav'

save, spec_wave,sigi_o,sigi_o2,sigi_n2,sigab_o,sigab_o2,sigab_n2, filename= loc+'new_crosssec_SQ05.sav'



;______________________________________________________________________________________________________________________________________________________________________

; Writing data in csv file for easy read
;
;head_var_o=['wave_lo','wave_hi','abs cross-section (cm^2)','beta 4S','beta 2D','beta 2P']
;head_var_o2=['wave_lo','wave_hi','abs cross-section (cm^2)','beta O2+','beta D.I','beta Dissoc.']
;head_var_n2=['wave_lo','wave_hi','abs cross-section (cm^2)','beta N2+','beta D.I','beta Dissoc.']
;
;
;
;tab_headO='O data'
;tab_headO2='O2 data'
;tab_headN2='N2 data'
;
;
;;output data file
;outfile1=loc+'SQ_tableA2_o.csv'
;outfile2=loc+'SQ_tableA3_o2.csv'
;outfile3=loc+'SQ_table_A4_n2.csv'
;
;
;
;WRITE_CSV, outfile1, wavelength_low,wavelength_high,sigab_o,o_state[0,*],o_state[1,*],o_state[2,*], $
;           HEADER=head_var_o,Table_header=tab_headO
;
;WRITE_CSV, outfile2, wavelength_low,wavelength_high,sigab_o2,o2_state[0,*],o2_state[1,*],dis_o2, $
;           HEADER=head_var_o2,Table_header=tab_headO2
;
;WRITE_CSV, outfile3, wavelength_low,wavelength_high,sigab_n2,n2_state[0,*],n2_state[1,*],dis_n2, $
;           HEADER=head_var_n2,Table_header=tab_headN2
;





;_________________________________________________________________________________________________________________________________________________________________





end
