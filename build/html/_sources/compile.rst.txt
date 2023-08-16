How to compile
===============

XBeach can be downloaded as executable, see:
https://download.deltares.nl/xbeach

However it is also possible to compile XBeach yourself. Both a windows and a Linux version can be compiled.

Compile on Windows
---------------------------
To compile on Windows a Fortran compiler is required.

Compile on Linux
---------------------------

Before XBeach can be compiled several libraries are requried. XBeach requires:

#. gcc

#. hdf5

#. netcdf

#. openmpi

#. anaconda3

To load the libraries the following code can be used:

.. code-block:: text
   
   module load anaconda3/py39_23.1.0-1
   module load gcc/12.2.0_gcc12.2.0
   module load hdf5/1.14.0_gcc12.2.0
   module load netcdf/4.9.2_4.6.1_gcc12.2.0
   module load openmpi/4.1.5_gcc12.2.0

Next to Python, the mako package is required. To install mako run pip install mako in a Python terminal.

To compile XBeach the following commands can be run:

.. code-block:: text
   
   make distclean
   ./autogen.sh
   FCFLAGS="-mtune=corei7-avx -funroll-loops --param max-unroll-times=4 -ffree-line-length-none -O3 -ffast-math" ./configure  --with-netcdf --with-mpi
   make
   make install
