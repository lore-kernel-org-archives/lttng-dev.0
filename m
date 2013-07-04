From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: LTTNG_ENABLE_EVENT lsm cmd type?
Date: Thu, 4 Jul 2013 17:05:46 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD134228BF__29964.8462133066$1372957583$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UumyZ-0003ZJ-K6
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 13:05:47 -0400
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

-----Message d'origine-----
Date: Thu, 4 Jul 2013 16:27:25 +0000
From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>

   [...] what strikes me as odd is the lsm cmd type value: it is LTTNG_ENAB=
LE_EVENT (6) in both cases.  Shouldn't it rather be LTTNG_ENABLE_ALL_EVENT =
(7)?  This lsm cmd type assignation occurs in only one place, lttng-tools/s=
rc/lib/lttng-ctl/lttng-ctl.c:685:

	if (ev->name[0] !=3D '\0') {
		lsm.cmd_type =3D LTTNG_ENABLE_EVENT;
	} else {
		lsm.cmd_type =3D LTTNG_ENABLE_ALL_EVENT;
	}

   Since the command was 'lttng enable-event -a -u', one would expect ev->n=
ame[0] to indeed be '\0', so what's going on?
-----Fin du message d'origine-----

   I added a DBG statement and promptly found out that lttng-ctl.c's test s=
hould be:

	if (ev->name[0] !=3D '*') {

   Because lttng_enable_event receives ev->name =3D=3D "*" , not "".

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
