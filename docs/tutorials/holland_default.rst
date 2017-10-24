Holland Default
===============

The Holland Default example simulates the response of the typical
cross-shore profile of the Dutch coast to normative storm
conditions. In this tutorial this simulation will be built up step by
step. The resulting model schematization can be found here:
https://svn.oss.deltares.nl/repos/xbeach/skillbed/input/holland_default/

For this tutorial, you should have XBeach Kingdsday release or later
installed on your pc, as well as the XBeach open earth
tools. Furthermore a measured or schematized cross shore profile is
required as model geometry.

Grid and bathymetry
-------------------

The starting point of any 1D XBeach computation is the depth profile
mentioned above, it is recommended to either cut off or extend this to
the 20 m depth contour. Based on this geometry, the computational grid
and bathymetry can be constructed. Three files will have to be made:

* ``x.grd``

  This is the cross-shore grid in plain ascii format. With default
  nautical direction conventions positive x direction is due east. In
  this case the grid is non-equidistant, with a coarse offshore
  resolution and increasing resolution towards shore. The ``x.grd``
  can be generated automatically using the Matlab function
  ``xb_grid_xgrid.m`` found in the Open Earth Tools (see
  https://publicwiki.deltares.nl/display/OET/OpenEarth). The function
  helps to ensure that some numerical criteria such as grid points per
  wave length are met.

* ``y.grd``
  
  This is the longshore grid, which in this case contains only zeroes
  (with a length equal to the ``x.grd``). This type of simulation thus is
  of the 'fast 1D' type (see section 'Grid and bathymetry' of the
  manual.
  
* ``bed.dep``
  
  In this file (which is also in plain ascii) the z-values (default
  positive upwards) corresponding to the grid points in ``x.grd`` are
  put. Note that for XBeach to work properly at the seaward boundary
  at least a single horizontal cell is required. Such an adaption to
  the profile will have to be added manually.

Example Matlab code to quickly generate these files:

.. code:: matlab
   
  [xgr zgr] = xb_grid_xgrid(Xin,Zin);
  ygr = zeros(size(xgr));
  save('y.grd','ygr','-ascii');
  save('x.grd','xgr','-ascii');
  save('bed.dep','zgr','-ascii');

Wave boundary input: jonswap.txt
--------------------------------

In this example the model will be forced by a spectral condition, that
is not varying in time. The parameters to describe this condition are
written down in a single file, which may contain the following
keywords (if omitted, default values are assumed):

* Hm0 = 7.6000
  
  Significant wave height.
  
* fp = 0.0833
  
  Peak frequency of the wave spectrum (=1/Tp)
  
* mainang = 270.0000
  
  Main incident wave angle. According to the XBeach direction
  conventions (default nautical) 270 degrees implies incident from the
  West.
  
* gammajsp = 3.3000
  
  Peak enhancement factor (default) corresponding in this case to a
  JONSWAP spectrum shape.
  
* s = 10,000
  
  Directional spreading. See the manual on how s is related to
  directional spreading in degrees (Input description/Waves
  input/Spectral wave boundary conditions). Note that in this
  simulation there is only a single directional wave bin (see next
  section). This implies that waves can only propagate in a single
  direction. Directional spreading in this case therefore does not
  influence the amount of losses of wave energy outside the domain,
  but it does influence the groupiness of the waves on th emodel
  boundaty and therefore infra-gravity wave generation. It is thus
  recommended to input a high directional spreading parameter in a 1D
  computation, corresponding to waves without significant directional
  spread.
  
* fnyq = 1.0000
  
  Nyquist frequency. Energy of waves with a frequency higher than this
  frequency is mirrored around the Nyquist frequency over the other
  frequencies. This value should not lie closely to the characteristic
  frequency of the spectrum.

Main input file: params.txt
---------------------------

The params file is the main input file of any XBeach simulation. A
minimal set of default parameters, supplemented by your own
case-specific settings, can be generated using the Matlab function
``xb_generate_settings.m``. For this case the following keywords are
included in the params file:

* Grid parameters

  * depfile = bed.dep
    
    Reference to the file with the bathymetry generated under section
    1 of this tutorial.

  * nx = 230
    
    Indicates that there are 230 grid cells (and thus 231) grid points
    (entrees in the ``x.grd`` file).

  * ny = 0
    
    Indicating zero alongshore grid cells, which makes the model of
    the (fast) 1Dv type.

  * alfa = 0
    
    The rotation of the grid. See the image in this paper for an
    explanation:
    https://oss.deltares.nl/documents/48999/59759/Roelvink_2009.pdf

  * vardx = 1
    
    Indicating that the grid in x direction is non-equidistant.

  * xfile = x.grd
    
    Reference to the cross-shore grid file.

  * yfile = y.grd
    
    Reference to the alongshore grid file.

  * xori = 0
    
    The world coordinate of the x origin (not relevant in this
    simulation)

  * yori = 0
    
    The world coordinate of the y origin (not relevant in this
    simulation)

  * thetamin = 225
    
    The lower directional dimension of the wave spectrum
    discretization.

  * thetamax = 315
    
    The upper directional dimension of the wave spectrum
    discretization.

  * dtheta = 90
    
    The size of the direction bins. In this case dtheta = thetamax –
    thetamin, which implies there is only a single directional
    bin. This makes the model in essence resemble a laboratory wave
    flume in which waves can propagate in one direction only and no
    wave energy is lost through the sides of the wave flume.

  * thetanaut = 1
    
    Specifies that thetamin and thetamax are input according the
    nautical convention as opposed to the cartesian convention.
    
* Initial conditions

  * zs0 = 5
            
    Initial water level is at +5m. In the Netherlands this is
    typically at the toe of the dunes during storm set-up.
    
* Model time

  * tstop = 18000
            
    As an example a period of 5 hours is modeled.

* Wave boundary condition parameters

  * instat = jons
            
    The type of the wave boundary condition is JONSWAP. See
    http://xbeach.readthedocs.io/en/latest/_images/image24.png on how
    to arrive at the proper wave boundary type for your own
    simulation.

  * random = 0
    
    XBeach generates a wave time series. With the switch random = 0
    this time series does not have a randomness (i.e. it will always
    be the same time series for each repeat of the simulation).
    
* Wave-spectrum boundary condition parameters

  * bcfile = jonswap.txt
            
    The file containing the wave boundary conditions (see below).

  * rt = 1800
    
    The reuse time of the generated wave time series. In this case a
    time series of a duration of half an hour is generated, which is
    reused 10 times to complete the entire (5 hour) simulation.

  * dtbc = 1
    
    The discretization time step of the time series, which is 1s in
    this case. This should typically be a small value, taking into
    account the Nyquist frequency as well (see above).

* Output variables

  * tstart = 0
            
    The model output starts to be generated at t=0. If you for example
    have a spin-up time in which you are not interested in the output
    you can postpone output generation with this keyword.

  * tintg = 3600
    
    Gap between which global (instantaneous) output is written to
    file. Also mean output can be saved, which is specified with
    tintm.

  * outputformat = netcdf
    
    Format of the output.

  * nglobalvar = 1
    
    The amount of global output variables that have to be written to
    file.

  * zb

    The bed level is the only output variable. The output will contain
    6 profiles (the initial and tstop/tintg = 5 other profiles).
    
Running the model
-----------------

It is assumed here that you are running under windows (see [LINK] for
other platforms). The XBeach executable that should be placed
somewhere on your pc, for example on:
``d:\Software\XBeach\2015-10-22_XBeach_v1.22.4867_Kingsday_x64_netcdf\xbeach.exe``

Which can be run via a batch file containing a reference to that path, like this:

>>> call d:\Software\XBeach\2015-10-22_XBeach_v1.22.4867_Kingsday_x64_netcdf\xbeach.exe

Or by navigating in a command window to your folder containing the
model files and executing the above line.

Post-processing your model results
----------------------------------

Results can be visualized using the following Matlab code. Note that
you must have the Open Earth Tools loaded.

.. code:: matlab
   
   clear;
   %read the output
   xb = xb_read_output('xboutput.nc');
   [zb, DIMS] = xs_get(xb,'zb','DIMS');
   xgr = xs_get(DIMS,'x');
   
   %plot the output
   plot(xgr,zb,'linewidth',2);
   legend({'Initial profile','t=1hr','t=2hr','t=3hr','t=4hr','t=5hr'},'location','northwest')
   xlabel('x [m]'); ylabel('z [m]')
   xlim([2200 3000]); ylim([-5 16])
   grid on; title('Holland default XBeach simulation')




