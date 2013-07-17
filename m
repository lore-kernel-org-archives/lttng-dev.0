From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng-tools: trace-kernel.c stutters?
Date: Wed, 17 Jul 2013 17:34:20 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1BE22E73__1299.16677619821$1374082532$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UzVcO-0001Hd-Jr
	for lttng-dev@lists.lttng.org; Wed, 17 Jul 2013 13:34:30 -0400
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

lttng-tools-2.2.0\src\bin\lttng-sessiond\trace-kernel.c, lines 190-198:

	case LTTNG_EVENT_FUNCTION:
		attr->instrumentation =3D LTTNG_KERNEL_KRETPROBE;
		attr->u.kretprobe.addr =3D ev->attr.probe.addr;
		attr->u.kretprobe.offset =3D ev->attr.probe.offset;
		attr->u.kretprobe.offset =3D ev->attr.probe.offset;
		strncpy(attr->u.kretprobe.symbol_name,
				ev->attr.probe.symbol_name, LTTNG_KERNEL_SYM_NAME_LEN);
		attr->u.kretprobe.symbol_name[LTTNG_KERNEL_SYM_NAME_LEN - 1] =3D '\0';
		break;

   Line 194 just repeats line 193.

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
