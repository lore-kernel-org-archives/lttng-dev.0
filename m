From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Dead code in lttng.c
Date: Fri, 31 May 2013 14:34:34 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D2247A__27782.3214688853$1370011004$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UiQQt-00070Y-0w
	for lttng-dev@lists.lttng.org; Fri, 31 May 2013 10:35:55 -0400
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

In lttng-tools/src/bin/lttng/lttng.c, the check_args_no_sessiond function c=
hecks the command-line arguments for "specific options and commands that mu=
st not trigger a session daemon". The function detects the options "-h", "-=
-h" (for "--help"), "--list-options", and "--list-commands", and the comman=
ds "version" and "view".

The parse_args function, on the other hand, detects "-V", "-h", "--list-com=
mands", "--list-options" at its outset and *does not* reach the session dae=
mon spawning check ( if (opt_no_sessiond =3D=3D 0 && check_args_no_sessiond=
(argc, argv) =3D=3D 0 && (check_sessiond() < 0)) ) in those cases.

So, why is check_args_no_sessiond checking for options at all?  Considering=
 the control flow of parse_args, check_args_no_sessiond should check *only*=
 for the "version" and "view" commands.

If check_args_no_sessiond is to check the command-line options anyway (for =
completeness's sake, say), then it should check for the "-V"/"--version" op=
tion as well.  And if the check for "--h" is satisfactory, the check for "-=
-list-commands" and "--list-options" should be collapsed into a simple chec=
k for "--l".

(These observations are based on the May 23 commit, so my apologies if thes=
e points have already been addressed)

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
