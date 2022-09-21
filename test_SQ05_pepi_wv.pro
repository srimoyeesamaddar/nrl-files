; checking the difference between the ratios of the idl Golw model and the SQ'05 paper

idl_glow_pepi=fltarr(3,22)

SQ_paper_pepi=fltarr(3,22)


idl_glow_pepi=transpose([[295.444, 59.7878,34.6440,72.3536,5.12058,2.29358,1.17676,0.795618,0.510741,0.156982,0.000000,0.000000,0.000000,0.000000,0.000000,$
               0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000],$
               [262.627,51.8636,30.0375, 62.6253,4.32537,1.69585,0.630813,0.282048,0.136741,0.0316489,0.000000, 0.000000, 0.000000, 0.000000, 0.000000 ,$
               0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ],$
               [429.48,81.6223,45.3131,11.0737,7.93148,2.98658,1.00989 ,0.415923 ,0.227327, 0.0405635 ,0.000000,0.000000,0.000000,0.000000,0.000000,$
               0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000]])
               
SQ_paper_pepi=transpose([[217.12,  50.593,23.562,71.378, 4.995 ,2.192,1.092,0.694,0.418, 0.127 ,0.000000,0.000000,0.000000,0.000000,0.000000,$
               0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000],$
               [210.83,50.156,20.290, 59.953,4.271,1.613, 0.579 ,0.242,0.105,0.024 ,0.000000, 0.000000, 0.000000, 0.000000, 0.000000 ,$
               0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ,0.000000 ],$
               [342.66, 80.880,32.126 ,10.834,7.789,2.859 ,0.933 ,0.361, 0.178 , 0.031  ,0.000000,0.000000,0.000000,0.000000,0.000000,$
               0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000]])
               

;SQ'05
wavelength_low=[0.5,4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,650.,798.,798.,798.,913.,$
               913.,913.,975.,987.,1027.]

wavelength_high=[4.,8.,18.,32.,70.,155.,224.,290.,320.,540.,650.,798.,798.,913.,913.,913.,$
               975.,975.,975.,987.,1027.,1050.]



glow_Sq_ratio=idl_glow_pepi/Sq_paper_pepi
glow_Sq_ratio[where(~finite(glow_Sq_ratio),/null)]=0.

;___________________________________________________________________________________________________________________________________________________________________

; Plots for the ratios
plt_loc='C:\Users\srimo\Desktop\nrl_files\SQ_plots_mar2020\'
xr=[min(wavelength_low),max(wavelength_high)]
xg=0 ;gridstyles
yg=0
xtl=1.  ;ticklen
ytl=1.
xl=1
yl=0
xsg=1
ysg=1
xstl=1.
ystl=1.
thck=5
colors=['red','black','dodger blue']
maj=['O','O!L2!N','N!L2!N']
tit='Pe/Pi ratio comparisons'
xt='Wavelength ($\AA$)'
yt='Ratio of IDL glow and Sq2005 Pe/Pi'

w1=window(window_title='Pe/Pi ratio comparisons',dimensions=[800,800])
pp1= plot(wavelength_low,glow_Sq_ratio[0,*],/current,$
          histogram=1,xlog=xl,ylog=yl,$
          xtitle=xt, ytitle=yt,title=maj[0]+tit,thick=thck,color=colors[0],$
          xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl)
          
w1.save, plt_loc+"O_IDLSQratio.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT

w2=window(window_title='Pe/Pi ratio comparisons',dimensions=[800,800])
pp1= plot(wavelength_low,glow_Sq_ratio[1,*],/current,$
          histogram=1,xlog=xl,ylog=yl,$
          xtitle=xt, ytitle=yt,title=maj[1]+tit,thick=thck,color=colors[1],$
          xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl)
w2.save, plt_loc+"O2_IDLSQratio.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT

w3=window(window_title='Pe/Pi ratio comparisons',dimensions=[800,800])
pp1= plot(wavelength_low,glow_Sq_ratio[2,*],/current,$
          histogram=1,xlog=xl,ylog=yl,$
          xtitle=xt, ytitle=yt,title=maj[2]+tit,thick=thck,color=colors[2],$
          xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl)
w3.save, plt_loc+"N2_IDLSQratio.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT











end