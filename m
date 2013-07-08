From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Is lttng namespace-ready?
Date: Mon, 8 Jul 2013 12:33:41 -0400
Message-ID: <20130708163340.GS29362__32585.414828691$1373301254$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD13143A3C@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwENi-0006bm-Kv
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 12:33:42 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD13143A3C@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    I was reading Michael Kerrisk's "Namespaces in operation"
>    (http://lwn.net/Articles/531114/), which explains most of the
>    namespace functionalities, and this brings to mind a number of
>    questions.
> =

>    Are trace paths namespace-ready?  Per-PID traces are apparently not
>    much at risk since a process can join a PID namespace only upon its
>    creation (that is to say, PIDs are immutable).  However, collisions
>    are still possible, such as if two user-space processes start
>    within the same one-second window in two sibling PID namespaces
>    such that they have the same virtual PID.

yes, this is a possible race indeed for per-PID tracing in UST, since I
think we're using namespaced PIDs to identify programs.

> =

>    But what of per-UID traces?  What happens to a trace in progress if
>    one or more processes switch user namespaces?

nothing.

>  Presumably new
>    sub-directories would be created under "session-name/ust/uid/"?

no.

>    What about the case where two processes run by two different users
>    (and thus being recorded under different uid subdirectories) switch
>    to private user namespaces which happen to both map to the same
>    numerical virtual uid?  We need to make sure the second process
>    switch does not overwrite the trace files of the first (recall that
>    per-uid trace paths do not include timestamps like per-pid trace
>    paths do).

Disambiguation between different PIDs requires the vpid context if you
use per-UID buffers.

> =

>    Finally, in the case of a remote trace being received by the relay
>    daemon, could a network or UTS namespace switch of the traced
>    processes cause trouble?  I suspect not, since the daemons at
>    either end of the connection are lttng-owned and would presumably
>    not undergo namespace switches themselves.

I don't see it causing an issue. It might be good to try it out though.

Thanks,

Mathieu

> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0| Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
