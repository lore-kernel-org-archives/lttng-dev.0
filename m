From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-ust under the hood
Date: Mon, 2 Jun 2014 16:51:34 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359AF2FE__14216.7454622269$1401727962$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <537F72B9.9030904@keymile.com>
 <48CF5AC71E61DB46B70D0F388054EFFD359AE58F@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <538C95B0.3050208@keymile.com>
 <48CF5AC71E61DB46B70D0F388054EFFD359AF293@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <538CA48B.9010306@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WrVSX-0000Us-9d
 for lttng-dev@lists.lttng.org; Mon, 02 Jun 2014 12:51:46 -0400
In-Reply-To: <538CA48B.9010306@keymile.com>
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

-----Message d'origine-----
De=A0: Gerlando Falauto [mailto:gerlando.falauto@keymile.com] =

Envoy=E9=A0: 2 juin 2014 12:22

>>     Yes, in the sense that libtp.so need not be present on the 'target r=
ootfs' for the instrumented application to run.  But if you want the instru=
mented application to be traced, libtp.so must be present on the target fil=
e system (so the application can find it).
>
>In this case (optional linking), the application won't even look for it
>-- you need to manually feed it through LD_PRELOAD libtp.so, right?

   Not quite.  In both dynamic linking cases (with and without static aware=
ness), the tracepoint provider is sought.  In the static awareness case, it=
 is the Linux dynamic linker (ld) that does the searching and which emits t=
he 'error while loading shared libraries [...] No such file or directory' e=
rror message.  In the non-static awareness (static unawareness?) case, it i=
s the application's initializer which tries to dlopen() the shared object. =
 The difference here is that the initializer fails quietly, flagging the tr=
acepoints as inert.  This happens just once per shared object which the app=
 refers to.

> Almost. I believe there's still some hard dependency on _lttng_ust_tracef=
(), which is defined within tracef.c and therefore ends up within liblttng-=
ust.so.
>
> However, moving its definition (as static inline) to tracef.h seems to do=
 the trick.
> This way (i.e. defining TRACEPOINT_DEFINE and TRACEPOINT_PROBE_DYNAMIC_LI=
NKAGE within my application) I end up with an application which
> a) does nothing when called normally
> b) correctly creates tracef() events when invoked with LD_PRELOAD=3Dliblt=
tng-ust.so
>
> I believe, that's reasonable behavior, isn't it?

   Indeed, that's what I would expect the behaviour to be.

> Yes, of course you need to have those libraries if you want to enable tra=
cing. It'd also be nice, if you don't need tracing (for whatever
> reason) to be able to omit them, while keeping your application's binary =
identical.
> I assume the only conceivable reason would be to save some (though
> negligible) footprint on the target filesystem. I also understand that on=
ce the application is instrumented, unless the event is enabled, the execut=
ion overhead per tracepoint is
> exactly the same (i.e. a missed branch), regardless of whether the tracep=
oint provider library is loaded or not.
> In other words, using optional (dynamic) linking won't make your applicat=
ion run any faster. It will only save you a few Kbytes footprint on your ta=
rget (liblttng-ust.so, liblttng-ust-tracepoint.so, libmytracepoint.so). Rig=
ht?

   Right!

   Instrumented applications will run very slightly faster when tracing is =
wholly turned off, simply because the session daemon isn't "stealing" the o=
dd CPU cycle now and then.  I would expect this to be very, very small diff=
erence.

> Thanks *A LOT* once again!
> Gerlando

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
