From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: src/bin/lttng/commands/snapshot.c
Date: Thu, 25 Jul 2013 21:39:34 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1BE243C0__31234.0679615319$1374788445$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V2TGG-0005vV-6O
	for lttng-dev@lists.lttng.org; Thu, 25 Jul 2013 17:39:52 -0400
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

   In LTTng 2.3's src/bin/lttng/commands/snapshot.c, we have:

static int add_output(const char *url)
{
	int ret;
	struct lttng_snapshot_output *output =3D NULL;

	if (!url && (!opt_data_url || !opt_ctrl_url)) {
		ret =3D CMD_ERROR;
		goto error;
	}
[...]
}

static int cmd_add_output(int argc, const char **argv)
{
	int ret =3D CMD_SUCCESS;

	if (argc < 2 && (!opt_data_url || !opt_ctrl_url)) {
		usage(stderr);
		ret =3D CMD_ERROR;
		goto end;
	}
	ret =3D add_output(argv[1]);
end:
	return ret;
}

add_output() is only called from cmd_add_output(), and the latter's argumen=
t validation (combined with the validation done by handle_command()) guaran=
tees that add_output()'s url is NULL only when opt_data_url and opt_ctrl_ur=
l are both non-NULL.  The initial validation add_output() conducts is thus =
unnecessary (that if will always fail).

Another potential problem is cmd_record():

static int cmd_record(int argc, const char **argv)
{
	int ret;

	if (argc =3D=3D 2) {
		/* With a given URL */
		ret =3D record(argv[1]);
	} else {
		ret =3D record(NULL);
	}
	return ret;
}

The if (argc =3D=3D 2) test is unfortunate, because it means 'lttng snapsho=
t record url1 url2' will result in record(NULL), an unexpected result from =
any user's point of view.  The test should be if (argc >=3D 2), which is wh=
at cmd_add_output and cmd_del_output both do.

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
