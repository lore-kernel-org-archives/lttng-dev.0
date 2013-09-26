From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng snapshots and running traces
Date: Thu, 26 Sep 2013 18:20:42 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26793984__32006.5223415897$1380219700$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VPGB9-0001WS-Lg
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 14:20:49 -0400
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

Date: Thu, 26 Sep 2013 12:16:29 -0400
From: Julien Desfossez <jdesfossez@efficios.com>

> When the consumer needs to read a subbuffer, it performs a get_subbuf ope=
ration. If this operation succeeds, =

> the consumer has exclusive access to this subbuffer and so it can read it=
 safely. If it fails, it means the tracer is =

> currently using it and in the case of snapshots, the consumer will just s=
kip to the next one (up to the end =

> position it defined at the beginning of the snapshot).
>
> Julien

   Presumably the tracers also use get_subbuf, so what happens if they are =
refused access because the consumer =

got the sub-buffer first?  Do they wait for the consumer to relinquish the =
sub-buffer, or do they skip ahead?

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
