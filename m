From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: lttng-ust under the hood
Date: Mon, 02 Jun 2014 17:18:08 +0200
Message-ID: <538C95B0.3050208__49464.1735371717$1401722367$gmane$org@keymile.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <537F72B9.9030904@keymile.com>
 <48CF5AC71E61DB46B70D0F388054EFFD359AE58F@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02308459c1=gerlando.falauto@keymile.com>)
 id 1WrU0C-0008IG-Tg
 for lttng-dev@lists.lttng.org; Mon, 02 Jun 2014 11:18:27 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359AE58F@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

On 05/26/2014 04:59 PM, Thibault, Daniel wrote:
>   ----------------------------------------------------------------------
>>> Date: Thu, 22 May 2014 18:21:29 +0200
>>> From: Gerlando Falauto <gerlando.falauto@keymile.com>
>>>
>>>> I'm still struggling to figure out why, depending on how I compile
>>>> and link my application, I can get either custom tracepoint providers =
OR tracef() to work, but not both at the same time.
>>>>
>>>> Is there any documentation explaining how lttng-ust is roughly suppose=
d to work?
>>>> (i.e. linking trickeries, libraries needed in LD_PRELOAD,
>>>> _LGPL_SOURCE, tracepoints, probes and so on...)
>>>>
>>>> Gerlando
>>>
>>>      It's all a matter of choice.  Tracepoint providers can be in the a=
pp (statically linked in) or dynamically linked to it.  In the latter case,=
 the linking can be mandatory (so the app will fail to launch if it cannot =
find the tracepoint provider .so) or optional.  With optional linking, fail=
ure to find the .so means the app isn't traceable but otherwise runs normal=
ly.
>>
>> Could you elaborate more on this optional linking? Perhaps it's the kind=
 of problem I'm running into.

[...]

Thank you very much for your examples and explanations.
I'm slowly starting to understand.
I believe with optional linking (whereas your *USERS* need to #define =

both TRACEPOINT_DEFINE and TRACEPOINT_PROBE_DYNAMIC_LINKAGE), even the =

dependency to liblttng-ust.so and (consequently) =

liblttng-ust-tracepoint.so is dropped.
This means you only need to add -ldl to your application's LDFLAGS, and =

the two binaries liblttng-ust.so and liblttng-ust-tracepoint.so need not =

be copied to the target's rootfs.
Is that right?

However, I get the impression that such a feature is not available for =

tracef() (meaning, if you're using tracef(), there's no way you can =

optionally link to it -- the above shared objects need to be present on =

the target's filesystem).
Is my understanding right? If so, is there are reason for it?

What I'm looking for is some way to instrument the code without touching =

the target filesystem unless needed.

I believe this is probably against the whole idea of tracing (where you =

want tracing to ALWAYS be available, given its negligible overhead, as =

per Murphy's Law the moment it'll prove most valuable is when you least =

expect it to), still...

Thanks a lot!
Gerlando

>
> Assume tp.c to consist of just two lines:
>
> ----------------------------------------------------------------------
> #define TRACEPOINT_CREATE_PROBES
> #include "tp.h"
> ----------------------------------------------------------------------
>
> tp.h is the tracepoint provider header, pretty much boilerplate:
>
> ----------------------------------------------------------------------
> #undef TRACEPOINT_PROVIDER
> #define TRACEPOINT_PROVIDER sample_component
> #undef TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "./tp.h"
> #if !defined(_SAMPLE_COMPONENT_PROVIDER_H) || defined(TRACEPOINT_HEADER_M=
ULTI_READ)
> #define _SAMPLE_COMPONENT_PROVIDER_H
> #include <lttng/tracepoint.h>
> #ifdef __cplusplus
> extern "C" {
> #endif /* __cplusplus */
> TRACEPOINT_EVENT(
> ...
> )
> TRACEPOINT_LOGLEVEL(
> ...
> )
> #ifdef __cplusplus
> }
> #endif /* __cplusplus */
> #include <lttng/tracepoint-event.h>
> #endif /* _SAMPLE_COMPONENT_PROVIDER_H */
> ----------------------------------------------------------------------
>
>     Now for some Makefile fragments.
>
> ----------------------------------------------------------------------
> LIBDL =3D -ldl # On Linux
> #LIBDL =3D -lc # On BSD
> LIBUST =3D -llttng-ust
> LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)
> LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)
> SOFLAGS =3D -fPIC
> SOVERSION_MAJOR =3D 1
> SOVERSION_MINOR =3D 0
>
> libtp.so: libtp.o
> 	@echo "~~~~~~Packaging $@:"
> 	$(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed \
> 	   -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBUST) $<
> 	ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)
> 	ln -sf $@.$(SOVERSION_MAJOR) $@
>
> libtp.o: tp.c tp.h
> 	@echo "~~~~~~Compiling $@:"
> 	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS) -c -o $@ $<
> ----------------------------------------------------------------------
>
> The -as-needed linker flag means the libraries mentioned in the command l=
ine (LIBUST) generate a NEEDED tag in the executable only if actually satis=
fying an otherwise undefined symbol reference. If present, the resulting li=
brary won't NEED liblttng-ust, which breaks tracing.
>
> Here is how the tracepoint provider (libtp) can be dynamically included a=
s a dependency.  The sample application is statically aware of libtp and wo=
n't run without it (the inclusion of a libtp NEEDED tag requires "-no-as-ne=
eded -ltp").  Besides the recommended LD_PRELOAD technique, you could also =
use #LD_LIBRARY_PATH (which does not work in the 'dynamic' target case, bel=
ow).  Note that "-L. -ltp", when used, should appear before $(LDFLAGS) $(LI=
BDL).
>
> ----------------------------------------------------------------------
> TP_DEFINE =3D -D TRACEPOINT_DEFINE
>
> static.o: sample.c tp.h
> 	@echo "~~~~~~Compiling $@:"
> 	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $<
>
> static_aware: static.o libtp.so
> 	@echo "~~~~~~Linking sample_$@:"
> 	$(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS) $(LIBDL)
> 	@echo "   Use 'LD_PRELOAD=3D./libtp.so ./sample_$@' to run sample_$@"
> ----------------------------------------------------------------------
>
> static_aware could also be written with a "-Wl,-rpath,'$$ORIGIN'" linker =
call (see below).   This would add an RPATH tag to the application which ma=
kes it look for its dependencies in its starting directory ($ORIGIN). RPATH=
 is, unlike RUNPATH, applicable to libraries as well: a library with an RPA=
TH tag will look there for its dependencies; failing its own RPATH, it will=
 use its executable's RPATH.
>
> ----------------------------------------------------------------------
> static_aware: static.o libtp.so
> 	@echo "~~~~~~Linking sample_$@:"
> 	$(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS) $(LIBDL) \
> 	   -Wl,-rpath,'$$ORIGIN',--enable-new-dtags
> ----------------------------------------------------------------------
>
> Here is how the tracepoint provider (libtp) can be dynamically included w=
ithout static awareness.  If not preloaded, the sample application runs but=
 won't be traceable.  Putting libtp in the path won't work: the sample does=
 not look for it.  This is indifferent to the -[no-]as-needed linker flag.
>
> ----------------------------------------------------------------------
> TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE
>
> dynamic: dynamic.o libtp.so
> 	@echo "~~~~~~Linking sample_$@:"
> 	$(CC) -o sample_$@ $< $(LDFLAGS) $(LIBDL)
> 	@echo "   Use '[LD_PRELOAD=3D./libtp.so] ./sample_$@' to run sample_$@"
>
> dynamic.o: sample.c tp.h
> 	@echo "~~~~~~Compiling $@:"
> 	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE_DYNAMIC) \
> 	   -c -o $@ $<
> ----------------------------------------------------------------------
>
> Compared with the 'static.o' target, 'dynamic.o' only adds -D TRACEPOINT_=
PROBE_DYNAMIC_LINKAGE.
>
>>> LD_PRELOAD is generally used to provide the app with the tracepoint pro=
vider .so when tracing is desired.
>>>
>>>      Extensive documentation (in PDF) is currently undergoing editorial=
 review, and the plan is to move said documentation to DocBook format so it=
 can be included in the LTTng distribution.
>>
>> Would it be possible to have a copy of this doc?
>
>     I'll be sending this to you tonight from my home e-address (to avoid =
attachment interference from our e-mail server).
>
>>>     Since tracef() depends on liblttng-ust just like ordinary UST, I'm =
not sure which problem you're running into.  Could you give us a simplified=
 makefile that showcases the issue?
>>
>> main.c:
>> #include <lttng/tracef.h>
>>
>> int main() {
>>     tracef("Hello world");
>>     return 0;
>> }
>>
>> gcc main.c -lttlng-ust -ldl -I.
>>
>> There, I don't get my tracef().
>> This happens on top of an ELDK 5.4, on top of which I configured & compi=
led one of the latest releases of userspace-rc, lttng-ust, and lttng-tools.
>>
>> I tried either with native compiling on the target, or with cross-compil=
ing. Same result.
>>
>> Notice how I used the same configure/compile/install script to compile o=
n a pristine ch-rooted rootfs on the x86_64 host, and there everything work=
s fine.
>>
>> I suspect my ELDK (so my rootfs) has some spurious LTTNG files (or other=
 .so), since it already contains an older version of LTTNG, which confuse t=
he linker. I tried rm'ing the existing /usr/lib/{liblttng-*,liburcu*} prior=
 to configuring, but still no luck.
>>
>> Any clue?
>>
>> Gerlando
>
>     You should definitely not mix LTTng bits and pieces across different =
versions.  Have you tried creating a clean ELDK on which to install LTTng?
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
