;
;; running and testing different diagnostics on the ACE PE model
;
;;Comparisons of the eden with the iri model
;
floc='/home/srimoyee/Desktop/nrl_files/sav_files/'
;
ace_pe_org=floc+'SQ05_edentemp_org.sav'
;file has: photoi, eiionz_transp,pepi, zz, ssflux, wv1,wv2,zcol,eden,etemp
restore, ace_pe_org
org_photoi=photoi 
org_eiionz_transp=eiionz_transp
org_pepi=pepi
org_zz=zz
org_ssflux=ssflux
org_wv1=wv1
org_wv2=wv2
org_zcol=zcol
org_eden=eden
org_etemp=etemp

;ace_pe_iri=floc+'SQ05_edentemp_iri.sav'
;restore, ace_pe_iri
;iri_photoi=photoi
;iri_eiionz_transp=eiionz_transp
;iri_pepi=pepi
;iri_zz=zz
;iri_ssflux=ssflux
;iri_wv1=wv1
;iri_wv2=wv2
;iri_zcol=zcol
;iri_eden=eden
;iri_etemp=etemp
;
;close,/all
;
;;____________________________________________________________________________________________________________________________________________________________________
;
;;_________________________________________PLOTS_______________________________________________________________________

plt_loc="/home/srimoyee/Desktop/nrl_files/SQ05_diag/"
;  plt_loc="/home/srimoyee/Desktop/nrl_files/SQ05Feline_plots/"

;Universal Plot variables
xg=0 ;gridstyles
yg=0
xtl=1.  ;ticklen
ytl=1.
xsg=1
ysg=1
xstl=1.
ystl=1.
colors=['red','black','dodger blue']
lstyl=[0,2,3,4,1]
postop=[0.1,0.5,0.45,0.95]
posbot=[0.1,0.1,0.45,0.45]
thck=5.
leg_loc=[0.90, 0.85]
leg_loc_left=[0.45, 0.85]
maj=['O ','O!L2!N ','N!L2!N ']
head_tilt='SQ 2005: '
;;____________________________________________________________________________________________________________________________________________________________________
;
;;Electron Density
;
;xr=[1.e2,2.e6]
;yr=[min(org_zz),max(org_zz)]
;xt='Electron Desnity(cm!U-3!N) '
;yt='Altitude (km)'
;titl=head_tilt+ 'Electron Density'
;
;
;w0 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])
;
;ed1=plot(org_eden,org_zz,name='Original Model Values',$
;  xtitle=xt,ytitle=yt,title=titl,$
;  xstyle=1,ystyle=1,yrange=yr,xrange=xr,xlog=1,$  ;xrange=xr,
;  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
;  thick=thck,color=colors[1],linestyle=lstyl[0],/current)
;
;ed2=plot(iri_eden,iri_zz,name='IRI model values',$
;  thick=thck,color=colors[0],linestyle=lstyl[2],/overplot)
;
;
;
;leg0 = LEGEND(TARGET=[ed1,ed2], POSITION=leg_loc_left,/normal)
;
;  w0.Save, plt_loc+"SQ_eden.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;;____________________________________________________________________________________________________________________________________________________________________
;
;;Electron Temp
;
;xr=[0.,3000.]
;xt='Electron Temperature (K) '
;yt='Altitude (km)'
;titl=head_tilt+ 'Electron Temperature'
;
;
;w00 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])
;
;et1=plot(org_etemp,org_zz,name='Original Model Values',$
;  xtitle=xt,ytitle=yt,title=titl,$
;  xstyle=1,ystyle=1,yrange=yr,xrange=xr,xlog=0,$  ;xrange=xr,
;  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
;  thick=thck,color=colors[1],linestyle=lstyl[0],/current)
;
;et2=plot(iri_etemp,iri_zz,name='IRI model values',$
;  thick=thck,color=colors[0],linestyle=lstyl[2],/overplot)
;
;
;
;leg00 = LEGEND(TARGET=[et1,et2], POSITION=leg_loc_left,/normal)
;
;  w00.Save, plt_loc+"SQ_etemp.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;
;;____________________________________________________________________________________________________________________________________________________________________
;
;
;Electron Impact Ionisation plot

xr=[1.,1000.]
;xt='Electron impact ionization (Pe)!C (cm!U-3!N s!U-1!N) !C (dashed- IRI edem & etemp )  '
xt='Electron impact ionization (Pe)!C (cm!U-3!N s!U-1!N) '

yt='Altitude (km)'
titl=head_tilt+ 'Electron impact ionization'


w1 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])

ei1=plot(org_eiionz_transp[0,*],org_zz,name=maj[0],$
  xtitle=xt,ytitle=yt,title=titl,$
  xstyle=1,ystyle=1,yrange=yr,xrange=xr,xlog=1,$  ;xrange=xr,
  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
  thick=thck,color=colors[0],linestyle=lstyl[0],/current)

;ei2=plot(iri_eiionz_transp[0,*],iri_zz,name=maj[0],$
;    thick=thck,color=colors[0],linestyle=lstyl[2],/overplot)

ei3=plot(org_eiionz_transp[1,*],org_zz,name=maj[1],$
  thick=thck,color=colors[1],linestyle=lstyl[0],/overplot)


;ei4=plot(iri_eiionz_transp[1,*],iri_zz,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[2],/overplot)


ei5=plot(org_eiionz_transp[2,*],org_zz,name=maj[2],$
  thick=thck,color=colors[2],linestyle=lstyl[0],/overplot)

;ei6=plot(iri_eiionz_transp[2,*],iri_zz,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[2],/overplot)


;leg1 = LEGEND(TARGET=[ei1,ei2,ei3,ei4,ei5,ei6], POSITION=leg_loc,/normal)
leg1 = LEGEND(TARGET=[ei1,ei3,ei5], POSITION=leg_loc,/normal)

  w1.Save, plt_loc+"SQ_eiionz_transp_v2.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;;_________________________________________________________________________
;
;O Photoionisation plot

xr=[1.,1000.]
;xt='Photoionisation (Pi)!C (cm!U-3!N s!U-1!N)!C (dashed- IRI edem & etemp ) '
xt='Photoionisation (Pi)!C (cm!U-3!N s!U-1!N) '

yt='Altitude (km)'
titl=head_tilt+'Photoionization'


w2 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])

pi1=plot(org_photoi[0,*],org_zz,name=maj[0],$
  xtitle=xt,ytitle=yt,title=titl,$
  xstyle=1,ystyle=1,yrange=yr,xrange=xr,xlog=1,$;,xrange=xr,
  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
  thick=thck,color=colors[0],linestyle=lstyl[0],/current)

;pi2=plot(iri_photoi[0,*],iri_zz,name=maj[0],$
;    thick=thck,color=colors[0],linestyle=lstyl[2],/overplot)

pi3=plot(org_photoi[1,*],org_zz,name=maj[1],$
  thick=thck,color=colors[1],linestyle=lstyl[0],/overplot)

;pi4=plot(iri_photoi[1,*],iri_zz,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[2],/overplot)

pi5=plot(org_photoi[2,*],org_zz,name=maj[2],$
  thick=thck,color=colors[2],linestyle=lstyl[0],/overplot)

;pi6=plot(iri_photoi[2,*],iri_zz,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[2],/overplot)


;leg2 = LEGEND(TARGET=[pi1,pi2,pi3,pi4,pi5,pi6], POSITION=leg_loc,/normal)
leg2 = LEGEND(TARGET=[pi1,pi3,pi5], POSITION=leg_loc,/normal)

  w2.Save, plt_loc+"SQ_photoi_v2.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;

;_________________________________________________________________________

;O Pe/Pi plot


xr=[0.1,1000.]
;xt='Pe/Pi !C (dashed- IRI edem & etemp )'
xt='Pe/Pi '

yt='Altitude (km)'
titl=head_tilt+'Pe/Pi'


w3 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])

pp1=plot(org_pepi[0,*],org_zz,name=maj[0],$
  xtitle=xt,ytitle=yt,title=titl,$
  xstyle=1,ystyle=1,yrange=yr,xrange=xr,xlog=1,$;,xrange=xr,
  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
  thick=thck,color=colors[0],linestyle=lstyl[0],/current)

;pp2=plot(iri_pepi[0,*],iri_zz,name=maj[0],$
;    thick=thck,color=colors[0],linestyle=lstyl[2],/overplot)


pp3=plot(org_pepi[1,*],org_zz,name=maj[1],$
  thick=thck,color=colors[1],linestyle=lstyl[0],/overplot)

;pp4=plot(iri_pepi[1,*],iri_zz,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[2],/overplot)

pp5=plot(org_pepi[2,*],org_zz,name=maj[2],$
  thick=thck,color=colors[2],linestyle=lstyl[0],/overplot)

;pp6=plot(org_pepi[2,*],org_zz,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[2],/overplot)

leg3 = LEGEND(TARGET=[pp1,pp3,pp5], POSITION=leg_loc,/normal)

  w3.Save, plt_loc+"SQ_pepi_v2.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;
;
;;____________________________________________________________________________________________________________________________________________________________________
;;
;;Solar flux
;
;xr=[0.5,1050.]
;yr=[1.e4,1.e12]
;xt='Wavelength ($\AA$)'
;yt='Solar Flux (Photons cm!U-2!N s!U-1!N))'
;titl=head_tilt+ 'Solar Flux'
;
;w4=window(window_title=head_tilt,dimension=[800,800])
;
;s1=plot((org_wv1+org_wv2)/2., org_ssflux,$
;  xtitle=xt,ytitle=yt,title=titl,$
;  ylog=1,ystyle=1,xlog=1,xstyle=1,$;xrange=xr, yrange=yr,
;  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
;  thick=thck,histogram=1,color=colors[0],linestyle=lstyl[0],/current)
;
;  w4.Save, plt_loc+"SQ_ssflux.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;;____________________________________________________________________________________________________________________________________________________________________
;;____________________________________________________________________________________________________________________________________________________________________
;;____________________________________________________________________________________________________________________________________________________________________
;;____________________________________________________________________________________________________________________________________________________________________
; SQ '05 pepi ratios comparisons with original and iri model

;SQ_paper_pepi=transpose([[217.12,  50.593,23.562,71.378, 4.995 ,2.192,1.092,0.694,0.418, 0.127 ,0.000000,0.000000,0.000000,0.000000,0.000000,$
;                          0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000],$
;                         [210.83,50.156,20.290, 59.953,4.271,1.613, 0.579 ,0.242,0.105,0.024 ,0.000000, 0.000000, 0.000000, 0.000000, 0.000000 ,$
;                          0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ],$
;                         [342.66, 80.880,32.126 ,10.834,7.789,2.859 ,0.933 ,0.361, 0.178 , 0.031  ,0.000000,0.000000,0.000000,0.000000,0.000000,$
;                          0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000]])
;
;  file_org=floc+'SQ05_pepitab_org.sav'
;;  file has: pepi,tau1h,wv1,wv2
;  restore,file_org
;  pepi_org=pepi
;  tau1h_org=tau1h
;;  
;  file_iri=floc+'SQ05_pepitab_iri.sav'
;;  file has: save,pepi,tau1h,wv1,wv2
;  pepi_iri=pepi
;  tau1h_iri=tau1h
;  restore,file_iri
;  
  ;Storing the file data in local variables

;orgrat_O=reform(pepi_org[0,*])/reform(SQ_paper_pepi[0,*])
;orgrat_O2=reform(pepi_org[1,*])/reform(SQ_paper_pepi[1,*])
;orgrat_N2=reform(pepi_org[2,*])/reform(SQ_paper_pepi[2,*])
;orgrat_o[where(~finite(orgrat_O),/null)]=0.
;orgrat_o2[where(~finite(orgrat_O2),/null)]=0.
;orgrat_N2[where(~finite(orgrat_N2),/null)]=0.
;
;irirat_O=reform(pepi_org[0,*])/reform(SQ_paper_pepi[0,*])
;irirat_O2=reform(pepi_org[1,*])/reform(SQ_paper_pepi[1,*])
;irirat_N2=reform(pepi_org[2,*])/reform(SQ_paper_pepi[2,*])
;irirat_o[where(~finite(irirat_O),/null)]=0.
;irirat_o2[where(~finite(irirat_O2),/null)]=0.
;irirat_N2[where(~finite(irirat_N2),/null)]=0.
;
;;___________________________________________________________________________________________________________________________________________________
xr=[0.0,600.]
yr=[0.,1.5]
xt='Wavelength ($\AA$)'
yt='IDL GLOW (Pe/Pi)/SQ (Pe/Pi)'
titl='SQ 2005 and IDL GLOW Pe/Pi Ratio Comparison'

w5 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])

r1=plot(wv1,orgrat_O,name=maj[0],$
  xtitle=xt,ytitle=yt,title=titl,$
  xstyle=1,ystyle=1,yrange=yr,xrange=xr,xlog=0,histogram=1,$
  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
  thick=thck,color=colors[0],linestyle=lstyl[0],/current)

r2=plot(wv1,orgrat_O2,name=maj[1],$
  thick=thck,color=colors[1],linestyle=lstyl[0],histogram=1,/overplot)


r3=plot(wv1,orgrat_N2,name=maj[2],$
  thick=thck,color=colors[2],linestyle=lstyl[0],histogram=1,/overplot)


leg5 = LEGEND(TARGET=[r1,r2,r3], POSITION=[.30,0.87],/normal)

w5.Save, plt_loc+"SQ_modratiocomp.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;;__________________________________________________________________________________________________________________________________________________
;
;head_var=['wave_lo','Model I (Org) pe/pi', 'Model II (IRI) pe/pi', 'SQ05 pe/pi (III)', 'Height','Height(Tau=1, Model II)',$
;           'Model I/Model III','Model II/Model III']
;tab_headO='O data'
;tab_headO2='O2 data'
;tab_headN2='N2 data'
;
;
;;output data file
;outfile1=floc+'SQ_pepi_Otable.csv'
;outfile2=floc+'SQ_pepi_O2table.csv'
;outfile3=floc+'SQ_pepi_N2table.csv'
;
;
;
;WRITE_CSV, outfile1, wv1,reform(pepi_org[0,*]),reform(pepi_iri[0,*]),reform(SQ_paper_pepi[0,*]),tau1h_org, tau1h_iri,$
;           orgrat_O,irirat_O,HEADER=head_var,Table_header=tab_headO
;            
;WRITE_CSV, outfile2, wv1,reform(pepi_org[1,*]),reform(pepi_iri[1,*]),reform(SQ_paper_pepi[1,*]),tau1h_org, tau1h_iri,$
;           orgrat_O2,irirat_O2,HEADER=head_var,Table_header=tab_headO2
;           
;WRITE_CSV, outfile3, wv1,reform(pepi_org[2,*]),reform(pepi_iri[2,*]),reform(SQ_paper_pepi[2,*]),tau1h_org, tau1h_iri,$
;         orgrat_N2,irirat_N2,HEADER=head_var,Table_header=tab_headN2
;
;
;;__________________________________________________________________________________________________________________________________________________
;;____________________________________________________________________________________________________________________________________________________________________
;;____________________________________________________________________________________________________________________________________________________________________
;;____________________________________________________________________________________________________________________________________________________________________
;; ace_rcolumn code check- code calculates the vertical column density, column density and chapman function
;
;;#1
;file_neut1=floc+'SQ05_pepitab_neut1.sav'
;;  file has: pepi,tau1h,wv1,wv2
;; this file has only the GOTO statement removed
;; comparing this file with the SQ05_pepitab_org.sav data
;
;
;restore,file_neut1
;pepi_neut1=pepi
;tau1h_neut1=tau1h
;
;;Storing the file data in local variables
;
;neut1rat_O=reform(pepi_neut1[0,*])/reform(SQ_paper_pepi[0,*])
;neut1rat_O2=reform(pepi_neut1[1,*])/reform(SQ_paper_pepi[1,*])
;neut1rat_N2=reform(pepi_neut1[2,*])/reform(SQ_paper_pepi[2,*])
;neut1rat_o[where(~finite(neut1rat_O),/null)]=0.
;neut1rat_o2[where(~finite(neut1rat_O2),/null)]=0.
;neut1rat_N2[where(~finite(neut1rat_N2),/null)]=0.
;
;
;head_var=['wave_lo','wave_hi','Model I pe/pi','SQ05 pe/pi (II)','Height(Tau=1, Model II)','Model I/Model II']
tab_headO='O data'
tab_headO2='O2 data'
tab_headN2='N2 data'
;
;
;;output data file
;outfile1=floc+'SQ_neut1_Otable.csv'
;outfile2=floc+'SQ_neut1_O2table.csv'
;outfile3=floc+'SQ_neut1_N2table.csv'
;
;
;
;WRITE_CSV, outfile1, wv1,wv2,reform(pepi_neut1[0,*]),reform(SQ_paper_pepi[0,*]),tau1h_neut1, neut1rat_O, $
;           HEADER=head_var,Table_header=tab_headO
;
;WRITE_CSV, outfile2, wv1,wv2,reform(pepi_neut1[1,*]),reform(SQ_paper_pepi[1,*]),tau1h_neut1, neut1rat_O2, $
;           HEADER=head_var,Table_header=tab_headO2
;
;WRITE_CSV, outfile3, wv1,wv2,reform(pepi_neut1[2,*]),reform(SQ_paper_pepi[2,*]),tau1h_neut1, neut1rat_N2, $
;           HEADER=head_var,Table_header=tab_headN2
;
;
;;___________________________________________________________________________________________________________________________________________________
;;#2
;file_neut2=floc+'SQ05_pepitab_neut2.sav'
;;  file has: pepi,tau1h,wv1,wv2
;; this file has only the improved Chapman function from the Smith 1970 paper with the correct equations 
;; comparing this file with the SQ05_pepitab_org.sav data
;
;
;restore,file_neut2
;pepi_neut2=pepi
;tau1h_neut2=tau1h
;
;;Storing the file data in local variables
;
;neut2rat_O=reform(pepi_neut2[0,*])/reform(SQ_paper_pepi[0,*])
;neut2rat_O2=reform(pepi_neut2[1,*])/reform(SQ_paper_pepi[1,*])
;neut2rat_N2=reform(pepi_neut2[2,*])/reform(SQ_paper_pepi[2,*])
;neut2rat_o[where(~finite(neut2rat_O),/null)]=0.
;neut2rat_o2[where(~finite(neut2rat_O2),/null)]=0.
;neut2rat_N2[where(~finite(neut2rat_N2),/null)]=0.
;
;
;
;
;
;;output data file
;outfile1=floc+'SQ_neut2_Otable.csv'
;outfile2=floc+'SQ_neut2_O2table.csv'
;outfile3=floc+'SQ_neut2_N2table.csv'
;
;
;
;WRITE_CSV, outfile1, wv1,wv2,reform(pepi_neut2[0,*]),reform(SQ_paper_pepi[0,*]),tau1h_neut2, neut2rat_O, $
;  HEADER=head_var,Table_header=tab_headO
;
;WRITE_CSV, outfile2, wv1,wv2,reform(pepi_neut2[1,*]),reform(SQ_paper_pepi[1,*]),tau1h_neut2, neut2rat_O2, $
;  HEADER=head_var,Table_header=tab_headO2
;
;WRITE_CSV, outfile3, wv1,wv2,reform(pepi_neut2[2,*]),reform(SQ_paper_pepi[2,*]),tau1h_neut2, neut2rat_N2, $
;  HEADER=head_var,Table_header=tab_headN2
;
;;__________________________________________________________________________________________________________________________________________________
;; checking the rcolumn values for higher zenith angle and getting rid of US standard atmosphere values used for ineterppolation

;;#1
;file_neut3=floc+'SQ05_pepitab_neut3.sav'
;;  file has: pepi,tau1h,wv1,wv2
;; this file has is with the US Standard Atmosphere
;; comparing this file with the SQ05_pepitab_neut4.sav data
;
;
;restore,file_neut3
;pepi_neut3=pepi
;tau1h_neut3=tau1h
;
;
;
;file_neut4=floc+'SQ05_pepitab_neut4.sav'
;;  file has: pepi,tau1h,wv1,wv2
;; this file has is WITHOUT the US Standard Atmosphere
;
;
;restore,file_neut4
;pepi_neut4=pepi
;tau1h_neut4=tau1h
;
;
;
;
;head_var=['wave_lo','wave_hi','Model I (with USAt)pe/pi','Model II (without USAt)pe/pi','Height(Tau=1, Model I)','Height(Tau=1, Model II)']
;
;
;;output data file
;outfile1=floc+'SQ_neut34_Otable.csv'
;outfile2=floc+'SQ_neut34_O2table.csv'
;outfile3=floc+'SQ_neut34_N2table.csv'
;
;
;
;WRITE_CSV, outfile1, wv1,wv2,reform(pepi_neut3[0,*]),reform(pepi_neut4[0,*]),tau1h_neut3, tau1h_neut4, $
;  HEADER=head_var,Table_header=tab_headO
;
;WRITE_CSV, outfile2, wv1,wv2,reform(pepi_neut3[1,*]),reform(pepi_neut4[1,*]),tau1h_neut3, tau1h_neut4, $
;  HEADER=head_var,Table_header=tab_headO2
;
;WRITE_CSV, outfile3, wv1,wv2,reform(pepi_neut3[2,*]),reform(pepi_neut4[2,*]),tau1h_neut3, tau1h_neut4, $
;    HEADER=head_var,Table_header=tab_headN2
    
;_________________________________________________________________________________________________________________________________________________
;
;zcolfile1=floc+'SQ05_zcol_neut1.sav'
;;file has: photoi, eiionz_transp,pepi, zz, ssflux, wv1,wv2,zcol,eden,etemp
;restore, zcolfile1
;zcol1=zcol
;pepi1=pepi
;zz1=zz
;
;zcolfile2=floc+'SQ05_zcol_neut2.sav'
;;file has: photoi, eiionz_transp,pepi, zz, ssflux, wv1,wv2,zcol,eden,etemp
;restore, zcolfile2
;zcol2=zcol
;pepi2=pepi
;zz2=zz
;
;zcolfile3=floc+'SQ05_zcol_neut3.sav'
;;file has: photoi, eiionz_transp,pepi, zz, ssflux, wv1,wv2,zcol,eden,etemp
;restore, zcolfile3
;zcol3=zcol
;pepi3=pepi
;zz3=zz
;
;
;;Zcol plots
;yr=[min(zz),max(zz)]
;xr=[1.,1000.]
;xt='Column Density (cm!U-2!N )!C (bold- Method1, dashed-Method 2, dash dot+- Method 3 ) '
;yt='Altitude (km)'
;titl=head_tilt+'Column Density'
;sym=1
;
;w6 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])
;
;zc1=plot(zcol1[0,*],zz1,name=maj[0],$
;  xtitle=xt,ytitle=yt,title=titl,$
;  xstyle=1,ystyle=1,yrange=yr,xlog=1,$;,xrange=xr,
;  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
;  thick=thck,color=colors[0],linestyle=lstyl[0],/current)
;
;zc2=plot(zcol2[0,*],zz2,name=maj[0],$
;    thick=thck,color=colors[0],linestyle=lstyl[2],/overplot)
;
;zc3=plot(zcol3[0,*],zz3,name=maj[0],$
;    thick=thck,color=colors[0],linestyle=lstyl[4],/overplot,symbol=sym)
;
;zc4=plot(zcol1[1,*],zz1,name=maj[1],$
;  thick=thck,color=colors[1],linestyle=lstyl[0],/overplot)
;
;zc5=plot(zcol2[1,*],zz2,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[2],/overplot)
;
;zc6=plot(zcol3[1,*],zz3,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[4],/overplot,symbol=sym)
;
;zc7=plot(zcol1[2,*],zz1,name=maj[2],$
;  thick=thck,color=colors[2],linestyle=lstyl[0],/overplot)
;
;zc8=plot(zcol2[2,*],zz2,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[2],/overplot)
;
;zc9=plot(zcol3[2,*],zz3,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[4],/overplot,symbol=sym)
;
;
;leg6 = LEGEND(TARGET=[zc1,zc2,zc3,zc4,zc5,zc6,zc7,zc8,zc9], POSITION=leg_loc,/normal)
;;
;  w6.Save, plt_loc+"SQ_zcol_neut.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;  
;  ;pepi plots
;  yr=[min(zz),max(zz)]
;  xr=[0.001,1.e5]
;  xt='Pe/Pi (bold- Method1, dashed-Method 2, dash dot+- Method 3 ) '
;  yt='Altitude (km)'
;  titl=head_tilt+'Pe/Pi ratio'
;  sym=1
;
;  w7 = WINDOW(WINDOW_TITLE=head_tilt,DIMENSIONS=[800,800])
;
;  pp1=plot(pepi1[0,*],zz1,name=maj[0],$
;    xtitle=xt,ytitle=yt,title=titl,$
;    xstyle=1,ystyle=1,yrange=yr,xrange=xr,xlog=1,$;,xrange=xr,
;    xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
;    thick=thck,color=colors[0],linestyle=lstyl[0],/current)
;
;  pp2=plot(pepi2[0,*],zz2,name=maj[0],$
;    thick=thck,color=colors[0],linestyle=lstyl[2],/overplot)
;
;  pp3=plot(pepi3[0,*],zz3,name=maj[0],$
;    thick=thck,color=colors[0],linestyle=lstyl[4],/overplot,symbol=sym)
;
;  pp4=plot(pepi1[1,*],zz1,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[0],/overplot)
;
;  pp5=plot(pepi2[1,*],zz2,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[2],/overplot)
;
;  pp6=plot(pepi3[1,*],zz3,name=maj[1],$
;    thick=thck,color=colors[1],linestyle=lstyl[4],/overplot,symbol=sym)
;
;  pp7=plot(pepi1[2,*],zz1,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[0],/overplot)
;
;  pp8=plot(pepi2[2,*],zz2,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[2],/overplot)
;
;  pp9=plot(pepi3[2,*],zz3,name=maj[2],$
;    thick=thck,color=colors[2],linestyle=lstyl[4],/overplot,symbol=sym)
;
;
;  leg7 = LEGEND(TARGET=[pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,pp9], POSITION=leg_loc,/normal)
;  ;
;  w7.Save, plt_loc+"SQ_pepi_neut.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT
;;__________________________________________________________________________________________________________________________________________________
;;#1
;file_neut5=floc+'SQ05_pepitab_neut5.sav'
;;  file has: pepi,tau1h,wv1,wv2
;; this file has is the original zvcd code
;restore,file_neut5
;pepi_neut5=pepi
;tau1h_neut5=tau1h
;
;
;
;file_neut6=floc+'SQ05_pepitab_neut6.sav'
;;  file has: pepi,tau1h,wv1,wv2
;; this file is with simple summation approach to zvcd calculation
;restore,file_neut6
;pepi_neut6=pepi
;tau1h_neut6=tau1h
;
;file_neut7=floc+'SQ05_pepitab_neut7.sav'
;;  file has: pepi,tau1h,wv1,wv2
;; this file is with int_tabulated approach to zvcd calculation
;restore,file_neut7
;pepi_neut7=pepi
;tau1h_neut7=tau1h
;
;
;
;head_var=['wave_lo','wave_hi','Method 1 pe/pi','Method 2 pe/pi','Method 3 pe/pi','Height(Tau=1, Model 1)',$
;          'Height(Tau=1, Model 2)','Height(Tau=1, Method 3)']
;
;
;;output data file
;outfile1=floc+'SQ_neut567_Otable.csv'
;outfile2=floc+'SQ_neut567_O2table.csv'
;outfile3=floc+'SQ_neut567_N2table.csv'
;
;
;
;WRITE_CSV, outfile1, wv1,wv2,reform(pepi_neut5[0,*]),reform(pepi_neut6[0,*]),reform(pepi_neut7[0,*]),tau1h_neut5, tau1h_neut6,tau1h_neut7, $
;  HEADER=head_var,Table_header=tab_headO
;
;WRITE_CSV, outfile2, wv1,wv2,reform(pepi_neut5[1,*]),reform(pepi_neut6[1,*]),reform(pepi_neut7[1,*]),tau1h_neut5, tau1h_neut6,tau1h_neut7, $
;  HEADER=head_var,Table_header=tab_headO2
;
;WRITE_CSV, outfile3, wv1,wv2,reform(pepi_neut5[2,*]),reform(pepi_neut6[2,*]),reform(pepi_neut7[2,*]),tau1h_neut5, tau1h_neut6,tau1h_neut7, $
;    HEADER=head_var,Table_header=tab_headN2
;__________________________________________________________________________________________________________________________________________________

;file_sza1=floc+'SQ05_sza6_4.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file_sza1
;pepi_sza1=pepi
;tau1h_sza1=tau1h
;sza1= '1.'+ string(sza*!radeg)
;
;file_sza2=floc+'SQ05_sza5_16.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file_sza2
;pepi_sza2=pepi
;tau1h_sza2=tau1h
;sza2= '2.'+string(sza*!radeg)
;
;file_sza3=floc+'SQ05_sza4_31.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file_sza3
;pepi_sza3=pepi
;tau1h_sza3=tau1h
;sza3= '3.'+string(sza*!radeg)
;
;file_sza4=floc+'SQ05_sza3_46.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file_sza4
;pepi_sza4=pepi
;tau1h_sza4=tau1h
;sza4= '4.'+string(sza*!radeg)
;
;file_sza5=floc+'SQ05_sza2_61.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file_sza5
;pepi_sza5=pepi
;tau1h_sza5=tau1h
;sza5= '5.'+string(sza*!radeg)
;
;file_sza6=floc+'SQ05_sza1_76.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file_sza6
;pepi_sza6=pepi
;tau1h_sza6=tau1h
;sza6='6.'+string(sza*!radeg)
;
;
;
;head_var1=['wave_lo','wave_hi',sza1,sza2,sza3,'1.Height(Tau=1)','2.Height(Tau=1)','3.Height(Tau=1)']
;
;head_var2=['wave_lo','wave_hi',sza4,sza5,sza6,'4.Height(Tau=1)','5.Height(Tau=1)','6.Height(Tau=1)']
;
;;output data file
;outfileO1=floc+'SQ_sza123_Otable.csv'
;outfileO2=floc+'SQ_sza456_Otable.csv'
;
;outfileO21=floc+'SQ_sza123_O2table.csv'
;outfileO22=floc+'SQ_sza456_O2table.csv'
;
;outfileN21=floc+'SQ_sza123_N2table.csv'
;outfileN22=floc+'SQ_sza456_N2table.csv'
;
;
;
;WRITE_CSV, outfileO1, wv1,wv2,reform(pepi_sza1[0,*]),reform(pepi_sza2[0,*]),reform(pepi_sza3[0,*]),tau1h_sza1, tau1h_sza2,tau1h_sza3, $
;  HEADER=head_var1,Table_header=tab_headO
;
;WRITE_CSV, outfileO21, wv1,wv2,reform(pepi_sza1[1,*]),reform(pepi_sza2[1,*]),reform(pepi_sza3[1,*]),tau1h_sza1, tau1h_sza2,tau1h_sza3, $
;  HEADER=head_var1,Table_header=tab_headO2
;
;WRITE_CSV, outfileN21, wv1,wv2,reform(pepi_sza1[2,*]),reform(pepi_sza2[2,*]),reform(pepi_sza3[2,*]),tau1h_sza1, tau1h_sza2,tau1h_sza3, $
;  HEADER=head_var1,Table_header=tab_headN2
;  
;  
;  WRITE_CSV, outfileO2, wv1,wv2,reform(pepi_sza4[0,*]),reform(pepi_sza5[0,*]),reform(pepi_sza6[0,*]),tau1h_sza4, tau1h_sza5,tau1h_sza6, $
;    HEADER=head_var2,Table_header=tab_headO
;
;  WRITE_CSV, outfileO22, wv1,wv2,reform(pepi_sza4[1,*]),reform(pepi_sza5[1,*]),reform(pepi_sza6[1,*]),tau1h_sza4, tau1h_sza5,tau1h_sza6, $
;    HEADER=head_var2,Table_header=tab_headO2
;
;  WRITE_CSV, outfileN22, wv1,wv2,reform(pepi_sza4[2,*]),reform(pepi_sza5[2,*]),reform(pepi_sza6[2,*]),tau1h_sza4, tau1h_sza5,tau1h_sza6, $
;    HEADER=head_var2,Table_header=tab_headN2





;__________________________________________________________________________________________________________________________________________________

;file1=floc+'NRL_pepitab_m5time0.sav'
;;  file has: pepi,tau1h,wv1,wv2
;restore,file1
;pepi1=pepi
;tau1h1=tau1h
;
;file2=floc+'NRL_pepitab_m5time316.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file2
;pepi2=pepi
;tau1h2=tau1h
;
;file3=floc+'NRL_pepitab_x9time0.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file3
;pepi3=pepi
;tau1h3=tau1h
;
;file4=floc+'NRL_pepitab_x9time720.sav'
;;  file has: pepi,tau1h,wv1,wv2,sza
;restore,file4
;pepi4=pepi
;tau1h4=tau1h
;
;
;
;
;head_var1=['wave_lo','wave_hi','Pe/Pi M5 time=0','Pe/Pi M5 time=316','Pe/Pi X9 time=0','Pe/Pi X9 time=720']
;
;head_var2=['wave_lo','wave_hi','Height(Tau=1)M5 time=0','Height(M5 time=316)','Height(X9 time=0)','Height(X9 time=720)']
;
;;output data file
;outfile1=floc+'NRL_Opepi_table.csv'
;outfile2=floc+'NRL_O2pepi_table.csv'
;outfile3=floc+'NRL_N2pepi_table.csv'
;
;outfile4=floc+'NRL_ht_table.csv'
;
;
;
;WRITE_CSV, outfile1, wv1,wv2,reform(pepi1[0,*]),reform(pepi2[0,*]),reform(pepi3[0,*]),reform(pepi4[0,*]), $
;  HEADER=head_var1,Table_header=tab_headO
;
;WRITE_CSV, outfile2, wv1,wv2,reform(pepi1[1,*]),reform(pepi2[1,*]),reform(pepi3[1,*]),reform(pepi4[1,*]), $
;  HEADER=head_var1,Table_header=tab_headO2
;
;WRITE_CSV, outfile3, wv1,wv2,reform(pepi1[2,*]),reform(pepi2[2,*]),reform(pepi3[2,*]),reform(pepi4[2,*]), $
;  HEADER=head_var1,Table_header=tab_headN2
;
;
;WRITE_CSV, outfile4, wv1,wv2,tau1h1, tau1h2,tau1h3,tau1h4, $
;  HEADER=head_var2

 ;__________________________________________________________________________________________________________________________________________________
; SQ pe/pi with Auger wavelength check
 
; head_var=['wave_lo','wave_hi','IDL Glow pe/pi (I)', 'SQ05 pe/pi (II)','Height(Tau=1, Model I)','Model I/Model II']
; tab_headO='O data'
; tab_headO2='O2 data'
; tab_headN2='N2 data'
; 
; 
; ;output data file
; outfile1=floc+'SQ_pepi_Omodtable.csv'
; outfile2=floc+'SQ_pepi_O2modtable.csv'
; outfile3=floc+'SQ_pepi_N2modtable.csv'
; 
; 
; 
; WRITE_CSV, outfile1, wv1,wv2,reform(pepi_org[0,*]),reform(SQ_paper_pepi[0,*]),tau1h_org,orgrat_O,$
;            HEADER=head_var,Table_header=tab_headO
; 
; WRITE_CSV, outfile2, wv1,wv2,reform(pepi_org[1,*]),reform(SQ_paper_pepi[1,*]),tau1h_org,orgrat_O2,$
;            HEADER=head_var,Table_header=tab_headO2
; 
; WRITE_CSV, outfile3, wv1,wv2,reform(pepi_org[2,*]),reform(SQ_paper_pepi[2,*]),tau1h_org,orgrat_N2,$
;          HEADER=head_var,Table_header=tab_headN2
; 
 
 
end