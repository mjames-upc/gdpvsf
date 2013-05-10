#! /bin/csh -f
source /machine/gempak/NAWIPS/Gemenviron
rm test/vcord_*.grd

# nam212
# GDFILE  = test/2013050812_nam212.gem
# GAREA   = 12.19;-133.46;57.29;-49.39

# ruc130
# GDFILE  = test/2013050812_ruc130.gem
# GAREA   = 16.28;-126.14;55.48;-57.38

# GDVINT
#
gdvint <<EOF
GDFILE  = test/2013050812_nam212.gem
GDOUTF  = test/vcord_thta_270-380.grd
GDATTIM = f00
GLEVEL  = 270-380-10
GVCORD  = pres/thta
MAXGRD  = 4000
GAREA   = 12.19;-133.46;57.29;-49.39
VCOORD  = pres
r

GDOUTF  = test/vcord_thta_270-400.grd
GLEVEL  = 270-400-10
r

GDOUTF  = test/vcord_thta_270-420.grd
GLEVEL  = 270-420-10
r

GDOUTF  = test/vcord_thta_270-440.grd
GLEVEL  = 270-440-10
r

e
EOF
gpend

# END GDVINT

echo ""
echo ""
ls -la test/*.grd
echo ""
echo ""

# GDPVSF
#
gdpvsf <<EOF2
GDFILE = test/vcord_thta_270-440.grd
GDOUTF = test/vcord_thta_270-440.grd
GFUNC   = mul(exp(10,6),abs(pvor(pres,wnd)))
GDATTIM = f00
GVCORD  = thta 
STARTL  = 270
STOPL   = 440
DESIRE  = 1.5
GDOUTL  = 15
GVOUTC  = pvbl
GPACK   =
GLIST   = thta
PMAX    = 
r

GDFILE = test/vcord_thta_270-380.grd
GDOUTF = test/vcord_thta_270-380.grd
STARTL  = 380
STOPL   = 270
r

GDFILE = test/vcord_thta_270-420.grd
GDOUTF = test/vcord_thta_270-420.grd
STARTL  = 270
STOPL   = 420
r

GDFILE = test/vcord_thta_270-400.grd
GDOUTF = test/vcord_thta_270-400.grd
STARTL  = 270
STOPL   = 400
r

e
EOF2
gpend
#
# END GDVINT

# GDINFO
#
gdinfo << EOF3
GDFILE  = test/vcord_thta_300-480.grd
GDATTIM = ALL
GVCORD  = pvbl
GFUNC   = ALL 
GLEVEL  = ALL
r


e
EOF3
#
# END GDINFO
gpend

echo ""
echo ""
ls -la test/*.grd
echo ""

gdplot2 <<EOF
GDFILE  =test/vcord_thta_270-380.grd
GDATTIM =f00
GLEVEL  =15
GVCORD  =pvbl
PANEL   =1
SKIP    =0
SCALE   =999
GDPFUN  =thta
TYPE    =f
CONTUR  =1
CINT    =10
LINE    =3
FINT    = 10/280/380
FLINE   = 24;25;26;27;23;22;21;20;19;16;15;14
HILO    =
HLSYM   = 
CLRBAR  =1/V///1;.05
WIND    =BM1
REFVEC  =
TITLE   =1
TEXT    =1
CLEAR   =n
GAREA   =dset
IJSKIP  =0
PROJ    =
MAP     =1
MSCALE  =0
LATLON  =
DEVICE  =gif|test/pvbl_1.gif|2000;2000
STNPLT  =
SATFIL  =
RADFIL=
IMCBAR=
LUTFIL=
STREAM=
POSN    =0
COLORS  =1
MARKER  =0
GRDLBL  =0
FILTER  =YES
TITLE   = 5/-1/ vcord_thta_270-380.grd
r

GDFILE  =test/vcord_thta_270-400.grd
PANEL = 2
TITLE   = 5/-1/ vcord_thta_270-400.grd
r

GDFILE  =test/vcord_thta_270-420.grd
PANEL = 3
TITLE   = 5/-1/ vcord_thta_270-420.grd
r

GDFILE  =test/vcord_thta_270-440.grd
PANEL = 4
TITLE   = 5/-1/ vcord_thta_270-440.grd
r

e
EOF
gpend

exit
