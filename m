From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Toxic comments in lttng-sessiond main.c
Date: Mon, 17 Mar 2014 20:44:23 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD31A68016__41408.2828596749$1395089134$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WPeOb-0001is-MH
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 16:44:33 -0400
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

(for version 2.3)
/usr/src/lttng-tools/src/bin/lttng-sessiond/main.c (3613..3648):

static void *thread_manage_clients(void *data)
{
[...]
	DBG("[thread] Manage client started");
[...]
	ret =3D lttcomm_listen_unix_sock(client_sock);
[...]
	/* Add the application registration socket */
	ret =3D lttng_poll_add(&events, client_sock, LPOLLIN | LPOLLPRI);

   Shouldn't that last comment read "/* Add the client socket */"?

   A little later, lines 3700..3701:

			/* Event on the registration socket */
			if (pollfd =3D=3D client_sock) {

   Shouldn't that comment read "/* Event on the client socket */"?

   Similar copy-and-paste errors appear in one other thread routine: thread=
_manage_health (lines 3453 and 3489).  The others (including the two exiled=
 to ust-thread.c and ht-cleanup.c) appear OK.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
