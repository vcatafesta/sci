The enclosed object file __WAIT_B.OBJ is used to fix a problem with
Clipper applications terminating at startup with either an "R6003
divide by zero" message, an "unexpected interrupt" message, or no error
message at all. This problem has appeared with the release of new
advanced design microprocessors. These new CPUs run "software timing
loops" so rapidly that a software timing loop module which is part of
Nantucket Tools II and CA-Tools III cannot work as designed. Not all
Tools functions use the software timing loop, but it appears to be
linked into your application if you're using either the CTUS.OBJ or
CTUSP.OBJ extended drivers, windowing, or timing functions ( such as
MilliSec() ).

Initially, only computers with the Cyrix 6x86 and AMD K5 processors were
having this problem while computers with Intel processors were immune.
However, computers with fast Intel CPUs, including the Celeron, are now
having the problem. Please note this problem is not caused by a defect
in the CPUs.

AMD apparently has no "fix" of their own, but it's been reported that
disabling their "Branch Prediction Logic" will correct the problem.

Cyrix has a "fix" posted on their web site at http://www.cyrix.com
Their fix consists of an executable named PIPELOOP.EXE that is run from
the AUTOEXEC.BAT file and causes timing loops to be slowed down for
every program running on the computer.

Another "fix," which seems to work for all vendors, is to disable the
CPU internal cache, which will significantly degrade all performance.
This is probably a good way to troubleshoot the problem, though.

Just add __WAIT_B.OBJ to your link script ahead of the libraries and
ahead of the Tools IIIb extended driver file (CTUS.OBJ or CTUSP.OBJ), if
used. If you're using PLL files created by RTLINK, you must recreate
them.

PIPELOOP.EXE from Cyrix is no longer needed. __WAIT_B.OBJ been tested on
Clipper 5.2 and 5.3 (see note below). It should work on 5.01a as well,
but no one has reported using it on that version.

The file name itself isn't significant. It's just a new name to
differentiate it from earlier versions.


5.3 USAGE
---------
CA has released their own fix as part of the 5.3b patch in the form
of an object file named __WAIT_4.OBJ. I did some quick tests and found
it seems to work OK in 5.2 also, but as usual, use it at your own risk,
and only if you're licensed to use CA-Clipper version 5.3.


SHOULD I USE __WAIT_B.OBJ OR __WAIT_4.OBJ?
------------------------------------------
Since __WAIT_4.OBJ is an official Computer Associates patch, it should
be better, and it does work better with certain functions such as
MilliSec() (see the "Compatibility Problems" section below) . Note that
only licensed users of CA-Clipper 5.3 are legally allowed to use it,
since it was included with the 5.3b patch.

However, some people have reported that using __WAIT_4.OBJ caused
lockups when run under OS/2, while __WAIT_B.OBJ worked fine. Hopefully,
you don't need to run the MilliSec() function under OS/2.


SHOULD I INCLUDE IT EVEN IF I'M NOT HAVING PROBLEMS?
----------------------------------------------------
Many people believed this problem was limited to non-Intel CPUs.
Although initially it was, it's now appearing with Intel also.
Personally, I'm including __WAIT_B.OBJ in all programs even though I
don't think it's needed for me.


COMPATIBILITY PROBLEMS
----------------------
As of Dec. 1998, only one compatibility issue has come up. If you're
using the Tools IIIb function MilliSec() with a delay of less than 256
milliseconds, it no longer works.

I tested the 5.3b patch file __WAIT_4.OBJ in a 5.2e application and the
MilliSec() function provides the same delays as without a patch file. If
you really need the MilliSec() function in your 5.01a or 5.2e program,
you should try testing __WAIT_4.OBJ instead of __WAIT_B.OBJ. The object
file can be extracted from the 5.3b patch by using the command  PATCH
53A_B /IGNOREMISSING  . This will create a subdirectory named \OBJ and
you'll find the object file in it.


HISTORY
-------
Several years ago, when the "fast" 486/66 CPU was released, this problem
started occurring among users of Nantucket Tools II. Someone on the
CompuServe ClipGer forum figured out the problem and released an object
file named __WAIT.OBJ. It worked perfectly.

When the same problem resurfaced with the AMD and Cyrix chips,
__WAIT.OBJ was tried and found to fix the problem when running in real
mode, but not protected mode. When this was discovered, a protected mode
version of __WAIT.OBJ was created by Ryszard Glab and posted on the
comp.lang.clipper newsgroup. To avoid confusion, it was renamed to
__WAIT_A.OBJ to distinguish it from the first version.

Subsequently it was found this protected mode __WAIT_A.OBJ module had
occasional GPF problems when used with specific nation module files and
the German language version. Malc Shedden of BlinkInc volunteered to
undertake the project to rewrite this module and the result is
__WAIT_B.OBJ, which is real, protected, and Blinker dual mode
compatible. Since it was released, it's been tested by dozens of persons
and it has fixed the problem 100% of the time, with only one
compatibility issue found (see above). However, keep in mind that it
certainly has not have been tested in all conceivable environments. If
you find a problem, please report it.

If it fixes your problem, please consider sending a thank you message to
support@blinkinc.com to let them know you appreciate the efforts and
work of their employee, Malc Shedden. Some years ago, Malc also donated
another work of his, EMM501.OBJ, to the Clipper community. It fixed a
major problem in Clipper 5.0x that was causing lockups when DOS 6 was
being used along with the NOEMS parameter to EMM386. If you were using
Clipper 5.0x when DOS 6 was released, you know how much anguish this
problem caused, and how EMM501.OBJ fixed it for free, courtesy of
BlinkInc.

Thanks,

Ray Pesek
support@scbatrak.com
