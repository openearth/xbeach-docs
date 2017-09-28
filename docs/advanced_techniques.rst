Advanced techniques
===================

Traditionally, XBeach is used as a standalone executable that is ran
on a single XBeach model schematization, possibly distributed over
multiple processes through MPI. Nowadays, XBeach can also be used as a
BMI-compatible library. A library can be part of a larger framework
where XBeach interacts with other components during runtime. For
example:

* A graphical user interface
  (e.g. [https://www.helpdeskwater.nl/onderwerpen/applicaties-modellen/applicaties-per/aanleg-onderhoud/aanleg-onderhoud/morphan/|Morphan]_).
  
* An interactive modeling tool that allow users to change the model
  while running
  (e.g. [https://www.deltares.nl/en/software/sandbox/|Sandbox]_).
  
* A coupled model where XBeach runs simultaneously and interactively
  with other models (e.g.
  [http://windsurf.readthedocs.io/en/latest/|aeolian sediment transport model]_,
  ecological
  model or [http://xbeachmi.readthedocs.io/en/latest/|XBeach itself]_!).


The XBeach library (DLL) for Windows is shipped with the daily builds
from the [http://xbeachmi.readthedocs.io/en/latest/|Deltares build
server]_. A unix library is compiled alongside the XBeach executable.
