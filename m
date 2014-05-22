From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools] Documentation: document
 tracefile max size discarded event limitation
Date: Thu, 22 May 2014 13:01:20 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359ADD47__16546.6593033218$1400763732$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WnScg-0001bx-5e
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 09:01:28 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Wed, 21 May 2014 12:10:24 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: David Goulet <dgoulet@efficios.com>

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index 55fbae6..4a1de2c 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -136,6 +136,8 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "  -C, --tracefile-size SIZE\n");
 	fprintf(ofp, "                           Maximum size of each tracefile w=
ithin a stream (in bytes). 0 means unlimited.\n");
 	fprintf(ofp, "                               (default: %u)\n", DEFAULT_CH=
ANNEL_TRACEFILE_SIZE);
+	fprintf(ofp, "                           Note: traces generated with this=
 option may inaccurately report\n");
+	fprintf(ofp, "                           discarded events as per CTF 1.8.=
\n");
 	fprintf(ofp, "  -W, --tracefile-count COUNT\n");
 	fprintf(ofp, "                           Used in conjunction with -C opti=
on, this will limit the number\n");
 	fprintf(ofp, "                           of files created to the specifie=
d count. 0 means unlimited.\n");
----------------------------------------------------------------------

   "as per CTF 1.8" leaves the impression that the misreporting is "mandate=
d".  I suspect this is not what is meant here.  Maybe "as of" instead of "a=
s per"?

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
