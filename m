From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-ust under the hood
Date: Mon, 26 May 2014 14:59:26 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359AE58F__32305.036384105$1401116427$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <537F72B9.9030904@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WowNA-00017l-Ft
 for lttng-dev@lists.lttng.org; Mon, 26 May 2014 10:59:36 -0400
In-Reply-To: <537F72B9.9030904@keymile.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

 ----------------------------------------------------------------------
>> Date: Thu, 22 May 2014 18:21:29 +0200
>> From: Gerlando Falauto <gerlando.falauto@keymile.com>
>>
>>> I'm still struggling to figure out why, depending on how I compile =

>>> and link my application, I can get either custom tracepoint providers O=
R tracef() to work, but not both at the same time.
>>>
>>> Is there any documentation explaining how lttng-ust is roughly supposed=
 to work?
>>> (i.e. linking trickeries, libraries needed in LD_PRELOAD, =

>>> _LGPL_SOURCE, tracepoints, probes and so on...)
>>>
>>> Gerlando
>>
>>     It's all a matter of choice.  Tracepoint providers can be in the app=
 (statically linked in) or dynamically linked to it.  In the latter case, t=
he linking can be mandatory (so the app will fail to launch if it cannot fi=
nd the tracepoint provider .so) or optional.  With optional linking, failur=
e to find the .so means the app isn't traceable but otherwise runs normally.
>
>Could you elaborate more on this optional linking? Perhaps it's the kind o=
f problem I'm running into.

Assume tp.c to consist of just two lines:

----------------------------------------------------------------------
#define TRACEPOINT_CREATE_PROBES
#include "tp.h"
----------------------------------------------------------------------

tp.h is the tracepoint provider header, pretty much boilerplate:

----------------------------------------------------------------------
#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER sample_component
#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./tp.h"
#if !defined(_SAMPLE_COMPONENT_PROVIDER_H) || defined(TRACEPOINT_HEADER_MUL=
TI_READ)
#define _SAMPLE_COMPONENT_PROVIDER_H
#include <lttng/tracepoint.h>
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */
TRACEPOINT_EVENT(
...
)
TRACEPOINT_LOGLEVEL(
...
)
#ifdef __cplusplus
}
#endif /* __cplusplus */
#include <lttng/tracepoint-event.h>
#endif /* _SAMPLE_COMPONENT_PROVIDER_H */
----------------------------------------------------------------------

   Now for some Makefile fragments.

----------------------------------------------------------------------
LIBDL =3D -ldl # On Linux
#LIBDL =3D -lc # On BSD
LIBUST =3D -llttng-ust
LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)
LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)
SOFLAGS =3D -fPIC
SOVERSION_MAJOR =3D 1
SOVERSION_MINOR =3D 0

libtp.so: libtp.o
	@echo "~~~~~~Packaging $@:"
	$(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed \
	   -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBUST) $<
	ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)
	ln -sf $@.$(SOVERSION_MAJOR) $@

libtp.o: tp.c tp.h
	@echo "~~~~~~Compiling $@:"
	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS) -c -o $@ $<
----------------------------------------------------------------------

The -as-needed linker flag means the libraries mentioned in the command lin=
e (LIBUST) generate a NEEDED tag in the executable only if actually satisfy=
ing an otherwise undefined symbol reference. If present, the resulting libr=
ary won't NEED liblttng-ust, which breaks tracing.

Here is how the tracepoint provider (libtp) can be dynamically included as =
a dependency.  The sample application is statically aware of libtp and won'=
t run without it (the inclusion of a libtp NEEDED tag requires "-no-as-need=
ed -ltp").  Besides the recommended LD_PRELOAD technique, you could also us=
e #LD_LIBRARY_PATH (which does not work in the 'dynamic' target case, below=
).  Note that "-L. -ltp", when used, should appear before $(LDFLAGS) $(LIBD=
L).

----------------------------------------------------------------------
TP_DEFINE =3D -D TRACEPOINT_DEFINE

static.o: sample.c tp.h
	@echo "~~~~~~Compiling $@:"
	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $<

static_aware: static.o libtp.so
	@echo "~~~~~~Linking sample_$@:"
	$(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS) $(LIBDL)
	@echo "   Use 'LD_PRELOAD=3D./libtp.so ./sample_$@' to run sample_$@"
----------------------------------------------------------------------

static_aware could also be written with a "-Wl,-rpath,'$$ORIGIN'" linker ca=
ll (see below).   This would add an RPATH tag to the application which make=
s it look for its dependencies in its starting directory ($ORIGIN). RPATH i=
s, unlike RUNPATH, applicable to libraries as well: a library with an RPATH=
 tag will look there for its dependencies; failing its own RPATH, it will u=
se its executable's RPATH.

----------------------------------------------------------------------
static_aware: static.o libtp.so
	@echo "~~~~~~Linking sample_$@:"
	$(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS) $(LIBDL) \
	   -Wl,-rpath,'$$ORIGIN',--enable-new-dtags
----------------------------------------------------------------------

Here is how the tracepoint provider (libtp) can be dynamically included wit=
hout static awareness.  If not preloaded, the sample application runs but w=
on't be traceable.  Putting libtp in the path won't work: the sample does n=
ot look for it.  This is indifferent to the -[no-]as-needed linker flag.

----------------------------------------------------------------------
TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE

dynamic: dynamic.o libtp.so
	@echo "~~~~~~Linking sample_$@:"
	$(CC) -o sample_$@ $< $(LDFLAGS) $(LIBDL)
	@echo "   Use '[LD_PRELOAD=3D./libtp.so] ./sample_$@' to run sample_$@"

dynamic.o: sample.c tp.h
	@echo "~~~~~~Compiling $@:"
	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE_DYNAMIC) \
	   -c -o $@ $<
----------------------------------------------------------------------

Compared with the 'static.o' target, 'dynamic.o' only adds -D TRACEPOINT_PR=
OBE_DYNAMIC_LINKAGE.

>> LD_PRELOAD is generally used to provide the app with the tracepoint prov=
ider .so when tracing is desired.
>>
>>     Extensive documentation (in PDF) is currently undergoing editorial r=
eview, and the plan is to move said documentation to DocBook format so it c=
an be included in the LTTng distribution.
>
>Would it be possible to have a copy of this doc?

   I'll be sending this to you tonight from my home e-address (to avoid att=
achment interference from our e-mail server).

>>    Since tracef() depends on liblttng-ust just like ordinary UST, I'm no=
t sure which problem you're running into.  Could you give us a simplified m=
akefile that showcases the issue?
>
>main.c:
>#include <lttng/tracef.h>
>
>int main() {
>    tracef("Hello world");
>    return 0;
>}
>
>gcc main.c -lttlng-ust -ldl -I.
>
>There, I don't get my tracef().
>This happens on top of an ELDK 5.4, on top of which I configured & compile=
d one of the latest releases of userspace-rc, lttng-ust, and lttng-tools.
>
>I tried either with native compiling on the target, or with cross-compilin=
g. Same result.
>
>Notice how I used the same configure/compile/install script to compile on =
a pristine ch-rooted rootfs on the x86_64 host, and there everything works =
fine.
>
>I suspect my ELDK (so my rootfs) has some spurious LTTNG files (or other .=
so), since it already contains an older version of LTTNG, which confuse the=
 linker. I tried rm'ing the existing /usr/lib/{liblttng-*,liburcu*} prior t=
o configuring, but still no luck.
>
>Any clue?
>
>Gerlando

   You should definitely not mix LTTng bits and pieces across different ver=
sions.  Have you tried creating a clean ELDK on which to install LTTng?

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
