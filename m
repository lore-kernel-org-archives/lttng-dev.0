From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: LTTng modules not loading?
Date: Tue, 22 Jan 2013 12:22:51 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E696987933__33179.308291483$1358875437$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1TxhZ0-0007O8-Fy
	for lttng-dev@lists.lttng.org; Tue, 22 Jan 2013 12:23:10 -0500
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

   My two Ubuntu installations have the same set of LTTng modules and tools=
 (they were all built from the same git.lttng.org packages) but different k=
ernels and installation histories.  The "clean" machine has kernel linux-vi=
rtual (3.2.0-36-virtual), the other one has linux-generic (3.2.0-35-generic=
).  After installing LTTng and rebooting, the clean machine does *not* load=
 the lttng kernel modules, while the other one does.  /etc/modules and /etc=
/modprobe.d are the same, the .ko are present in /lib/modules/<kernel>/extr=
a in both cases.  The clean machine's lttng kernel modules can be loaded us=
ing modprobe without demur, so there is no problem there.

   At first I thought this was because the clean machine had not installed =
the dkms package yet, but adding it made no difference: the lttng modules d=
o not load.

   How can I get the clean machine to load the lttng kernel modules at boot=
 time?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
