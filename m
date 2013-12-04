From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: No trace files are generated
Date: Wed, 4 Dec 2013 14:34:28 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B28D8__27853.1284923249$1386167724$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VoDX3-0004ge-7l
	for lttng-dev@lists.lttng.org; Wed, 04 Dec 2013 09:34:34 -0500
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
Cc: Manikandan Govindaswamy <magov@vestas.com>
List-Id: lttng-dev@lists.lttng.org

> Date: Tue, 3 Dec 2013 11:01:05 -0500
>
> DEBUG1 [21408/21408]: Could not find any valid consumerd executable (in s=
pawn_consumerd() at main.c:2119)
> PERROR [21408/21408]: kernel start consumer exec: No such file or directo=
ry (in spawn_consumerd() at main.c:2224)
> Error: Condition timed out. The consumer thread was never ready. Killing =
it
>
> The session daemon can't find the consumer daemon executables. You will h=
ave to point the session daemon to them manually using the
> --consumerd32-path or --consumerd64-path options (depending on your archi=
tecture).

   The question then becomes why, when lttng-consumerd is missing, is the l=
ttng behaviour so different between kernel and user-space?  See bug #702 (h=
ttp://bugs.lttng.org/issues/702).

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
