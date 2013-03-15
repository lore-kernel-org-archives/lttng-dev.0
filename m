From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: dlopen, gcc -l and LD_PRELOAD
Date: Fri, 15 Mar 2013 16:41:49 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD027A2C__36650.1583521769$1363365809$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UGXiH-0002fd-De
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 12:42:37 -0400
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

   In the lttng-ust man pages, there is a paragraph that reads:

Note about dlopen() usage: Due to locking side-effects caused by the way li=
bc lazily resolves Thread-Local Storage (TLS) symbols when a library is dlo=
pened, linking the tracepoint probe or liblttng-ust with dlopen() is discou=
raged.  They should be linked with the application using "-llibname" or loa=
ded with LD_PRELOAD.

   I'm confused by the LD_PRELOAD bit: as far as I know, LD_PRELOAD serves =
only to substitute a dynamic library (the LD_PRELOAD argument) for another =
(the one the executable was linked against).  I don't see how one could com=
pile an instrumented application and leave its tracepoint provider unlinked=
, which is what the stated -llibname <-> LD_PRELOAD opposition implies.

   (Also, shouldn't that paragraph drop 'lazily', assuming the locking prob=
lems also arise if dlopen is used with RTLD_NOW?  Because if RTLD_NOW fixed=
 the locking problem, that's what would be recommended here, no?)

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
