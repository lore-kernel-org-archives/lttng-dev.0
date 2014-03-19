From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [bug]session create failed
Date: Wed, 19 Mar 2014 18:00:13 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD31A683BD__3592.64065414227$1395252107$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WQKmp-0007My-NV
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 14:00:23 -0400
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

----------------------------------------------------------------------
Date: Tue, 18 Mar 2014 14:13:16 -0400
From: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To: Lingyu Zhu <lynuszhu@gmail.com>

> We have been thinking of implementing some kind of "lttng teardown"
> command to kill the session daemon from the lttng client... I don't know =
if there really is user demand for it though.

   Most users will set up lttng-sessiond as a service (that's how it's pack=
aged under Ubuntu).  You can then start, stop, or restart the session daemo=
n with 'sudo service lttng-sessiond <command>'.  No need for 'lttng teardow=
n'.  Adding the latter would be complicated because it would have to figure=
 if it's currently set up as a service and tell the service manager not to =
restart it if it happens to be in respawn mode.

----------------------------------------------------------------------
Date: Tue, 18 Mar 2014 21:08:24 +0000
From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>

> As late as lttng 2.3, the lttng -g option does not work.  Has it been fix=
ed?

   Never mind, we were talking about 'lttng-sessiond -g', which works.  ('l=
ttng -g' does not but is irrelevant here)

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
