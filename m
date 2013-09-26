From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 12:16:29 -0400
Message-ID: <52445DDD.9050808__844.020027625625$1380212252$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793929@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VPEF3-0003Ug-N4
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 12:16:43 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26793929@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

[...]

>    Thanks for these clarifications.  It's quite clear that, unless the tr=
acer is quiescent, a snapshot can never be as large as the sum of =

> the sub-buffers.
Absolutely.

>    One last point, then: let's suppose the consumer is busy reading recor=
ds from a certain sub-buffer when the tracer catches up to =

> it and grabs the same sub-buffer.  I suppose the consumer is overrun roug=
hshod?  Does this happen at the sub-buffer level or =

> when the tracer's position within the sub-buffer catches up to the reader=
's?  The consumer's read operation is interrupted and =

> fails (or does the current read conclude, then the next read request fail=
s?), so it tries to skip ahead to the next sub-buffer.  The =

> consumer then keeps skipping until its read position passes the tracer's =
write position (or it reaches the last "scheduled" =

> sub-buffer).  So the snapshot ends up having a series of gaps near its en=
d (assuming the consumer gets to read a few records =

> from each sub-buffer before the tracer kicks it ahead).  Right?
When the consumer needs to read a subbuffer, it performs a get_subbuf
operation. If this operation succeeds, the consumer has exclusive access
to this subbuffer and so it can read it safely. If it fails, it means
the tracer is currently using it and in the case of snapshots, the
consumer will just skip to the next one (up to the end position it
defined at the beginning of the snapshot).
So if there are gaps for a stream in the recorded snapshot, their size
will be a multiple of the subbuffer size.

Thanks,

Julien

> =

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
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
