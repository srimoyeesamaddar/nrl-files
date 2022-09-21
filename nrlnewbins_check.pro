cal=[2.48E-05,1.47E-04,4.57E-04,1.02E-03,1.90E-03,4.00E-03,8.55E-03,$
     1.55E-02,3.12E-02,6.32E-02,0.14,0.3]



model=[3.38E-05,1.49E-04,4.55E-04,1.03E-03,2.04E-03,3.91E-03,8.59E-03,$
       1.56E-02,3.15E-02,6.43E-02,1.41E-01,3.02E-01]
       
wave=[0.75,1.25,1.75,2.25,2.75,3.5,4.5,5.5,7,9,12,16];

plt_loc="/home/srimoyee/Desktop/nrl_files/newNRL_plots/"

;Universal Plot variables
xg=0 ;gridstyles
yg=0
xtl=1.  ;ticklen
ytl=1.
xsg=1
ysg=1
xstl=1.
ystl=1.

colors=['red','dodger blue','dark green','purple']
lstyl=[0,2,3,4]
postop=[0.1,0.5,0.45,0.95]
posbot=[0.1,0.1,0.45,0.45]
thck=2.
sym_thck=5.
leg_loc=[0.90, 0.85]
leg_loc_left=[0.37, 0.87]
maj=['O ','O!L2!N ','N!L2!N ']
leg_nam=['Calculated', 'Model']

head_tilt='NRL spectrum '


yr=[min([cal,model]),10.];max([cal,model])
xr=[0.1,20.]
xt='Wavelength ($\AA$)'
yt='Absorption cross-section (mega-barns)'
titl=head_tilt+maj[2]+ ' cross-section'


w10=window(window_title='N2 cross-section',dimension=[800,800])

s1=plot(wave, cal, name=leg_nam[0],$
  xtitle=xt,ytitle=yt,title=titl,$
  xrange=xr,yrange=yr, ylog=1,ystyle=1,xlog=0,xstyle=1,$;
  xgridstyle=xg,ygridstyle=yg,xticklen=xtl,yticklen=ytl,xsubgridstyle=xsg,ysubgridstyle=ysg,xsubticklen=xstl,ysubticklen=ystl,$
  thick=thck,color=colors[0],linestyle=lstyl[0],symbol="*",sym_color=colors[0],sym_thick=sym_thck,/current)

s2=plot(wave, model, name=leg_nam[1],$
  thick=thck,color=colors[1],linestyle=lstyl[0],symbol="*",sym_color=colors[1],sym_thick=sym_thck,/overplot)




leg10 = LEGEND(TARGET=[s1,s2], POSITION=leg_loc,/normal)

w10.Save, plt_loc+"N2abscomp.jpeg", BORDER=10, RESOLUTION=600, /TRANSPARENT






end
