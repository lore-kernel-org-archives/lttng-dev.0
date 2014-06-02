From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: lttng-ust under the hood
Date: Mon, 02 Jun 2014 18:21:31 +0200
Message-ID: <538CA48B.9010306__17917.7986611196$1401726214$gmane$org@keymile.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <537F72B9.9030904@keymile.com>	
 <48CF5AC71E61DB46B70D0F388054EFFD359AE58F@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <538C95B0.3050208@keymile.com>
 <48CF5AC71E61DB46B70D0F388054EFFD359AF293@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02308459c1=gerlando.falauto@keymile.com>)
 id 1WrUzV-0000Ir-Pu
 for lttng-dev@lists.lttng.org; Mon, 02 Jun 2014 12:21:48 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359AF293@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

On 06/02/2014 05:39 PM, Thibault, Daniel wrote:
> -----Message d'origine-----
> De : Gerlando Falauto [mailto:gerlando.falauto@keymile.com]
> Envoy=E9 : 2 juin 2014 11:18
>
>> Thank you very much for your examples and explanations.
>> I'm slowly starting to understand.
>> I believe with optional linking (whereas your *USERS* need to #define bo=
th TRACEPOINT_DEFINE and TRACEPOINT_PROBE_DYNAMIC_LINKAGE), even the depend=
ency to liblttng-ust.so and (consequently) liblttng-ust-tracepoint.so is dr=
opped.
>> This means you only need to add -ldl to your application's LDFLAGS, and =
the two binaries liblttng-ust.so and liblttng-ust-tracepoint.so need not be=
 copied to the target's rootfs.
>> Is that right?
>
>     Yes, in the sense that libtp.so need not be present on the 'target ro=
otfs' for the instrumented application to run.  But if you want the instrum=
ented application to be traced, libtp.so must be present on the target file=
 system (so the application can find it).

In this case (optional linking), the application won't even look for it =

-- you need to manually feed it through LD_PRELOAD libtp.so, right?

>> However, I get the impression that such a feature is not available for
>> tracef() (meaning, if you're using tracef(), there's no way you can opti=
onally link to it -- the above shared objects need to be present on the tar=
get's filesystem).
>> Is my understanding right? If so, is there are reason for it?
>
>     I can't speak about tracef(): this is a more recent feature whereas I=
 feature-froze LTTng at 2.3.0-1 in order to complete the documentation proj=
ect.  I will be moving on to 2.4 and 2.5 in the near future, but for now so=
meone else will have to act as tracef()'s advocate.  I would presume it wor=
ks the same way as tracepoint(), in the sense that the instrumented applica=
tion remains runnable even when the tracepoint provider shared object can't=
 eb found.

Almost. I believe there's still some hard depedency on =

_lttng_ust_tracef(), which is defined within tracef.c and therefore ends =

up within liblttng-ust.so.

However, moving its definition (as static inline) to tracef.h seems to =

do the trick.
This way (i.e. defining TRACEPOINT_DEFINE and =

TRACEPOINT_PROBE_DYNAMIC_LINKAGE within my application) I end up with an =

application which
a) does nothing when called normally
b) correctly creates tracef() events when invoked with =

LD_PRELOAD=3Dliblttng-ust.so

I believe, that's reasonable behavior, isn't it?

>
>> What I'm looking for is some way to instrument the code without touching=
 the target filesystem unless needed.
>>
>> I believe this is probably against the whole idea of tracing (where you =
want tracing to ALWAYS be available, given its negligible overhead, as per =
Murphy's Law the moment it'll prove most valuable is when you least expect =
it to), still...
>
>     Modifying the target file system is unavoidable, I'd think.  The appl=
ications need to be instrumented (that's one modification), and there must =
be support for tracing on the target: the session daemon and consumer daemo=
n must be installed (you can omit installing the LTTng kernel modules if yo=
u only need to trace user-space) and run, and the instrumented applications=
' tracepoint provider must be present, either in the apps themselves (stati=
c linking) or as a shared object.  You can at least avoid storing the trace=
 itself on the target file system, by exporting the trace data over the wir=
e.

Yes, of course you need to have those libraries if you want to enable =

tracing. It'd also be nice, if you don't need tracing (for whatever =

reason) to be able to omit them, while keeping your application's binary =

identical.
I assume the only conceivable reason would be to save some (though =

negligible) footprint on the target filesystem. I also understand that =

once the application is instrumented, unless the event is enabled, the =

execution overhead per tracepoint is the exactly same (i.e. a missed =

branch), regardless of whether the tracepoint provider library is loaded =

or not.
In other words, using optional (dynamic) linking won't make your =

application run any faster. It will only save you a few Kbytes footprint =

on your target (liblttng-ust.so, liblttng-ust-tracepoint.so, =

libmytracepoint.so). Right?

Thanks *A LOT* once again!
Gerlando

>
>> Thanks a lot!
>> Gerlando
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
