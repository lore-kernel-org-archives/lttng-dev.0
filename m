From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: babeltrace and strictly sorting events
Date: Tue, 7 May 2013 11:29:31 -0400
Message-ID: <20130507152931.GB6601__42982.5469306254$1367940605$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD026371@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZjpc-0002wF-Rf
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 11:29:32 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD026371@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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
>    Babeltrace sorts the events submitted to it from a variety of
>    source files (multiple traces, each potentially with multiple
>    domains, each potentially with multiple sources (for UST anyway),
>    each potentially with multiple channels, each potentially with
>    multiple CPU IDs) based on timestamps (babeltrace/lib/iterator.c's
>    stream_compare).  This works fine, but what about the case where
>    two events have strictly the same timestamp?  Within a single host,
>    this can only happen if they have different CPU IDs.  It can also
>    happen when merging traces from different hosts.  As it currently
>    stands, stream_compare looks at the timestamps only, so the
>    ordering in the aforementioned cases is undefined (left to the luck
>    of the heap sort).

makes sense.

> =

>    I think stream_compare needs to also check for
>    (s_a->parent.real_timestamp =3D=3D s_b->parent.real_timestamp) and, in
>    that case only, compare hosts (alphabetical ordering is as good as
>    any), then CPU IDs (numerical ordering).  Obviously, this is a
>    potentially expensive change since this function is called awfully
>    often when babeltracing or lttngtopping large traces, so maybe the
>    extra tests could be controlled by a command option (called
>    --strict-ordering, say).

These extra checks would only be needed with timestamps are equal (which
is rare). So no perceivable performance impact should be measurable.

> =

>    Or is this so rare it's not worth bothering with?  In which case a
>    small cautionary note in babeltrace's man pages would be enough
>    (those man pages really ought to state that babeltrace's output is
>    time-ordered; right now they don't mention this at all).

It's kind of rare, but could be worthwhile to add. Please open a feature
request on the bug tracker against babeltrace.

Thanks,

Mathieu

> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0/ Government of Canada
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
