
; read f107 daily values from data (csv file) data available from
;https://lasp.colorado.edu/lisird/data/penticton_radio_flux/
; also calulates the f107 81-day average
; also converts Julian date to yyyydoy
; stores the data into sav file to be used in ACE PE model

sav_loc='/home/srimoyee/Desktop/nrl_files/sav_files/'


f107_csvfile=sav_loc+'penticton_radio_flux.csv'
;input file has:
;(Julian Date),observed_flux (solar flux unit (SFU)),adjusted_flux (solar flux unit (SFU))

file_data =read_csv( f107_csvfile,count=n_records,header=header,table_header=tab_head,$
                   n_table_header=1,types=['double','float','float'])


juldate=file_data.field1
f107d=file_data.field2
f107_adj=file_data.field3


;___________________________________________________________________________________________________________________________________________________

; convert from Julian date to noemal date

caldat, juldate, month, day, year, hour, minute, second
;___________________________________________________________________________________________________________________________________________________

;get date in yyyyddd format 

doy=day*0L

for i=0, n_elements(year)-1 do begin
  if ((year[i] mod 4 eq 0 ) or (year[i] mod 400 eq 0)) then $
        n_days=[31,29,31,30,31,30,31,31,30,31,30,31] $  ;leap
  else $
    n_days=[31,28,31,30,31,30,31,31,30,31,30,31]   ;not leap
    
  for m = 0, month[i]-2 do $
      doy[i]=doy[i]+n_days[m]
  
  doy[i]=doy[i]+day[i]
  
endfor

yyyyddd=long(year*1000+doy)
;___________________________________________________________________________________________________________________________________________________

; 81 day average f107

; creating new array for f107 with  duplicate dates removed
;the duplicate dates are replaced with their average f107's 
k=0
yyyyddd_day=yyyyddd*0L
f107_day= f107d*0.0

for i= 0, n_elements(f107d)-1 do begin  
  ii=where(yyyyddd eq yyyyddd[i],count)  ;checking for duplicate dates
  f107_day[k]=mean(f107d[ii])
  yyyyddd_day[k]=yyyyddd[i]
  k++
  if count gt 1 then i=ii[-1]+1
    
endfor

yyyyddd_day=yyyyddd_day[0:k-1]
f107_day= f107_day[0:k-1]

;Implementing 81 days running average on the new average daily f107s 

f107_day_81=ts_smooth(f107_day,81)  ;81 day average f107

;Making a new array with f107 81 day averages with added duplicate dates as the original input file

f107_81=f107d*0.0

for i=0, n_elements(f107_day_81)-1 do begin
  ii=where(yyyyddd eq yyyyddd_day[i],count) 
  f107_81[ii]=f107_day_81[i]
endfor
;___________________________________________________________________________________________________________________________________________________

; save everything in output file

save, month, day, year, hour, minute, second,yyyyddd,f107d,f107_81, filename=sav_loc+'f107datafile.sav'
















end

