pro new_bins_forstates, enwv_const,th_st,wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,crss_data,prob_state,tot_ionz_sp

  
;making new cross-sections for different states of O,O2 and N2 at solar spectrum wavelengths
;crss_data is the cross section data from the base- line file
;ionthr is the ionisation threshold of the specific species
;prob_state is the output probabilities for each state in the spectral bins 

size_crss_data=size(crss_data)
n_rows=size_crss_data[2]
n_cols=size_crss_data[1]
;print,n_cols
;print,n_rows

ind_rows= indgen(n_rows)
ind_cols= indgen(n_cols)

wave_sp = crss_data[0,*]


;_________________________________________________________________________________________________________________

new_bins_sp=fltarr(n_cols,n_elements(wavelength)) ;new bins have all the states as the columns
new_bins_sp[0,*]=wavelength
;_________________________________________________________________________________________________________________



;#1 Applying flux weighting (in wavelength) to all bins above 18 A

ii=where(wavelength_high ge hintwvln[0],/null)


for i=ii[0], n_elements(wavelength)-1 do begin  ;n_elements(wavelength_low)-1
  
     if ~isa([where((wave_sp ge wavelength_low[i]) and (wave_sp lt wavelength_high[i]),/null)],/null)  then begin
      

            if (wavelength_low[i] ne wavelength_high[i]) then begin  ;for finite bin widths

                mult_ii= where(wavelength_low[i:-1] eq wavelength_low[i],n_wv)  ;Taking care of muliptle overlapping bins


                ii_hintwvl=where((hintwvln ge wavelength_low[i]) and (hintwvln lt wavelength_high[i]),/null)

                ii_crsswvl=[where((wave_sp ge wavelength_low[i]) and (wave_sp lt wavelength_high[i]),/null)]

                wv_hint= hintwvln[ii_hintwvl]
                fl_hint= hintflux[ii_hintwvl]

                wv_sp= wave_sp[ii_crsswvl]     ;Main cross-sections/flux/wavelength to check
                crss_sp=crss_data[1:n_cols-1,ii_crsswvl] 


                st_sp= fltarr(n_cols-1,n_elements(ii_hintwvl))   ;Getting the cross-sections at Hinterregger wavelength
               
;                 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;
;                    for j=0, n_elements(ii_hintwvl)-1 do begin
;
;                          min_diff = min(abs(wv_sp-wv_hint[j]),jj_min)
;                          
;                          st_sp[0:-1,j]=crss_sp[0:-1,jj_min]
;                        
;
;                    endfor

;                  ++++++++++++++++++++++++++++++++++OR++++++++++++++++++++++++++++++++++++++++++++++++++++

;                  interpolating cross-sections to hinteregger bins
                  for st=0, n_cols-2 do begin
  
                        st_sp[st,*]=exp(interpol(alog(reform(crss_sp[st,*])), alog(wv_sp), alog(wv_hint)))
                     

                  endfor

                  

                    st_sp[where(~finite(st_sp),/null)]=0.

;                 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





;        
;
;                for st= 1,n_cols-1 do begin     ; looping for all states
;
;                           hf_crss[st-1,*]= hf*crss_data[st,ii_crsswvl]    ;Main flux*cross-sectionsflux to check
;                endfor
  
 


                if n_wv gt 1 then begin ;Checking for overlapping bins here
                  
                  
                  
;                  Finding the quantiles for the cross-section data according to the total number of bins
                  
                  st_sp_tot= total(st_sp,1); gives total cross-sections for finding quantiles
                  d= 1./n_wv
                  percntl=0.+findgen(n_wv+1)*d

                  prctl=cgpercentiles(st_sp_tot,percentiles=percntl)


                  for k=0, n_wv-1 do begin

                    ind= where((st_sp_tot ge prctl[k]) and (st_sp_tot le prctl[k+1]),/null)
                   
                     for st=1, n_cols-1 do begin
;                    
;                    Flux-weighting in each quantile

                         new_bins_sp[st,i+k]=   total( st_sp[st-1,ind]  * fl_hint[ind]  )  /  total( fl_hint[ind]   )

                     endfor


                 endfor




                    i=i+n_wv-1

                endif else begin
                      
                      for st=1, n_cols-1 do begin

                               new_bins_sp[st,i]=     total( st_sp[st-1,*]  * fl_hint  )  /  total( fl_hint  )
                       endfor


                endelse


            endif else begin     ;for bins with zero widths

                   min_diff = min(abs(wave_sp-wavelength[i]),i_min)
    
                    for st=1, ncols-1 do begin

                            new_bins_sp[st,i]=     crss_data[st,i_min]  
                    endfor


            endelse

     endif   ;checking if there is no cross-section wavelengths in bwtweeen two spectral bins

endfor



;Making cross-sections beyond thresholds zero


  for i=1, n_cols-1 do begin
    new_bins_sp[i,where(wavelength gt th_st[i-1],/null)]=0.

  endfor


;_________________________________________________________________________________________________________________
;_________________________________________________________________________________________________________________


;Creating new proabailty of states files with given spectral bins


prob_state=new_bins_sp *0.0;fltarr(n_cols,n_elements(wavelength))

tot_ionz_sp= fltarr(n_elements(wavelength))

prob_state[0,*]=new_bins_sp[0,*]

    
    for iwv=ii[0] , n_elements(wavelength)-1 do begin 
         
         tot_ionz_sp[iwv]= total(new_bins_sp[1:-1,iwv])
         
          for i=1, n_cols-1 do begin
             
             prob_state[i,iwv]=new_bins_sp[i,iwv]/total(new_bins_sp[1:-1,iwv])
             
           endfor
    endfor
    

 
 ;Fixing the probabilities for shortest wavelengths
 
 for i=1,n_cols-1 do begin
      prob_state[i,0:ii[0]-1]=  crss_data[i,0]/total(crss_data[1:-1,0])
  
 endfor
 ; Taking care of NAN values
 
 prob_state[where(~finite(prob_state),/null)]=0.

END
;_________________________________________________________________________________________________________________
;_________________________________________________________________________________________________________________











;; .................................................MAIN ...................................................
;enwv_const= 12397.
;
;
;; Ionisation and Absorption Thresholds
;at_n2= 986.30 ; Angstroms
;at_o2= 2000.00 ; max bins we will be having
;at_o = 913.00
;it_n2= 798.00
;it_o2= 1025.72 ; keep this at Ly Beta wvln as long as Fennally compilation used
;;it_o2= 1032.2
;it_o = at_o
;
;
;;
;;tpot=[[13.6, 16.9, 18.6, 28.50, 40.00, 531.70,0.0,0.0,0.0,0.0],$  ;adding extra potentials for N2 and O2 for extra states
;;        [12.1, 16.10, 18.20, 20.3,23.2,27.2, 33.0,39.8,531.70,0.0],$      ;Conway 1988
;;        [15.60,16.70, 18.80, 25.3,29.0,33.40,36.80,37.8, 43.6,400.]] ;Srimoyee was here !!
;        
;        
;        
;
;tpot=[[13.61, 16.93, 18.63],$    ;tpot(states,species)  For NRL with two states O2+/N2+ and Frag
;        [12.07, 18.20, 0.0],$
;        [15.60,25.3, 0.0]]
;        
;;_________________________________________________________________________________________________________________
;
;; ................................INPUT SPECTRA........................................................
;
;; CHOOSE 1
;
;;#4 New Nrl spectra
;restore, '/home/srimoyee/Desktop/nrl_files/sav_files/newspectra.sav'
;;restore, '/home/srimoyee/Desktop/nrl_files/sav_files/SQ_newspectra.sav'
;
;;file has: wave_gcm1,wave_gcm2,meanpeakx9,peakm5
;wavelength_low=wave_gcm1
;wavelength_high=wave_gcm2
;wavelength=(wavelength_low+wavelength_high)/2.
;ssflux=meanpeakx9
;
;;_________________________________________________________________________________________________________________
;
;
;;  Hinteregger test model
;
;file_hint= '/home/srimoyee/Desktop/bailey_bins/sc21refw.dat'
;openr,lun_hint, file_hint, /get_lun
;n_hint=1661   ;wavelength bins
;hintwvln=fltarr(n_hint)  ;in angstrom
;hintflux=fltarr(n_hint)  ;in  photons/cm2/s
;
;format='$(f8.2,f8.1,a11,i1,f10.6)'
;l=''
;for i=0,n_hint-1 do begin
;  readf,lun_hint,format,a,b,l,c,d
;  hintwvln(i)=a
;  hintflux(i)=b*1.e9 /1000.  ; to be in units of photons/cm2/s
;endfor
;free_lun,lun_hint
;hintener=enwv_const/hintwvln
;
;;_________________________________________________________________________________________________________________
;;_________________________________________________________________________________________________________________
;
;  
;  
;  restore, '/home/srimoyee/Desktop/nrl_files/sav_files/baseline_states.sav'
;;  file has:
;;    O_crss_states,O2_crss_states,N2_crss_states
;;    first column is wavelength
;
;
;
;
;; O base-line files
;print,'O'
;   new_bins_forstates, enwv_const,12397./reform(tpot[*,0]),wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,O_crss_states,O_prob_state,O_tot_ionz
;
;
;
;
;; O base-line files
;   print,'O2'
;  new_bins_forstates, enwv_const,12397./reform(tpot[*,1]),wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,O2_crss_states,O2_prob_state,O2_tot_ionz
;
;; O base-line files
;   print,'N2'
;   new_bins_forstates, enwv_const,12397./reform(tpot[*,2]),wavelength, wavelength_low,wavelength_high,ssflux,hintwvln,hintflux,N2_crss_states,N2_prob_state,N2_tot_ionz
;
;_________________________________________________________________________________________________________________
;_________________________________________________________________________________________________________________
; 
;   save, O_prob_state,O2_prob_state,N2_prob_state,$
;    filename= '/home/srimoyee/Desktop/nrl_files/sav_files/new_prob_states.sav'

;
;openw,lun_O,'/home/srimoyee/Desktop/nrl_files/sav_files/newO_prob.dat',/get_lun
;printf, lun_O,'Wavelength (A)','4So ','2Do ','2Po ','4P ','2P ','K '
;for i=0,n_elements(O_prob_state[0,*])-1 do $
;    printf,lun_o, O_prob_state[0,i],'  ',O_prob_state[1,i],'  ',O_prob_state[2,i],'  ',O_prob_state[3,i],' ',$
;                   O_prob_state[4,i],'  ',O_prob_state[5,i],'  ',O_prob_state[6,i]
;
;         
;openw,lun_O2,'/home/srimoyee/Desktop/nrl_files/sav_files/newO2_prob.dat',/get_lun
;printf, lun_O2,'Wavlength','X ','a+A ','b ','B ','2pi+c ','2sig ','33 eV ','2,4sig ','K '
;
;for i=0,n_elements(O2_prob_state[0,*])-1 do $
;    printf,lun_o2, O2_prob_state[0,i],'  ',O2_prob_state[1,i],'  ',O2_prob_state[2,i],'  ',$
;                   O2_prob_state[3,i],'  ',O2_prob_state[4,i],'  ',O2_prob_state[5,i],'  ',$
;                   O2_prob_state[6,i],'  ',O2_prob_state[7,i],'  ',O2_prob_state[8,i],'  ',$
;                   O2_prob_state[9,i]
;
;openw,lun_N2,'/home/srimoyee/Desktop/nrl_files/sav_files/newN2_prob.dat',/get_lun
;printf, lun_N2,'Wavlength ', 'X ','A ','B ','C ','F ','G+E','HP ','H ','N2++ ','K '
;for i=0,n_elements(N2_prob_state[0,*])-1 do $
;    printf,lun_n2, N2_prob_state[0,i],'  ',N2_prob_state[1,i],'  ',N2_prob_state[2,i],'  ',$
;                   N2_prob_state[3,i],'  ',N2_prob_state[4,i],'  ',N2_prob_state[5,i],'  ',$
;                   N2_prob_state[6,i],'  ',N2_prob_state[7,i],'  ',N2_prob_state[8,i],'  ',$
;                   N2_prob_state[9,i],'  ',N2_prob_state[10,i]
;                   
;free_lun,lun_O,lun_O2,lun_N2

;close,/all
;
;
;end




; ................................................. 2nd MAIN ...................................................
;; Testing Dr. Bailey's states
;
;; Ionisation and Absorption Thresholds
;at_n2= 986.30 ; Angstroms
;at_o2= 2000.00 ; max bins we will be having
;at_o = 913.00
;it_n2= 798.00
;;  it_o2= 1025.72 ; keep this at Ly Beta wvln as long as Fennally compilation used
;it_o2= 1032.2
;it_o = at_o
;
;
;
;restore, 'C:\Users\Srimoyee\Desktop\nrl_files\sav_files\baseline_states.sav'
;;  file has:
;;    O_crss_states,O2_crss_states,N2_crss_states
;;    first column is wavelength
;
;;  take the base-line files as it is:
;new_bins_forstates, O_crss_states,it_o,O_prob_state,o_nbins
;
;
;
;; State(Column) index: 0,3-11 for O2 i.e., Wavelength; X; a+b;b; B;2pi+c;2sig;33eV;2,4sig; K
;O2_crss=fltarr(5,n_elements(O2_crss_states[0,*]))
;O2_crss[0,*]=O2_crss_states[0,*]; wavelength
;O2_crss[4,*]=O2_crss_states[1,*]; frag
;O2_crss[1:3,*]=O2_crss_states[3:5,*]
;new_bins_forstates, O2_crss,it_o2,O2_prob_state,o2_nbins
;
;;  State(Column) index: 0,3-12 for N2 i.e., Wavelength,  X, A, B,C,F,G+E,HP,H, N2++, K
;N2_crss=fltarr(7,n_elements(N2_crss_states[0,*]))
;N2_crss[0,*]=N2_crss_states[0,*];wavelength
;N2_crss[6,*]=N2_crss_states[1,*]-N2_crss_states[6,*]-N2_crss_states[7,*]  ;Frag-C-F
;N2_crss[1:5,*]=N2_crss_states[3:7,*]
;new_bins_forstates, N2_crss,it_n2,N2_prob_state,n2_nbins
;
;
;save, O_prob_state,O2_prob_state,N2_prob_state,$
;  filename= 'C:\Users\Srimoyee\Desktop\nrl_files\sav_files\new_prob_states.sav'
;
;
;openw,lun_O,'C:\Users\Srimoyee\Desktop\nrl_files\sav_files\newO_prob.dat',/get_lun
;printf, lun_O,'Wavelength (A)','4So ','2Do ','2Po ','4P ','2P ','K '
;for i=0,n_elements(O_prob_state[0,*])-1 do $
;  printf,lun_o, O_prob_state[0,i],'  ',O_prob_state[1,i],'  ',O_prob_state[2,i],'  ',O_prob_state[3,i],' ',$
;  O_prob_state[4,i],'  ',O_prob_state[5,i],'  ',O_prob_state[6,i]
;
;
;openw,lun_O2,'C:\Users\Srimoyee\Desktop\nrl_files\sav_files\newO2_prob.dat',/get_lun
;printf, lun_O2,'Wavlength','X ','a+A ','b ','Diss'
;
;for i=0,n_elements(O2_prob_state[0,*])-1 do $
;  printf,lun_o2, O2_prob_state[0,i],'  ',O2_prob_state[1,i],'  ',O2_prob_state[2,i],'  ',$
;  O2_prob_state[3,i],'  ',O2_prob_state[4,i]
;
;openw,lun_N2,'C:\Users\Srimoyee\Desktop\nrl_files\sav_files\newN2_prob.dat',/get_lun
;printf, lun_N2,'Wavlength ', 'X ','A ','B ','C ','F ','Diss'
;for i=0,n_elements(N2_prob_state[0,*])-1 do $
;  printf,lun_n2, N2_prob_state[0,i],'  ',N2_prob_state[1,i],'  ',N2_prob_state[2,i],'  ',$
;  N2_prob_state[3,i],'  ',N2_prob_state[4,i],'  ',N2_prob_state[5,i],'  ',N2_prob_state[6,i]
;
;free_lun,lun_O,lun_O2,lun_N2
;
;close,/all
;
;
;end
;

;
;
;lowvl_lmt= 400.
;spec_ind2= where((wavelength ge wvl[0]) and (wavelength le lowvl_lmt ) )  ;for interpolation
;spec_ind1 =[spec_ind2[-1]+1:n_elements(wavelength)-1]    ; for flux weighting
;if (spec_ind2[0] ne 0) then spec_ind3 =[0:spec_ind2[0]-1]  ; for fixed probability states
;
;
;spec_wave1=wavelength[spec_ind1]       ;for flux weighting
;spec_wave_h=wavelength_high[spec_ind1]
;spec_wave_l=wavelength_low[spec_ind1]
;
;spec_en1=enwv_const/spec_wave1
;spec_en_h=enwv_const/spec_wave_l
;spec_en_l=enwv_const/spec_wave_h
;
;
;
;spec_en2=enwv_const/wavelength[spec_ind2]   ;for interpolation
;
;
;
;;_________________________________________________________________________________________________________________
;
;;Interpolating spectral bins to cross-section energy bins at higher energies
;
;crss_wvl_ind2=where(wvl le lowvl_lmt)
;
;for i=1, n_cols-1 do begin
;  nb=exp(interpol(alog(reform(crss_data[i,crss_wvl_ind2])),alog(enwv_const/reform(crss_data[0,crss_wvl_ind2])),alog(spec_en2)))
;  i_nan = where(~finite(nb), ct_nan)
;  if ct_nan ne 0 then nb[i_nan]=0.
;  new_bins[i,spec_ind2]=nb
;endfor
;
;;_________________________________________________________________________________________________________________
;
;
;; Flux weighting for states
;;Applying flux weighting (in wavelength) to higher bins
;
;ener_ind=enwv_const/reform(crss_data[0,*])   ;energies in base cross-section files
;result_hint=fltarr(n_cols-1,n_elements(hintwvln))
;
;;interpolating cross-sections to hinteregger flux
;for i=0, n_cols-2 do begin
;  rh=exp(interpol(alog(reform(crss_data[i+1,*])), alog(reform(crss_data[0,*])), alog(hintwvln)))
;  i_rh = where(~finite(rh), ct_rh)
;  if ct_rh ne 0 then rh[i_rh]=0.
;  result_hint[i,*]=rh
;endfor
;
;; flux weighting
;for i=0, n_elements(spec_wave1)-1 do begin
;  crss_ind=where((hintwvln ge spec_wave_l[i]) and (hintwvln le spec_wave_h[i]),ct_crss)  ;cross-sections between given bins
;  if (ct_crss gt 0) then begin
;    for j=1, n_cols-1 do $
;      new_bins[j,spec_ind1[i]]=total(result_hint[j-1,crss_ind]*hintflux[crss_ind])/total(hintflux[crss_ind])
;
;  endif else $
;    print,i, 'no zeros';      stop  ;check , remove later
;endfor
;
;;;Weighted Average
;;for i=0, n_elements(spec_wave1)-1 do begin
;;  crss_ind=where((reform( crss_data[0,*]) ge spec_wave_l[i]) and (reform(crss_data[0,*]) le spec_wave_h[i]),ct_crss)  ;cross-sections between given bins
;;  if (ct_crss gt 0) then begin
;;    for j=1, n_cols-1 do $
;;      new_bins[j,spec_ind1[i]]=total(crss_data[j-1,crss_ind])/ct_crss
;;
;;  endif else $
;;    print,spec_wave_l[i], 'no zeros';      stop  ;check , remove later
;;endfor
;



