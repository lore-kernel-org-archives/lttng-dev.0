From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Fun with glibc
Date: Tue, 10 Mar 2015 15:06:08 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD706DB1AB__39551.9932303161$1426000069$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1YVLjb-00063L-PO
 for lttng-dev@lists.lttng.org; Tue, 10 Mar 2015 11:06:28 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

   Let's assume I'm trying to instrument glibc.  Making glibc is tricky by =
itself, but the following works under Ubuntu 14.04 and glibc 2.15 (obtained=
 from ftp.gnu.org/gnu/glibc/). I have deployed glibc-2.15.tar.gz to a local=
 ./glibc-2.15 folder and created a sibling ./glibc-build folder:

glibc-build$ ../glibc-2.15/configure CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -fno-s=
tack-protector" --prefix=3D/home/<user>/<path>/usr-local --with-pkgversion=
=3Duser-glibc &> configure.log
glibc-build$ make &> make.log

   Now I take a "simple" glibc service, such as printf (glibc-2.15/stdio-co=
mmon/printf.c), and try to instrument it.  I modify printf.c like this:

#include <libioP.h>
#include <stdarg.h>
#include <stdio.h>

//THREE NEW LINES
#define TRACEPOINT_DEFINE
#define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
#include "printf-tp.h"

#undef printf

/* Write formatted output to stdout from the format string FORMAT.  */
/* VARARGS1 */
int
__printf (const char *format, ...)
{
  va_list arg;
  int done;

//ONE NEW LINE
  tracepoint(libc_tracer, printf);
  va_start (arg, format);
  done =3D vfprintf (stdout, format, arg);
  va_end (arg);

  return done;
}

   The tracepoint is a simple one.

glibc-2.15/stdio-common/printf-tp.c :

#define TRACEPOINT_CREATE_PROBES
#include "printf-tp.h"

glibc-2.15/stdio-common/printf-tp.h :

<usual preface>
TRACEPOINT_EVENT(
	libc_tracer,
	printf,
	TP_ARGS(),
	TP_FIELDS()
)
TRACEPOINT_LOGLEVEL(
	libc_tracer,
	printf,
	TRACE_INFO)
<usual postface>

   This is then compiled manually in place:

glibc-2.15/stdio-common$ gcc -I. -fPIC -c -o libprintf-tp.o printf-tp.c
glibc-2.15/stdio-common$ gcc -shared -Wl,-soname,libprintf-tp.so.1 -Wl,-no-=
as-needed -o libprintf-tp.so.1.0 -L/usr/local/lib -llttng-ust libprintf-tp.o
glibc-2.15/stdio-common$ ln -sf libprintf-tp.so.1.0 libprintf-tp.so.1
glibc-2.15/stdio-common$ ln -sf libprintf-tp.so.1 libprintf-tp.so

   Pretty standard so far (using LTTng 2.3.0).

   The goal is to run apps from the instrumented glibc (libc.so.6) by LD_PR=
ELOADing it (or installing it as the standard glibc) that become LTTng-acti=
ve (provide user-space events) if the tracepoint provider shared object is =
also preloaded.  This is similar to the standard dynamically-loaded statica=
lly-unaware approach to app instrumentation, where the instrumented app run=
s fine without the tracepoint provider shared object, and becomes LTTng-act=
ive only if the latter is preloaded.

   The glibc make doesn't like this, however.  It fails with a bunch of und=
efined references to dlsym, dlopen, dlclose (in __tracepoint__init_urcu_sym=
, __tracepoints__init, __tracepoints__ptrs_init, __tracepoints__destroy, __=
tracepoints__ptrs_destroy) when it tries to use libc_pic.os in the final(?)=
 construction of libc.so.  (I can provide the make log, of course)

   Anybody else tried to do something like this?  What is the least intrusi=
ve way of getting an LTTng-instrumented libc.so to compile?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
 LinkedIn: <http://ca.linkedin.com/in/daniel-u-thibault/>
 Research Gate: <https://www.researchgate.net/profile/Daniel_Thibault/>
