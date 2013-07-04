From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: LTTNG_ENABLE_EVENT lsm cmd type?
Date: Thu, 4 Jul 2013 16:27:25 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1342189D__43920.3433612876$1372955282$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UumNS-0003FI-Ny
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 12:27:26 -0400
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

   In the process of hunting down what is going on with a bug that occurs o=
n one machine but not on the other, I ran into this:

$ sudo -H lttng -vvv create hsession
DEBUG3 [30339/30339]: URI string: file:///root/lttng-traces/hsession-201307=
04-112000 (in uri_parse() at uri.c:291)
DEBUG3 [30339/30339]: URI file destination: /root/lttng-traces/hsession-201=
30704-112000 (in uri_parse() at uri.c:328)
DEBUG3 [30339/30339]: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, da=
ta: 0 (in uri_parse() at uri.c:505)
DEBUG1 [30339/30339]: LSM cmd type : 8 (in send_session_msg() at lttng-ctl.=
c:130)
Session hsession created.
Traces will be written in /root/lttng-traces/hsession-20130704-112000
DEBUG1 [30339/30339]: Init config session in /root (in config_init() at con=
f.c:290)

$ sudo -H lttng -vvv enable-event -a -u
DEBUG2 [30341/30341]: Config file path found: /root (in get_session_name() =
at utils.c:51)
DEBUG1 [30341/30341]: Session name found: hsession (in get_session_name() a=
t utils.c:52)
DEBUG1 [30341/30341]: LSM cmd type : 6 (in send_session_msg() at lttng-ctl.=
c:130)

On one machine the log continues with:

All UST events are enabled in channel channel0

While on the other I get:

Error: Events: UST create session failed (channel channel0, session hsessio=
n)
DEBUG1 [30341/30341]: Clean exit (in clean_exit() at lttng.c:177)

   Setting this bug aside for now (until I can reliably recreate it), what =
strikes me as odd is the lsm cmd type value: it is LTTNG_ENABLE_EVENT (6) i=
n both cases.  Shouldn't it rather be LTTNG_ENABLE_ALL_EVENT (7)?  This lsm=
 cmd type assignation occurs in only one place, lttng-tools/src/lib/lttng-c=
tl/lttng-ctl.c:685:

	if (ev->name[0] !=3D '\0') {
		lsm.cmd_type =3D LTTNG_ENABLE_EVENT;
	} else {
		lsm.cmd_type =3D LTTNG_ENABLE_ALL_EVENT;
	}

   Since the command was 'lttng enable-event -a -u', one would expect ev->n=
ame[0] to indeed be '\0', so what's going on?

Using:
lttng-tools-2.2.0-30-d771f83
lttng-ust-2.2.0-7-(rc2-46)-2dac206
userspace-rcu-0.7.4-199-(0.7.7-58)-98f483d

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
