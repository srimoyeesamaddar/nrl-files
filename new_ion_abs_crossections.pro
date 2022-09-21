; Making new ionisation and absorption cross-sections for given solar spectral bins
; Implementing flux weighting above 18A because Hinterregger does not values beflow this lower energy bins


;______________________________________________________________________________________________________________________
;______________________________________________________________________________________________________________________

pro new_ion_abs_crossections, enwv_const,at_sp,it_sp,wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,wave_sp,totabs_sp,totionz_sp,new_ionzbins_sp,new_absbins_sp



  new_ionzbins_sp=fltarr(n_elements(wavelength))
  new_absbins_sp=fltarr(n_elements(wavelength))
 

  ;#1 Applying flux weighting (in wavelength) to all bins above 18 A

  ii=where(wavelength_high ge hintwvln[0],/null)

  for i= ii[0], n_elements(wavelength)-1 do begin  ;n_elements(wavelength_low)-1;ii[0], n_elements(wavelength)-1
    if (wavelength_low[i] eq wavelength_high[i]) then begin     ;for bins with zero widths

      min_diff = min(abs(wave_sp-wavelength[i]),i_min)
      new_absbins_sp[i]=   totabs_sp[i_min]
      new_ionzbins_sp[i]=  totionz_sp[i_min]


    endif



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

                     a_sp= fltarr(n_elements(ii_hintwvl))   ;Getting the cross-sections at Hinterregger wavelength
                     i_sp= fltarr(n_elements(ii_hintwvl))   ;Getting the cross-sections at Hinterregger wavelength
                     
;                 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;                    for j=0, n_elements(ii_hintwvl)-1 do begin
;
;                          min_diff = min(abs(wv_sp-wv_hint[j]),jj_min)
;                          a_sp[j]=abs_sp[jj_min]
;                          i_sp[j]=ionz_sp[jj_min]
;
;                    endfor
                    
;                   ++++++++++++++++++++++++++++++++++OR++++++++++++++++++++++++++++++++++++++++++++++++++++
                    ;interpolating hinteregger to new cross-sections bins
                    i_sp=exp(interpol(alog(ionz_sp),alog(wv_sp),alog(wv_hint)))
                    a_sp=exp(interpol(alog(abs_sp),alog(wv_sp),alog(wv_hint)))


                    i_sp[where(~finite(i_sp),/null)]=0.
                    a_sp[where(~finite(a_sp),/null)]=0.

;                 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                     if n_wv gt 1 then begin ;Checking for overlapping bins here


;                           Finding the quantiles for the cross-section data according to the total number of bins
                            d= 1./n_wv
                            percntl=0.+findgen(n_wv+1)*d
                            
                            prctl=cgpercentiles(a_sp,percentiles=percntl)

          
                             for k=0, n_wv-1 do begin
                                   
                                   ind= where((a_sp ge prctl[k]) and (a_sp le prctl[k+1]),/null)
;                                   Flux-weighting in each quantile
            
                                   new_absbins_sp[i+k]=      total( a_sp[ind]* fl_hint[ind] )  /  total( fl_hint[ind] )

                                   new_ionzbins_sp[i+k]=      total( i_sp[ind]* fl_hint[ind] )  /  total( fl_hint[ind] )
                
;                                   
        
        

                              endfor


                          i=i+n_wv-1

                     endif else begin

                            new_absbins_sp[i]=     total( a_sp* fl_hint )  /  total( fl_hint )

                            new_ionzbins_sp[i]=   total( i_sp* fl_hint )  /  total( fl_hint )


                     endelse
          
          
          endif 
        
    endif
  
  endfor



  ;Interpolation for wavelengths below 18A


  int_ind=where(wave_sp le wavelength_high[ii[0]-1],/null   )
  ener_sp=enwv_const/wave_sp[int_ind]

  new_ionzbins_sp[0:ii[0]-1]= exp(interpol(alog(totionz_sp[int_ind]),   alog(ener_sp[int_ind]),    alog(enwv_const/wavelength[0:ii[0]-1]  ) ))
  new_absbins_sp[0:ii[0]-1]= exp(interpol(alog(totabs_sp[int_ind]),    alog(ener_sp[int_ind]),    alog(enwv_const/wavelength[0:ii[0]-1]   )  ))

  ;Making cross-sections beyond thresholds zero
  
  
  new_absbins_sp[where(wavelength gt at_sp,/null)]=0.
  new_ionzbins_sp[where(wavelength gt it_sp,/null)]=0.



end



























;                   for it=0, 10 do begin
;
;                  array1=fltarr(1,n_elements(ii_crsswvl))
;
;                  array1[0,*]=(hf_abs-min(hf_abs))/(max(hf_abs)-min(hf_abs))
;
;                  array2=fltarr(1,n_elements(ii_crsswvl))
;                  array2[0,*]=hf_ionz
;
;                  weight1=clust_wts(array1,n_clusters=n_wv)
;                  result1= cluster(array1,weight1,n_clusters=n_wv)
;
;                  PLOT, array1[*, WHERE(result1 eq 0)], $
;                     psym=2
;                  oPLOT, array1[*, WHERE(result1 eq 1)], $
;                    psym = 2, color='ff00ff'x
;;                    wait, 2
;;                    endfor
;
;                  stop


;