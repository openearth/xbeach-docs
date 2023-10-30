Examples
=========

This page shows examples of params files for several  applications. These params files can be used as a reference of starting point for settings up a simulations.

Field experiment: DELILAH
---------------------------

2D, surfbeat, directional spreading. Aim: comparison field data hydrodynamics

In order to verify the 2DH hydrodynamics of XBeach when forced by directionally-spread short waves, a simulation is set up to compare model results to field measurements. In this case the DELILAH field experiment at Duck, North Carolina is selected as a suitable test location. The period that is modeled is October 13th 1990, which was a stormy day, between 16:00 and 17:00 hours. For more info, check: http://oss.deltares.nl/web/xbeach/skillbe

.. code-block:: text
   
   %%% Grid parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   nx       = 177
   ny       = 70
   xori     = 0.
   yori     = 0.
   alfa     = 0.
   depfile  = zneumann.grd
   vardx    = 1
   xfile    = x.grd
   yfile    = y.grd
   posdwn   = -1
   thetamin = -75. 
   thetamax = 60. 
   dtheta   = 135.
   dtheta_s = 15.
   dtheta_s = 10
   
   %%% general %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   eps      = 0.001
   back     = 2
   leftwave = 1
   rightwave = 1
   
   %%% Time%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   tstart   = 200.
   tintg    = 1
   tintm    = 400.
   tintp    = 1.
   tstop    = 3800.
   taper    = 200.
   
   %%% Boundary condition options%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   zs0file  = tide.txt
   tideloc  = 1
   instat   = 6
   zs0      = 0.685
   
   bcfile   = vardens.txt
   

   %%% Sediment transport calculation options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   D50      = 0.0002 
   D90      = 0.0003 
   rhos     = 2650
   
   %%% Morphological calculation options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   morfac   = 0
   morstart = 3800
   por      = 0.4
   
   %%% Ouput %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   Output options
   nglobalvar = 4
   zs
   H
   ve
   hh
   
   npointvar = 1
   zs
   
   npoints = 9
   580 400
   655 400
   705 400
   725 410
   745 410
   760 410
   780 410
   805 410
   825 410
   
   
Holland Coast
---------------------------

This test simulates dune erosion of a profile at the holland coast during storm 1976.

.. code-block:: text

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%% XBeach parameter settings input file                                     %%%
   %%%                                                                          %%%
   %%% date:     30-Jul-2021 08:52:18                                           %%%
   %%% function: xb_write_params                                                %%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   %%% Bed composition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   D50             = 0.000245
   D90             = 0.000367
   
   %%% Flow boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   left            = wall
   right           = wall
   
   %%% Flow parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   %%% General %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   bedfriccoef     = 0.020000
   wavemodel       = surfbeat
   wbcEvarreduce   = 0.300000
   wbctype         = jonstable
   
   %%% Grid parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   depfile         = bed.dep
   posdwn          = 0
   nx              = 1564
   ny              = 0
   alfa            = 0
   vardx           = 1
   xfile           = x.grd
   xori            = 0
   yori            = 0
   thetamin        = -90
   thetamax        = 90
   dtheta          = 180
   
   %%% Model time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   tstop           = 151200
   
   %%% Morphology parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   morfac          = 1
   morstart        = 0
   
   %%% Physical processes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   sedtrans        = 1
   morphology      = 1
   
   %%% Roller parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   %%% Sediment transport parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   %%% Tide boundary conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   zs0file         = tide.txt
   tideloc         = 2
   
   %%% Wave breaking parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   %%% Wave-spectrum boundary condition parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   bcfile          = jonswap.txt
   random          = 0
   
   %%% Output variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   outputformat    = netcdf
   tintm           = 3600
   tintp           = 0.100000
   tintg           = 1200
   tstart          = 0
   
   nglobalvar      = 4
   H
   hh
   zs
   zb
   
   nmeanvar        = 4
   H
   hh
   zs
   zb
   
   npointvar       = 4
   H
   hh
   zs
   zb







