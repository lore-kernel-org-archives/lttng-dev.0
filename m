From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Question about TRACEPOINT_EVENT_CLASS and
 TRACEPOINT_EVENT_INSTANCE
Date: Wed, 19 Nov 2014 18:14:26 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBC92BD__24724.255273077$1416420932$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Xr9lw-0001Dl-Qn
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 13:14:35 -0500
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

> Date: Wed, 19 Nov 2014 15:35:01 +0400
> From: Eugene Ivanov <eiva@tbricks.com>
>
> I found description of TRACEPOINT_EVENT_CLASS on the website and in ust-t=
racepoint-event.h as well, but it is not documented in the lttng-ust man pa=
ge.
> According the header TRACEPOINT_EVENT_INSTANCE declares an instance of a =
tracepoint, with its own provider and name.
> Does it mean that I can define classes for usage in different providers? =
Why do we need provider in _CLASS then?
> According the code on the first glance it seems that it is required that =
CLASS and INSTANCE must share in same provider.

   You will also have seen that the "default" macro TRACEPOINT_EVENT simply=
 wraps both TRACEPOINT_EVENT_CLASS and TRACEPOINT_EVENT_INSTANCE together. =
 When used separately, the TRACEPOINT_EVENT_INSTANCE must match its templat=
e's params; the event class then takes care of the mapping of parameters to=
 fields in the event output.  This allows you to declare a single event cla=
ss somewhere, then declare various instances that vary by name only, typica=
lly because they're events of the same nature but occurring in varying cont=
exts.  Having the trace label them under different names makes the analyst'=
s life easier.

   Normally you use TRACEPOINT_EVENT_CLASS and _INSTANCE within the same pr=
ovider, but you could theoretically have varying instances rely on differen=
t providers.  I guess this would allow you some flexibility in picking whic=
h sets of instances to enable/disable by picking which provider shared obje=
cts (.so) to preload or not.

   Kernel space has essentially the same macros under the names DECLARE_EVE=
NT_CLASS and TRACE_EVENT, respectively.  You can see those at work in the l=
ttng-modules package and in some kernel modules such as drivers/staging/and=
roid/binder_trace.h.  In the latter, for example, you see a binder_lock_cla=
ss which is then instantiated as binder_lock, binder_locked, and binder_unl=
ock.  These three events carry very different semantics, but they have prec=
isely the same parameter signatures.  Grouping them under an event class av=
oids a lot of cutting-and-pasting and diminishes the risk of errors later o=
n (e.g. if you had to modify the field layout of binder_lock and forgot to =
copy it to binder_unlock).

   "Why do we need provider in _CLASS then?"  Because the provider name is =
part of the fully-qualified event class name.  This allows different event =
classes (and event instances) to have the same short names within different=
 providers.  You would be bound to run into collisions if all the event cla=
ss or event instance names were global.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
