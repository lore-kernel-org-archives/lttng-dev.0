From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 11:18:19 -0400
Message-ID: <5244503B.9040605__27415.0457270027$1380208767$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679374E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VPDKn-0000S0-5I
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 11:18:35 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2679374E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

Hello,

On 13-09-25 05:18 PM, Thibault, Daniel wrote:
>    How does the 'lttng snapshot record' command affect a running (active)=
 trace?  I presume very little, only to the extent that the consumer daemon=
 servicing the request "steals" CPU cycles from the session daemon busily s=
hoving records into the buffer.
Correct, but it is not the session daemon that is responsible for
writing records into the buffers, it is the tracer (either in the
application or in the kernel).

>    Say we have a trace running in flight recorder mode and a heavy flow o=
f events into its buffers.  When the 'lttng snapshot record' command is iss=
ued, a consumer starts at the earliest (oldest) sub-buffer and starts dumpi=
ng the records to a trace directory.  As its "cursor" advances around the r=
ing of buffers, tracing continues.  By the time it wraps around the ring, t=
he tracer may very well have re-used a number of sub-buffers, so the consum=
er keeps going, trying to catch up.  Am I right in supposing that if the re=
ading and writing speeds are well matched, this could theoretically go on n=
early forever, generating a huge trace?  (That's what the snapshot --max-si=
ze option is for, along with the enable-channel --tracefile-size and --trac=
efile-count options)
When we issue the "snapshot record" command, the consumer takes the
current reading and writing positions in the ring-buffer, and will only
try to consume the data between these boundaries.
It will start at the reading position and consume subbuffer by subbuffer
up to the writing position. Unlike in a normal tracing session, the
reading position is not pushed by the consumer, it is pushed by the
tracer, it corresponds to the last subbuffer not yet reused (or 0 before
the first ring-buffer wrap-up).
If the tracer is quickly filling up subbuffers and we don't have enough
subbuffers (or they are too small) to give us enough time to extract
them, they will be overridden (default mode in snapshot mode) and we
will skip these subbuffers.
So there is no race between the consumer and tracer, we rely on the
absolute position (free-running counter) and we detect and skip if a
subbuffer has been reused.

The --max-size option allows to limit the size of the snapshot if the
"gap" between the reading and writing position is too big.

I hope it clarifies the situation,

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
