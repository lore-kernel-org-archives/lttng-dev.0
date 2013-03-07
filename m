From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: babeltrace and strictly sorting events
Date: Thu, 7 Mar 2013 16:25:08 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD026371__33765.9943885685$1362673603$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UDddd-0004BK-Qj
	for lttng-dev@lists.lttng.org; Thu, 07 Mar 2013 11:25:49 -0500
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
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

   Babeltrace sorts the events submitted to it from a variety of source fil=
es (multiple traces, each potentially with multiple domains, each potential=
ly with multiple sources (for UST anyway), each potentially with multiple c=
hannels, each potentially with multiple CPU IDs) based on timestamps (babel=
trace/lib/iterator.c's stream_compare).  This works fine, but what about th=
e case where two events have strictly the same timestamp?  Within a single =
host, this can only happen if they have different CPU IDs.  It can also hap=
pen when merging traces from different hosts.  As it currently stands, stre=
am_compare looks at the timestamps only, so the ordering in the aforementio=
ned cases is undefined (left to the luck of the heap sort).

   I think stream_compare needs to also check for (s_a->parent.real_timesta=
mp =3D=3D s_b->parent.real_timestamp) and, in that case only, compare hosts=
 (alphabetical ordering is as good as any), then CPU IDs (numerical orderin=
g).  Obviously, this is a potentially expensive change since this function =
is called awfully often when babeltracing or lttngtopping large traces, so =
maybe the extra tests could be controlled by a command option (called --str=
ict-ordering, say).

   Or is this so rare it's not worth bothering with?  In which case a small=
 cautionary note in babeltrace's man pages would be enough (those man pages=
 really ought to state that babeltrace's output is time-ordered; right now =
they don't mention this at all).

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
