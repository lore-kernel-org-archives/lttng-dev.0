From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Quick question about discarded events
Date: Tue, 5 Nov 2013 13:38:47 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A0FA7__30951.8935544931$1383658777$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VdgqH-0000vw-3n
	for lttng-dev@lists.lttng.org; Tue, 05 Nov 2013 08:38:52 -0500
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
Cc: "david.lindstrom@percepio.se" <david.lindstrom@percepio.se>
List-Id: lttng-dev@lists.lttng.org

------------------------------
Date: Mon, 4 Nov 2013 14:32:02 +0100
From: "=3D?iso-8859-1?Q?David_Lindstr=3DF6m?=3D"
	<david.lindstrom@percepio.se>

> If I encounter a trace where a packet contains the events_discarded field =

> with a non-zero value, I want to warn/notify the user. Were the events =

> discarded before the timestamp_begin of the packet, after timestamp_end o=
r =

> in between? I basically want to plot some symbol on my timeline =

> approximately where the user can expect bad/missing data.
>
> Mvh
> David Lindstr?m =


   I do believe the events were lost in between the begin and end packet ti=
mestamps.

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
