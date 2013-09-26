From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 18:13:10 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2679396E__44542.9129330025$1380219254$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793929@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<52445DDD.9050808@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VPG3r-00016B-CY
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 14:13:17 -0400
In-Reply-To: <52445DDD.9050808@efficios.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: Julien Desfossez [mailto:jdesfossez@efficios.com] =

Envoy=E9=A0: 26 septembre 2013 12:16

> When the consumer needs to read a subbuffer, it performs a get_subbuf ope=
ration. If this operation succeeds, =

> the consumer has exclusive access to this subbuffer and so it can read it=
 safely. If it fails, it means the tracer is =

> currently using it and in the case of snapshots, the consumer will just s=
kip to the next one (up to the end =

> position it defined at the beginning of the snapshot).
> So if there are gaps for a stream in the recorded snapshot, their size wi=
ll be a multiple of the subbuffer size.
>
> Julien

   Ah, so it occurs at the sub-buffer level.  Simple and efficient.

   Is the following scenario possible?  The consumer tries to get_subbuf, a=
nd is denied access (because tracers are writing into it).  It then tries t=
o get the next sub-buffer, but the luck of task scheduling is such that by =
the time it actually calls the request routine, the tracers have already ov=
erwritten the sub-buffer in question and gone on to the next one.  The get_=
subbuf succeeds and the consumer keeps doing its thing (the timestamps rema=
in monotonically increasing, so there is no corruption).  The resulting sna=
pshot on disk has a large jump in its timestamps, having lost a whole buffe=
r cycle's worth of event records.

   To complicate things, the tracers then stop (for lack of event occurrenc=
es) in some sub-buffer ahead of the consumer's current position, but still =
short of the consumer's stop goal.  When the consumer skips over the busy s=
ub-buffer (where the tracers are "stuck"), it would read events that appare=
ntly jump back in time (a whole buffer cycle's worth of time), so I guess i=
t would stop there and close the snapshot?

   On a somewhat related topic, how does the session daemon handle the cont=
ext added to a channel?  Is it a set of instructions (flags, really) sent t=
o the tracer, similar to filter pseudo-code (but much less complicated)?

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
