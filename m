From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Yet another toxic comment
Date: Thu, 20 Mar 2014 15:56:19 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3598E9C9__28525.0069377527$1395331042$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WQfKZ-0001I5-QU
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 11:56:36 -0400
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

   lttng-tools/src/bin/lttng-sessiond/main.c, lines 163-169:

/*
 * UST registration command queue. This queue is tied with a futex and uses=
 a N
 * wakers / 1 waiter implemented and detailed in futex.c/.h
 *
 * The thread_manage_apps and thread_dispatch_ust_registration interact with
 * this queue and the wait/wake scheme.
 */

   The fifth line should actually read:

* The thread_registration_apps and thread_dispatch_ust_registration interac=
t with

   thread_manage_apps occurs further down the line: it watches the register=
ed apps' cmd sockets and triggers unregistration when they close.

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
