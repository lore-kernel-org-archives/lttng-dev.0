From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: SystemTap integration and C++ tracepoints
Date: Wed, 5 Jun 2013 21:36:25 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D22F4C__16255.6816162125$1370468306$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UkLOy-000870-K1
	for lttng-dev@lists.lttng.org; Wed, 05 Jun 2013 17:37:52 -0400
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

   Inspired by J=E9r=E9mie's https://gist.github.com/jgalar/5706595, I tink=
ered with lttng-ust/doc/examples/easy-ust to make the sample application us=
e a small C++ object (and turning itself into sample.cpp).  It links and wo=
rks fine except if LTTNG_UST_HAVE_SDT_INTEGRATION is #defined, in which cas=
e I get a "template with C linkage" error on line 71 of sdt.h, followed by =
a slew of "template specialization with C linkage" errors.
 =

   What is odd is that even if I #undef LTTNG_UST_HAVE_SDT_INTEGRATION in s=
ample.cpp just before the #include "sample_component_provider.h", it someho=
w gets turned back on by the time lttng/tracepoint.h checks it.  If I modif=
y tracepoint.h to comment out the #ifdef in order to leave only its else br=
anch, sample.cpp compiles just fine.

   Two questions, then:
1) how come #undef LTTNG_UST_HAVE_SDT_INTEGRATION doesn't work?
2) can LTTng be used to trace a C++ application when SystemTap is installed?

   I can supply a small tarball of the source code and makefile (just drop =
those in lttng-ust/doc/examples/easy-ust and "make cppdynamic" to see the p=
roblem occur).

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
