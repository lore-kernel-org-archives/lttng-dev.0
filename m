From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Google Summer of Code
Date: Tue, 9 Apr 2013 15:21:33 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D0DC32__17724.0941244692$1365521002$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UPaNh-0001oF-7j
	for lttng-dev@lists.lttng.org; Tue, 09 Apr 2013 11:22:45 -0400
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

   The Google Summer of Code LTTng entry (http://bugs.lttng.org/projects/lt=
tng/wiki/Google_Summer_of_Code_2013) is a promising initiative.  May I prop=
ose another little project idea?

Babeltrace support for the debugfs (/sys/kernel/debug/tracing) trace format

Brief explanation:
Provide a Babeltrace plug-in to allow Babeltrace to read from traces create=
d by the debugfs service (/sys/kernel/debug/tracing/trace).

Expected results: A Babeltrace plug-in, tests, examples and documentation.

Skill level: Easy - Medium

Prerequisite Knowledge: C, OO development

Mentors: ?

   Even if the debugfs tracing facility is destined for eventual withdrawal=
 from the Linux kernel, it may be of interest to some to recover older trac=
es generated in this way -if only in order to be able to process them in th=
e same way as CTF text dumps.  Conversion to the babeltrace text format sho=
uld be fairly straightforward; conversion to CTF would be trickier.

   Is this idea worthwhile or worthless?

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
