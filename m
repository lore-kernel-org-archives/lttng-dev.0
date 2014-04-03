From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: instrumenting shared library
Date: Thu, 3 Apr 2014 16:05:17 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD35992F74__4995.06235723874$1396541189$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WVk8p-0001fO-Es
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 12:05:29 -0400
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
Cc: Anand Neeli <anand.neeli@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Thu, 3 Apr 2014 16:55:38 +0530
From: Anand Neeli <anand.neeli@gmail.com>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>

> I have a library which is instrumented and tracepoints are added. And I
> have 2 binary's (or daemons) which try to include this library. (one bina=
ry
> has instrumented code with tracepoints and other binary doesn't use
> tracing)
>
> I found that i need to instrument the daemon which includes the
> instrumented library for the code to compile.
>
> Can't I have a daemon (without tracing functionality) which can include an
> instrumented library (i don't want to use tracing functionality in this
> case)
>
> I'm only able to build if both library and daemon which includes it are
> instrumented.
>
> Can anyone please give me more details on how to do this?
> This is useful for huge code bases where you can selectively add tracing
> support to few libraries or daemons.
>
> Anand Neeli

   It can be done.  An uninstrumented app can rely on an instrumented share=
d object; whether the latter produces lttng events then depends on whether =
or not the tracepoint provider shared object is loaded when the app is invo=
ked (using LD_PRELOAD).

   Here is sample_neeli.c:
#####
#include <stdio.h> //For printf
#include <unistd.h>

#include "cobject.h"
int main(int argc, char **argv)
{
	int i =3D 0;
	char themessage[20]; //Can hold up to "Hello World 9999999\0"

	fprintf(stderr, "sample_neeli starting\n");
	for (i =3D 0; i < 10000; i++) {
		//We either prepare themessage in this module, or rely on an
		//external shared object
		cobject_message(themessage, i);
		usleep(1);
	}
	fprintf(stderr, "sample_neeli done\n");
	return 0;
}
#####
cobject.c:
#####
#include <stdio.h> //For printf
#include <unistd.h>

#include "tp.h"

void cobject_message(char *themessage, int i)
{
	tracepoint(sample_component, event, "cobject_message");
	sprintf(themessage, "CObject %u", i);
}
#####
cobject.h:
#####
extern void cobject_message(char *themessage, int i);
#####
The tracepoint provider code should be easy to guess.

The relevant Makefile fragments:
#####
CC =3D gcc
LIBDL =3D -ldl # On Linux
#LIBDL =3D -lc # On BSD
LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)
LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)
SOFLAGS =3D -fPIC
TP_DEFINE =3D -D TRACEPOINT_DEFINE
TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE
SOVERSION_MAJOR =3D 1
SOVERSION_MINOR =3D 0

libcobject.so: libcobject.o
	@echo "~~~~~~Packaging $@:"
	$(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed \
	   -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $^
	ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)
	ln -sf $@.$(SOVERSION_MAJOR) $@

libcobject.o: cobject.c cobject.h tp.h
	@echo "~~~~~~Compiling $@:"
	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS) $(TP_DEFINE_DYNAMIC) \
	   -c -o $@ $<

neeli_dynamic_lib:: neeli_dynamic_lib.o
	@echo "~~~~~~Linking sample_$@:"
	$(CC) -Wl,-no-as-needed -o $@ -L. -lcobject $^ $(LDFLAGS) \
	   $(LIBDL) -Wl,-rpath,'$$ORIGIN',--enable-new-dtags
	@echo "   Use '[LD_PRELOAD=3D./libtp.so] ./$@' to run $@"

neeli_dynamic_lib.o: sample_neeli.c cobject.h
	@echo "~~~~~~Compiling $@:"
	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) -c -o $@ $<
#####

   Running './neeli_dynamic_lib' yields no events.  Running 'LD_PRELOAD=3D.=
/libtp.so ./neeli_dynamic_lib' yields the libcobject.so events.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
