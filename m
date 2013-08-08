From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools] Fix:
 LTTNG_ERR_NEED_ROOT_SESSIOND error message
Date: Thu, 8 Aug 2013 15:15:35 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26661377__28165.2714279064$1375974994$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V7Rw8-0000w4-UU
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 11:15:42 -0400
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

------------------------------
Date: Wed,  7 Aug 2013 14:58:05 -0400
From: J?r?mie Galarneau 	<jeremie.galarneau@efficios.com>

A root session daemon _and_ "tracing" group user membership are required to=
 trace the kernel.

---
 src/common/error.c | 2 +-

-	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] =3D "Tracing the kernel req=
uires a root lttng-sessiond daemon or \"tracing\" group user membership",
+	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] =3D "Tracing the kernel req=
uires a root lttng-sessiond daemon and \"tracing\" group user membership",
-- =

------------------------------

   Unless there's been a change in the code, that is just not true.  You ca=
n trace the kernel just fine without 'tracing' group membership, as long as=
 you have sudo privileges (and can thus call 'sudo -H lttng').  The root da=
emon is necessary either way: the text should just read "Tracing the kernel=
 requires a root lttng-sessiond daemon".

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
