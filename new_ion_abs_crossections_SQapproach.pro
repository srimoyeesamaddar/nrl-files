; Making new ionisation and absorption cross-sections for given solar spectral bins
; Implementing flux weighting above 18A because Hinterregger does not values beflow this lower energy bins


;______________________________________________________________________________________________________________________
;______________________________________________________________________________________________________________________

pro new_ion_abs_crossections_SQapproach, enwv_const,at_sp,it_sp,wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,wave_sp,totabs_sp,totionz_sp,new_ionzbins_sp,new_absbins_sp,w,val


  new_ionzbins_sp=fltarr(n_elements(wavelength))
  new_absbins_sp=fltarr(n_elements(wavelength))
  hf_flux =  fltarr(n_elements(wavelength))

  ;#1 Applying flux weighting (in wavelength) to all bins above 18 A

  ii=where(wavelength_high ge hintwvln[0],/null)


  for i= ii[0], n_elements(wavelength)-1 do begin  ;n_elements(wavelength_low)-1;ii[0], n_elements(wavelength)-1

    if ~isa([where((wave_sp ge wavelength_low[i]) and (wave_sp lt wavelength_high[i]),/null)],/null)  then begin

      if (wavelength_low[i] ne wavelength_high[i]) then begin  ;for finite bin widths

        mult_ii= where(wavelength_low[i:-1] eq wavelength_low[i],n_wv)  ;Taking care of muliptle overlapping bins


        ii_hintwvl=where((hintwvln ge wavelength_low[i]) and (hintwvln lt wavelength_high[i]),/null)

        ii_crsswvl=[where((wave_sp ge wavelength_low[i]) and (wave_sp lt wavelength_high[i]),/null)]

        wv_hint= hintwvln[ii_hintwvl]
        fl_hint= hintflux[ii_hintwvl]

        wv_sp= wave_sp[ii_crsswvl]     ;Main cross-sections/flux/wavelength to check
        abs_sp= totabs_sp[ii_crsswvl]
        ionz_sp= totionz_sp[ii_crsswvl]
        
        ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==
;
;        hf= fltarr(n_elements(ii_crsswvl))   ;Getting the Hinterregger flux at cross-section wavelengths
;
;        for j=0, n_elements(ii_crsswvl)-1 do begin
;
;          min_diff = min(abs(wv_hint-wv_sp[j]),jj_min)
;          hf[j]=fl_hint[jj_min]
;
;        endfor

        ;interpolating hinteregger to new cross-sections bins
        result_ionz_sp=exp(interpol(alog(ionz_sp),alog(wv_sp),alog(wv_hint)))
        result_abs_sp=exp(interpol(alog(abs_sp),alog(wv_sp),alog(wv_hint)))
        
        
        result_ionz_sp[where(~finite(result_ionz_sp),/null)]=0.
        result_abs_sp[where(~finite(result_abs_sp),/null)]=0.
        
        
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=

        if n_wv gt 1 then begin ;Checking for overlapping bins here
         
          
         
;          SQ'05 categories

          if n_wv eq 2 then begin
            
             abs_med=where(result_abs_sp lt 3.1e-17,/null )
             abs_hi=where(result_abs_sp ge 3.1e-17,/null )
              if ~isa(abs_med,/null) then begin
                 new_absbins_sp[i]=      total(   result_abs_sp[abs_med ]*fl_hint[abs_med ] )  /  total( fl_hint[abs_med  ]  )
                new_ionzbins_sp[i]=      total(  result_ionz_sp[abs_med]*fl_hint[abs_med ] )  /  total( fl_hint[abs_med]  )
   
              endif
             
             if ~isa(abs_hi,/null) then begin
               new_absbins_sp[i+1]=      total(   result_abs_sp[abs_hi ]*fl_hint[abs_hi ] )  /  total( fl_hint[abs_hi  ]  )
               new_ionzbins_sp[i+1]=      total(  result_ionz_sp[abs_hi]*fl_hint[abs_hi ] )  /  total( fl_hint[abs_hi]  )
 
             endif
             
               
             
             
          endif else begin
            
              abs_lo=where(result_abs_sp lt 4.0e-18 ,/null )
              abs_med=where((result_abs_sp ge 4.0e-18)  and (result_abs_sp lt 3.1e-17),/null )
              abs_hi=where(result_abs_sp ge 3.1e-17,/null )
              
              if ~isa(abs_lo,/null) then begin
                new_absbins_sp[i]=      total(   result_abs_sp[abs_lo ]*fl_hint[abs_lo ] )  /  total( fl_hint[abs_lo  ]  )
                new_ionzbins_sp[i]=      total(  result_ionz_sp[abs_lo]*fl_hint[abs_lo ] )  /  total( fl_hint[abs_lo]  )
              endif
              
              if ~isa(abs_med,/null) then begin
                new_absbins_sp[i+1]=      total(   result_abs_sp[abs_med ]*fl_hint[abs_med ] )  /  total( fl_hint[abs_med  ]  )
                new_ionzbins_sp[i+1]=      total(  result_ionz_sp[abs_med]*fl_hint[abs_med ] )  /  total( fl_hint[abs_med]  )
              endif
              
              if ~isa(abs_hi,/null) then begin
                new_absbins_sp[i+2]=      total(   result_abs_sp[abs_hi ]*fl_hint[abs_hi ] )  /  total( fl_hint[abs_hi  ]  )
                new_ionzbins_sp[i+2]=      total(  result_ionz_sp[abs_hi]*fl_hint[abs_hi ] )  /  total( fl_hint[abs_hi]  )
  
              endif
              
          endelse

         

          i=i+n_wv-1

        endif else begin

          new_absbins_sp[i]=     total(   result_abs_sp*fl_hint )  /  total( fl_hint  )

          new_ionzbins_sp[i]=       total(   result_ionz_sp*fl_hint )  /  total( fl_hint  )


        endelse


      endif else begin     ;for bins with zero widths

        min_diff = min(abs(wave_sp-wavelength[i]),i_min)

        new_absbins_sp[i]=   totabs_sp[i_min]
        new_ionzbins_sp[i]=  totionz_sp[i_min]

      endelse

    endif

  endfor



  ;Interpolation for wavelengths below 18A


  int_ind=where(wave_sp le wavelength_high[ii[0]-1],/null   )
  ener_sp=enwv_const/wave_sp[int_ind]

  new_ionzbins_sp[0:ii[0]-1]= exp(interpol(alog(totionz_sp[int_ind]),   alog(ener_sp[int_ind]),    alog(enwv_const/wavelength[0:ii[0]-1]  ) ))
  new_absbins_sp[0:ii[0]-1]= exp(interpol(alog(totabs_sp[int_ind]),    alog(ener_sp[int_ind]),    alog(enwv_const/wavelength[0:ii[0]-1]   )  ))

  ;Making cross-sections beyond thresholds



  new_absbins_sp[where(wavelength gt at_sp,/null)]=0.
  new_ionzbins_sp[where(wavelength gt it_sp,/null)]=0.



end




bloc='/home/srimoyee/Desktop/bailey_bins/'
floc='/home/srimoyee/Desktop/nrl_files/sav_files/'


;Base Cross-section files

ionzabs_file =  floc+'ion&abs_cross_files.sav'
restore, ionzabs_file
;File has:
; wave_o,wave_o2,wave_n2
; totionz_o,totionz_o2,totionz_n2
; totabs_o,totabs_o2,totabs_n2


;Base Cross-section states files

basestate_file= floc+'baseline_states.sav'
restore,basestate_file
;  File has:
;  O_crss_states,O2_crss_states,N2_crss_states
;  first column is wavelength

;Output files

out_ionsabs_sav='new_crosssec.sav'
out_O_dat='new_Obins.dat'
out_O2_dat='new_O2bins.dat'
out_N2_dat='new_N2bins.dat'


out_states_sav='new_prob_states.sav'


enwv_const= 12397.

; Ionisation and Absorption Thresholds
at_n2= 986.30 ; Angstroms
at_o2= 2000.00 ; max bins we will be having
at_o = 913.00
it_n2= 798.00
it_o2= 1025.72 ; keep this at Ly Beta wvln as long as Fennally compilation used
;it_o2= 1032.2  ; from Watanbe 2004
it_o = at_o




tpot=[[13.6, 16.9, 18.6, 28.50, 40.00, 531.70,0.0,0.0,0.0,0.0],$  ; tpot(states,species)
  [12.1, 16.10, 18.20, 20.3,23.2,27.2, 33.0,39.8,531.70,0.0],$    ;Conway 1988
  [15.60,16.70, 18.80, 25.3,29.0,33.40,36.80,37.8, 43.6,400.]]

;______________________________________________________________________________________________________________________


;INPUT SPECTRA

; CHOOSE 1
; #1  NRL solar spectrum..............................

;file_ssflux='C:\Users\srimo\Desktop\nrl_files\sample_spectra.sav'
;file_ssflux='C:\Users\srimo\Desktop\nrl_files\sav_files\irradiance_23jul2016.sav'
;file_ssflux='C:\Users\srimo\Desktop\nrl_files\sav_files\irradiance_04nov2003.sav'
;
;restore, file_ssflux
;  Sav file has:
;  wavelength=(wavelength_low+wavelength_high)/2.
; wavelength_low
; wavelength_high
;spectrum1,spectrum2,spectrum3,spectrum4,spectrum5,background_spectrum
; SQ05 with and without Fe line

;file_ssflux='/home/srimoyee/Desktop/nrl_files/sav_files/x9_stanbands_myver.sav'
;;file_ssflux='/home/srimoyee/Desktop/nrl_files/sav_files/m5_stanbands_myver.sav'
;; file has: wave_lo, wave_hi,spectrum
;restore, file_ssflux
;wavelength_low=wave_lo
;wavelength_high=wave_hi
;wavelength=(wavelength_low+wavelength_high)/2.


;#2 EUVAC spectrum.................................................
;restore,'C:\Users\Srimoyee\Desktop\nrl_files\sav_files\euvac_spec.sav'
;;save file has :ssflux, wv1,wv2,wv_avg
;wavelength_low=wv1
;wavelength_high=wv2
;wavelength=wv_avg

;# 3 Solomon & Qian 2005
;restore,'/home/srimoyee/Desktop/nrl_files/sav_files/Solomon_Qian2005.sav'
;;file has:
;;A_fac, fref, wavelength_low, wavelength_high
;wavelength=(wavelength_low+wavelength_high)/2.

;#4 New Nrl spectra
restore, floc+ 'newspectra.sav'
;file has: wave_gcm1,wave_gcm2,meanpeakx9,peakm5
wavelength_low=wave_gcm1
wavelength_high=wave_gcm2
wavelength=(wavelength_low+wavelength_high)/2.

;_____________________________________________________________________________________________________________________

;  Hinteregger solar flux  model- used for flux weighting
;
file_hint= bloc+'sc21refw.dat'
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
hintener=enwv_const/hintwvln



;______________________________________________________________________________________________________________________


new_ion_abs_crossections_SQapproach, enwv_const,at_o,it_o,wavelength, wavelength_low,wavelength_high,meanpeakx9,hintwvln,hintflux,wave_o,totabs_o,totionz_o,sigi_o,sigab_o
new_ion_abs_crossections_SQapproach, enwv_const,at_o2,it_o2,wavelength, wavelength_low,wavelength_high,meanpeakx9,hintwvln,hintflux,wave_o2,totabs_o2,totionz_o2,sigi_o2,sigab_o2
new_ion_abs_crossections_SQapproach, enwv_const,at_n2,it_n2,wavelength, wavelength_low,wavelength_high,meanpeakx9,hintwvln,hintflux,wave_n2,totabs_n2,totionz_n2,sigi_n2,sigab_n2


end


;