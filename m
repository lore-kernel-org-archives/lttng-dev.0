From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Difference in metadata between per-PID and per-UID
	traces
Date: Tue, 10 Sep 2013 20:07:24 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2678ED56__28.2723260626838$1378843711$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VJUDc-0008Ak-Kw
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 16:07:30 -0400
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

   I notice that the metadata of per-PID user-space traces has three attrib=
utes which are dropped from the equivalent per-UID trace:

Per-PID trace:

env {
	hostname =3D "sds-dut-vb";
	domain =3D "ust";
	tracer_name =3D "lttng-ust";
	tracer_major =3D 2;
	tracer_minor =3D 3;
	tracer_patchlevel =3D 0;
	vpid =3D 7024;
	procname =3D "simple";
};

Per-UID trace:

env {
	hostname =3D "sds-dut-vb";
	domain =3D "ust";
	tracer_name =3D "lttng-ust";
	tracer_major =3D 2;
	tracer_minor =3D 3;
};

   The trace data are the same in this case (two trace sessions capturing t=
he same events in parallel), so this change in metadata only shows up in ba=
beltrace's output (when using '-f all -n all' for example).

   Is this intentional?  It does mean per-UID traces "anonymize" the event =
data slightly.  And why is "tracer_patchlevel" dropped alongside the proces=
s-related attributes?

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
