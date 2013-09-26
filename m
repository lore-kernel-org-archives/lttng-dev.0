From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 15:57:18 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26793929__16726.6920711429$1380211096$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VPDwN-0002Sn-Oh
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 11:57:25 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Date: Thu, 26 Sep 2013 11:18:19 -0400
From: Julien Desfossez <jdesfossez@efficios.com>

> When we issue the "snapshot record" command, the consumer takes the curre=
nt reading and writing positions in the ring-buffer, =

> and will only try to consume the data between these boundaries. It will s=
tart at the reading position and consume subbuffer by =

> subbuffer up to the writing position. Unlike in a normal tracing session,=
 the reading position is not pushed by the consumer, it is =

> pushed by the tracer, it corresponds to the last subbuffer not yet reused=
 (or 0 before the first ring-buffer wrap-up).
> If the tracer is quickly filling up subbuffers and we don't have enough s=
ubbuffers (or they are too small) to give us enough time =

> to extract them, they will be overridden (default mode in snapshot mode) =
and we will skip these subbuffers.
> So there is no race between the consumer and tracer, we rely on the absol=
ute position (free-running counter) and we detect =

> and skip if a subbuffer has been reused.

   Thanks for these clarifications.  It's quite clear that, unless the trac=
er is quiescent, a snapshot can never be as large as the sum of =

the sub-buffers.

   One last point, then: let's suppose the consumer is busy reading records=
 from a certain sub-buffer when the tracer catches up to =

it and grabs the same sub-buffer.  I suppose the consumer is overrun roughs=
hod?  Does this happen at the sub-buffer level or =

when the tracer's position within the sub-buffer catches up to the reader's=
?  The consumer's read operation is interrupted and =

fails (or does the current read conclude, then the next read request fails?=
), so it tries to skip ahead to the next sub-buffer.  The =

consumer then keeps skipping until its read position passes the tracer's wr=
ite position (or it reaches the last "scheduled" =

sub-buffer).  So the snapshot ends up having a series of gaps near its end =
(assuming the consumer gets to read a few records =

from each sub-buffer before the tracer kicks it ahead).  Right?

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
