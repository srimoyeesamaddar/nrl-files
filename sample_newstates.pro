pro sample_newstates
;plots of the base-line states for check

enwv_const=12397.

restore, 'C:\Users\srimo\Desktop\nrl_files\sav_files\baseline_states.sav'
;  file has:
;    O_crss_states,O2_crss_states,N2_crss_states
;    first column is wavelength


;Plot variables.......................................


colors=['pur5','olive','orange','red','dodger blue','ygb4',$
        'deep pink','purple', 'slate blue','blue','navy','gold']
pos1=[0.1,0.1,0.9,0.4]
pos2=[0.1,0.5,0.9,0.9]
;xr_wv=[0.1,1.5e3]
;yr_wv=[1.e-24,1.e-16]
;xr_en=[1.e1,1.e4]
;yr_en=[1.e-20,1.e-16]
;
xr_wv=[1.,1000.]
yr_wv=[0.,2.e-18]
xr_en=[10.,1000.]
yr_en=[0.,2.e-18]

xlg=0
ylg=0
xt_e='Energy (eV)'
xt_wv='Wavelength (Angstrom)'



tilt=['C','F','G+E','HP', 'H','K']
thck=3
symb=-46
box_loc_u=[0.9, 0.9]
box_loc_l=[0.32, 0.40]
legend_algn=1
;p_sym=[15,15,15,15,15,15,15,15,15,15,15,15]
p_sym=[15,15,15,15,15,15]
loc='C:\Users\srimo\Desktop\nrl_files\sample_plots\'
ext=['.ps','.pdf','.jpeg']


;.............................................N2 Plots..............................................

;#1 
colr=0
yt=' N2 Dissociation !C Cross section (cm^2)'
cgps_open, filename='C:\Users\srimo\Desktop\nrl_files\plots2\states_cross_plots.ps'
cgdisplay,1000,1000, /free

;cgplot,enwv_const/N2_crss_states[0,*],N2_crss_states[6,*],thick=thck,color=colors[colr],$
;  xtitle=xt_e,ytitle=yt,position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
; colr+=1
;for i=7, ((size(N2_crss_states))[1])-3 do begin
;  cgplot,enwv_const/N2_crss_states[0,*],N2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
;  colr+=1
;endfor
;;print, colr
;cgplot,enwv_const/N2_crss_states[0,*],N2_crss_states[12,*],thick=thck,color=colors[colr],/overplot
;;colr+=1
;;cgplot,enwv_const/N2_crss_states[0,*],N2_crss_states[1,*],thick=thck,psym=symb,color=colors[colr],/overplot
;cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr],alignment=legend_algn,/box,Location=box_loc_r


;#2 
colr=0
cgplot,N2_crss_states[0,*],N2_crss_states[6,*],thick=thck,color=colors[colr],$
          xtitle=xt_wv,ytitle=yt,position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
colr+=1
for i=7, ((size(N2_crss_states))[1])-3 do begin
         cgplot,N2_crss_states[0,*],N2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
         colr+=1
endfor
cgplot,N2_crss_states[0,*],N2_crss_states[12,*],thick=thck,color=colors[colr],/overplot
;colr+=1
;cgplot,N2_crss_states[0,*],N2_crss_states[1,*],thick=thck,psym=symb,color=colors[colr],/overplot
cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr],alignment=legend_algn,/box,Location=box_loc_u





;...............................................................................................
;...............................................................................................

;#3

;xr_wv=[0.1,1.5e3]
;yr_wv=[1.e-24,1.e-16]
;xr_en=[1.e1,1.e4]
;yr_en=[1.e-20,1.e-16]

xr_wv=[1.,1000.]
yr_wv=[0.,5.e-17]
xr_en=[0.,100.]
yr_en=[0.,5.e-17]

xlg=0
ylg=0

tilt=['N2++','X','A','B']
p_sym=[15,15,15,15]
colr=0
;cgdisplay,1000,1000, /free
;;cgps_open, filename=loc+'states_cross_plots.ps'
;cgplot,enwv_const/N2_crss_states[0,*],N2_crss_states[11,*],thick=thck,color=colors[colr],$
;  xtitle=xt_e,ytitle=yt,position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
;  colr+=1
;for i=3, 5 do begin
;  cgplot,enwv_const/N2_crss_states[0,*],N2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
;  colr+=1
;endfor
;;print, colr
;cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr-1],alignment=legend_algn,/box,Location=box_loc_r

;#4
yt='N2 Ionisation !C Cross section (cm^2)'
colr=0
cgplot,N2_crss_states[0,*],N2_crss_states[11,*],thick=thck,color=colors[colr],/noerase,$
  xtitle=xt_wv,ytitle=yt,position=pos1,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
colr+=1
for i=3,5 do begin
  cgplot,N2_crss_states[0,*],N2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
  colr+=1
endfor
;print, colr
cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr-1],alignment=legend_algn,/box,Location=box_loc_l









;.............................................O2 Plots..............................................

;xr_wv=[0.1,1.5e3]
;yr_wv=[1.e-24,1.e-16]
;xr_en=[1.e1,1.e4]
;yr_en=[1.e-20,1.e-16]
;
xr_wv=[1.,1000.]
yr_wv=[0.,6.e-18]
xr_en=[1.,1000.]
yr_en=[0.,6.e-18]

;Wavlength FRAG O2+ X a+A b B 2pi+c 2sig 33 eV 2,4sig K 
tilt=['B','2pi+C','2sig', '33 eV' ,'2,4sig', 'K']
thck=3
symb=-46
p_sym=[15,15,15,15,15,15]


;#1
yt='O2 Dissociation !C Cross section (cm^2)'
colr=0
cgdisplay,1000,1000, /free

;cgplot,enwv_const/O2_crss_states[0,*],O2_crss_states[6,*],thick=thck,color=colors[colr],$
;       xtitle=xt_e,ytitle=yt,position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
;colr+=1
;for i=7, 11 do begin
;  cgplot,enwv_const/O2_crss_states[0,*],O2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
;  colr+=1
;endfor
;;print, colr
;cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr-1],alignment=legend_algn,/box,Location=box_loc_r
;

;#2
colr=0
cgplot,O2_crss_states[0,*],O2_crss_states[6,*],thick=thck,color=colors[colr],$
       xtitle=xt_wv,ytitle=yt,position=pos2,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
colr+=1
for i=7,11 do begin
  cgplot,O2_crss_states[0,*],O2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
  colr+=1
endfor
tot= fltarr(n_elements(O2_crss_states[0,*]))
;for i=0, n_elements(O2_crss_states[0,*])-1 do tot[i]=total(O2_crss_states[6:11,i])
;cgplot,O2_crss_states[0,*],tot,psym=-46,color='orange', thick=3,/overplot
cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr-1],alignment=legend_algn,/box,Location=box_loc_u
;cgdisplay, 1000,1000,/free



;...............................................................................................
;...............................................................................................

;#3

;xr_wv=[0.1,1.5e3]
;yr_wv=[1.e-24,1.e-16]
;xr_en=[1.e1,1.e4]
;yr_en=[1.e-20,1.e-16]

xr_wv=[1.,1050.]
yr_wv=[0.,5.e-17]
xr_en=[0.,100.]
yr_en=[0.,5.e-17]

xlg=0
ylg=0

tilt=['X','a+A','b']
p_sym=[15,15,15]
yt='O2 Ionisation !C Cross section (cm^2)'
colr=0
;cgdisplay,1000,1000, /free
;cgplot,enwv_const/O2_crss_states[0,*],O2_crss_states[3,*],thick=thck,color=colors[colr],$
;       xtitle=xt_e,ytitle=yt,position=pos1,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
;colr+=1
;
;for i=4, 5 do begin
;  cgplot,enwv_const/O2_crss_states[0,*],O2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
;  colr+=1
;endfor
;;print, colr
;cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr-1],alignment=legend_algn,/box,Location=box_loc_r

;#4
colr=0
cgplot,O2_crss_states[0,*],O2_crss_states[3,*],thick=thck,color=colors[colr],/noerase,$
       xtitle=xt_wv,ytitle=yt,position=pos1,xr=xr_wv,yr=yr_wv, xlog=xlg,ylog=ylg,/xs,/ys
colr+=1
for i=4,5 do begin
  cgplot,O2_crss_states[0,*],O2_crss_states[i,*],thick=thck,color=colors[colr],/overplot
  colr+=1
endfor
print, colr
cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr-1],alignment=legend_algn,/box,Location=box_loc_l


;.....................................O plots................................................................



xr_wv=[1.,1000.]
yr_wv=[0.,6.e-18]
xr_en=[1.,1000.]
yr_en=[0.,6.e-18]

;Wavlength 
tilt=['4So','2Do','2Po', '4Pe' ,'2Pe', 'K']
thck=3
symb=-46
p_sym=[15,15,15,15,15,15]
box_loc=[0.33, 0.90]
yt='O Ionisation Cross section (cm^2)'

;#1
colr=0
cgdisplay,1000,1000, /free

cgplot,O_crss_states[0,*],O_crss_states[1,*],thick=thck,color=colors[colr],$
  xtitle=xt_e,ytitle=yt,xr=xr_en,yr=yr_en, xlog=xlg,ylog=ylg,/xs,/ys
colr+=1
for i=2, 6 do begin
  cgplot,O_crss_states[0,*],O_crss_states[i,*],thick=thck,color=colors[colr],/overplot
  colr+=1
endfor
;print, colr
cglegend, titles=tilt,psyms=p_sym,symcolors=colors[0:colr-1],alignment=legend_algn,/box,Location=box_loc





 cgps2pdf,'C:\Users\srimo\Desktop\nrl_files\plots2\states_cross_plots.ps',$
          'C:\Users\srimo\Desktop\nrl_files\plots2\states_cross_plots.pdf', $
           gs_path='C:\Program Files\gs\gs9.27'
cgps_close,/pdf











end

