From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: session create failed
Date: Tue, 18 Mar 2014 21:08:24 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD31A68213__8952.05896017632$1395176971$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WQ1FN-0005Tm-VS
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 17:08:35 -0400
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
Date: Wed, 19 Mar 2014 01:19:52 +0800
From: Lingyu Zhu <lynuszhu@gmail.com>
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>

> Thanks for point that out. But My point is creating session would fail as
> root, only after I  failed enable kernel event as normal user.

   Your session creation remains successful.  You just can't do kernel trac=
ing from it.  You could have gone on to enable user-space events, etc.

   The later JUL problem is because you did not 'kill' the local session da=
emon the first lttng command spawned.

   In a nutshell, use 'lttng <command>' for local user-space tracing, 'sudo=
 -H lttng <command>' for kernel and multiple user-space tracing.  Alternate=
ly, join the 'tracing' group (log off and back on for the change to take), =
then use 'lttng <command>' for all tracing -but make sure the root daemon i=
s the only lttng session daemon running.

   As late as lttng 2.3, the lttng -g option does not work.  Has it been fi=
xed?

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
