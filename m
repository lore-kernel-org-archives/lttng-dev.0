From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-ust under the hood
Date: Mon, 2 Jun 2014 15:39:18 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359AF293__23466.139220591$1401723622$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <537F72B9.9030904@keymile.com>
 <48CF5AC71E61DB46B70D0F388054EFFD359AE58F@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <538C95B0.3050208@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WrUKb-0008R9-QI
 for lttng-dev@lists.lttng.org; Mon, 02 Jun 2014 11:39:31 -0400
In-Reply-To: <538C95B0.3050208@keymile.com>
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

Envoy=E9=A0: 2 juin 2014 11:18

> Thank you very much for your examples and explanations.
> I'm slowly starting to understand.
> I believe with optional linking (whereas your *USERS* need to #define bot=
h TRACEPOINT_DEFINE and TRACEPOINT_PROBE_DYNAMIC_LINKAGE), even the depende=
ncy to liblttng-ust.so and (consequently) liblttng-ust-tracepoint.so is dro=
pped.
> This means you only need to add -ldl to your application's LDFLAGS, and t=
he two binaries liblttng-ust.so and liblttng-ust-tracepoint.so need not be =
copied to the target's rootfs.
> Is that right?

   Yes, in the sense that libtp.so need not be present on the 'target rootf=
s' for the instrumented application to run.  But if you want the instrument=
ed application to be traced, libtp.so must be present on the target file sy=
stem (so the application can find it).

> However, I get the impression that such a feature is not available for
> tracef() (meaning, if you're using tracef(), there's no way you can optio=
nally link to it -- the above shared objects need to be present on the targ=
et's filesystem).
> Is my understanding right? If so, is there are reason for it?

   I can't speak about tracef(): this is a more recent feature whereas I fe=
ature-froze LTTng at 2.3.0-1 in order to complete the documentation project=
.  I will be moving on to 2.4 and 2.5 in the near future, but for now someo=
ne else will have to act as tracef()'s advocate.  I would presume it works =
the same way as tracepoint(), in the sense that the instrumented applicatio=
n remains runnable even when the tracepoint provider shared object can't eb=
 found.

> What I'm looking for is some way to instrument the code without touching =
the target filesystem unless needed.
>
> I believe this is probably against the whole idea of tracing (where you w=
ant tracing to ALWAYS be available, given its negligible overhead, as per M=
urphy's Law the moment it'll prove most valuable is when you least expect i=
t to), still...

   Modifying the target file system is unavoidable, I'd think.  The applica=
tions need to be instrumented (that's one modification), and there must be =
support for tracing on the target: the session daemon and consumer daemon m=
ust be installed (you can omit installing the LTTng kernel modules if you o=
nly need to trace user-space) and run, and the instrumented applications' t=
racepoint provider must be present, either in the apps themselves (static l=
inking) or as a shared object.  You can at least avoid storing the trace it=
self on the target file system, by exporting the trace data over the wire.

> Thanks a lot!
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
