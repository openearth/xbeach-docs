.. XBeach manual documentation master file, created by
   sphinx-quickstart on Tue Jun 27 11:12:33 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to XBeach manual's documentation!
=========================================

XBeach is an open-source numerical model which is originally developed
to simulate hydrodynamic and morphodynamic processes and impacts on
sandy coasts with a domain size of kilometers and on the time scale of
storms. Since then, the model has been applied to other types of
coasts and purposes.

The model includes the hydrodynamic processes of short wave
transformation (refraction, shoaling and breaking), long wave
(infragravity wave) transformation (generation, propagation and
dissipation), wave-induced setup and unsteady currents, as well as
overwash and inundation. The morphodynamic processes include bed load
and suspended sediment transport, dune face avalanching, bed update
and breaching. Effects of vegetation and of hard structures have been
included. The model has been validated with a series of analytical,
laboratory and field test cases using a standard set of parameter
settings.

XBeach has two modes: a hydrostatic and a non-hydrostatic mode. In the
hydrostatic mode, the short wave amplitude variation is solved
separately from the long waves, currents and morphological
change. This saves considerable computational time, with the expense
that the phase of the short waves is not simulated. A more complete
model is the non-hydrostatic model which solves all processes
including short wave motions, but with more computational demand.

The original application, funded by the U.S. Corps of Engineers in the
framework of the Morphos project and the U.S. Geological Survey, was
to be able to assess hurricane impacts on sandy beaches. Since then
with funding from the Dutch Public Works Department, the model has
been extended, applied and validated for storm impacts on dune and
urbanized coasts for the purpose of dune safety assessments. With
support from the European Commission XBeach has been validated on a
number of dissipative and reflective beaches bordering all regionall
seas in the EU.

Beyond sandy coasts, the model has been applied to coral fringing and
atoll reefs, in cooperation with and with funding by the University of
Western Australia, the USGS and the Asian Development Bank. The model
now also includes vegetative damping effects, with support of the U.S.
Office of Naval Research.

The non-hydrostatic model has been developed initially by the TU Delft
(as a prototype version of the SWASH model). For the purpose of
simulating the morphodynamic processes on gravel beaches, the model
was extended and validated with support from the University of
Plymouth. In this mode, ship-induced waves can be simulated as well,
demonstrating the flight that the model has taken since its first
inception.

This development of XBeach could not have been possible without all of
the above mentioned funding agencies and partners. It would also not
have been possible without the enthusiastic, critical and constructive
approach of all consultants, researchers, M.Sc. and Ph.D. students who
have taken up XBeach, and made it into the tool that it is today.

This manual serves as an introduction to the model and a reference
guide to its many functionalities, options and parameters. We
sincerely hope that this document will help existing and new
researchers apply the model for their purposes and advance our
knowledge of coastal hydro- and morphodynamics.

Contents:

.. toctree::
   :maxdepth: 3
   :Caption: User manual
   
   xbeach_manual



.. toctree::
   :maxdepth: 3
   :Caption: Input parameters
   
   input_parameters


.. toctree::
   :maxdepth: 3
   :Caption: Output_variables
   
   output_variables

.. toctree::
   :maxdepth: 3
   :Caption: Numerical implementation
   
   numerical_implementation

.. toctree::
   :maxdepth: 3
   :Caption: Other functionalities
   
   advanced_techniques

.. toctree::
   :maxdepth: 3
   :Caption: Tools
   
   matlab_tutorials
   matlab_toolbox
   quickplot
   rfgrid



.. toctree::
   :maxdepth: 3
   :Caption: Instruction for manual
   
   cheatsheet




.. rubric:: Bibliography

.. bibliography:: xbeach.bib
   :cited:
   :style: alpha

.. rubric:: Footnotes
   
.. [#1] Currently, this formulation is only possible when the wave shape formulation of :cite:`VanThieldeVries2009a` is applied, see :ref:`sec-wave-shape`.