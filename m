From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng-tools lttng-ctl.c lttng_channel_set_default_attr
 does not have per-UID as its default
Date: Mon, 12 Aug 2013 21:07:38 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26664237__40289.4477862448$1376341719$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V8zL1-0003UL-RE
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 17:07:45 -0400
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
Cc: "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

   Since the 8692d4e lttng-tools commit (12 July), the default configuratio=
n for user-space channels is per-UID (it would be nice if 'lttng enable-cha=
nnel --help' said so, by the way).  However, in lttng-tools\src\lib\lttng-c=
tl\lttng-ctl.c, one can still read:

void lttng_channel_set_default_attr(struct lttng_domain *domain,
		struct lttng_channel_attr *attr)
{
[...]
	switch (domain->type) {
	case LTTNG_DOMAIN_KERNEL:
	 	 [...]
		break;
	case LTTNG_DOMAIN_UST:
		switch (domain->buf_type) {
		case LTTNG_BUFFER_PER_UID:
			[...]
			break;
		case LTTNG_BUFFER_PER_PID:
		default:
			[...]
			break;
		}
	default:
		/* Default behavior: leave set to 0. */
		break;
	}
}

   Surely the LTTNG_BUFFER_PER_UID  and LTTNG_BUFFER_PER_PID case blocks sh=
ould be switched around?

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
