Advanced techniques
===================

test
Traditionally, XBeach is used as a standalone executable that is ran
on a single XBeach model schematization, possibly distributed over
multiple processes through MPI. Nowadays, XBeach can also be used as a
BMI-compatible library. A library can be part of a larger framework
where XBeach interacts with other components during runtime. For
example:

* A graphical user interface (e.g. `Morphan
  <https://www.helpdeskwater.nl/onderwerpen/applicaties-modellen/applicaties-per/aanleg-onderhoud/aanleg-onderhoud/morphan/>`_).
  
* An interactive modeling tool that allow users to change the model
  while running (e.g. `Sandbox
  <https://www.deltares.nl/en/software/sandbox/>`_).
  
* A coupled model where XBeach runs simultaneously and interactively
  with other models (e.g.  `aeolian sediment transport model
  <http://windsurf.readthedocs.io/en/latest/>`_, ecological model or
  `XBeach itself <http://xbeachmi.readthedocs.io/en/latest/>`_!).


The XBeach library (DLL) for Windows is shipped with the daily builds
from the `Deltares build server
<http://xbeachmi.readthedocs.io/en/latest/>`_. A unix library is
compiled alongside the XBeach executable.
