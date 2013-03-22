From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Updated easy-ust Makefile
Date: Fri, 22 Mar 2013 13:25:52 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD028E81__3609.33987326479$1363958869$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UJ1zg-0006o3-Jx
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 09:26:52 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

   In my previous note on this mailing list, forget the bit about LD_PRELOA=
D being beholden to the remaining library search.  I got fooled into thinki=
ng that for unrelated reasons.  Turns out LD_PRELOAD loads the so regardles=
s of the search's outcome: it's just added to the list of dependencies to l=
oad (traversal is breadth-first, it turns out), and its initializer called =
last.

   Here is a suggested updated lttng-ust/doc/examples/easy-ust/Makefile whi=
ch fixes a minor problem (missing LDFLAGS preventing make from succeeding o=
ut-of-the-box) and adds additional targets demonstrating other ways tracepo=
ints can be compiled into an application.  Please review this for any factu=
al errors.

- - - BEGIN - - -
# Copyright (C) 2011-2012  Matthew Khouzam <matthew.khouzam@ericsson.com> =

# Copyright (C) 2012  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
#
# THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
# OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
#
# Permission is hereby granted to use or copy this program for any
# purpose,  provided the above notices are retained on all copies.
# Permission to modify the code and to distribute modified code is
# granted, provided the above notices are retained, and a notice that
# the code was modified is included with the above copyright notice.
#
# This makefile is not using automake so that people can see how to make
# simply. It builds a sample program in any one of four (really three) ways:
#
# ("static", default) with a statically embedded tracepoint provider probe,
# through inclusion.
#
# ("staticlib") with a statically embedded tracepoint provider probe, throu=
gh
# a static library (libtp.a). The resulting samplestaticlib binary is ident=
ical
# to the samplestatic binary.
#
# ("dynamic", "dynamicfull") with a dynamically loaded shared library
# (libtp.so). The only difference between these two is that "dynamicfull" s=
ets
# the TRACEPOINT_PROBE_DYNAMIC_LINKAGE define in order to avoid needing to =
be
# linked statically with the shared library.
#
# Currently, an instrumented application that would use a dynamically linked
# (as opposed to dynamically loaded) tracepoint provider shared library wou=
ld
# still dynamically load it (using the dlopen() system call), so the differ=
ence
# is pointless.
#
# The dynamic samples must use LD_PRELOAD to run because the trace provider
# shared library (libtp.so) is not in the library search path; to obviate t=
his
# requirement, you can either install your trace provider shared library in
# the library search path (e.g. /usr/local/lib) or add a DT_RUNPATH tag to =
your
# sample so it looks in its own directory for missing libraries (look for t=
he
# commented-out "$(CC) ... -Wl,-rpath,\$ORIGIN,--enable-new-dtags" lines in
# the "dynamic" and "dynamicfull" targets). The latter option does have the
# disadvantage that the dynamic linker will look for all the required libra=
ries
# (libdl.so, libc.so, liblttng-ust.so, etc.) in sample's directory first.
#
# The "html" target helps for documentation (req. code2html).

AR =3D ar
CC =3D gcc
LIBS =3D -ldl -llttng-ust # On Linux
#LIBS =3D -lc -llttng-ust # On BSD
CFLAGS =3D -I.
LDFLAGS =3D -L/usr/local/lib
SOFLAGS =3D -fPIC
SOVERSION_MAJOR =3D 1
SOVERSION_MINOR =3D 0

# default make is "all"
all: static

static: sample.o tp.o
	$(CC) -o sample$@ $^ $(LDFLAGS) $(LIBS)
	@echo "   Use './sample$@' to run sample$@"

staticlib: sample.o libtp.a
	$(CC) -o sample$@ $^ $(LDFLAGS) $(LIBS) -L.
	@echo "   Use './sample$@' to run sample$@"

dynamic: sample.o libtp.so
#	$(CC) -o sample$@ $< $(LDFLAGS) $(LIBS) -L. -ltp \
#	   -Wl,-rpath,\$ORIGIN,--enable-new-dtags
	$(CC) -o sample$@ $< $(LDFLAGS) $(LIBS) -L. -ltp
	@echo "   Use 'LD_PRELOAD=3D./libtp.so ./sample$@' to run sample$@"

dynamicfull: sampledynamic.o libtp.so
#	$(CC) -o sample$@ $< $(LDFLAGS) $(LIBS) \
#	   -Wl,-rpath,\$ORIGIN,--enable-new-dtags
	$(CC) -o sample$@ $< $(LDFLAGS) $(LIBS)
	@echo "   Use 'LD_PRELOAD=3D./libtp.so ./sample$@' to run sample$@"

sample.o: sample.c sample_component_provider.h
	$(CC) $(CFLAGS) -c -o $@ $<

sampledynamic.o: sample.c sample_component_provider.h
	$(CC) $(CFLAGS) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE -c -o $@ $<

libtp.a: tp.o
	$(AR) -cq $@ $<

libtp.so: libtp.o
	$(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -o \
	   $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBS) $<
	ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)
	ln -sf $@.$(SOVERSION_MAJOR) $@

libtp.o: tp.c sample_component_provider.h
	$(CC) $(CFLAGS) $(SOFLAGS) -c -o $@ $<

tp.o: tp.c sample_component_provider.h
	$(CC) $(CFLAGS) -c -o $@ $<

html: sample_component_provider.html sample.html tp.html

%.html: %.c =

	code2html -lc $< $@

%.html : %.h
	code2html -lc $< $@

.PHONY: clean
clean:
	rm -f *.html
	rm -f *.o *.a *.so *.so.*
	rm -f samplestatic* sampledynamic*
- - - END - - -

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
