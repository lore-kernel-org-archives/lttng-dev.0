From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Userspace events not seen by kernel daemon?
Date: Wed, 6 Mar 2013 19:58:43 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD0261A7__6170.77707215703$1362600023$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UDKUo-0002on-Fr
	for lttng-dev@lists.lttng.org; Wed, 06 Mar 2013 14:59:26 -0500
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

   I'm running an up-to-date LTTng suite (except for lttng-ust, where I'm u=
sing the 5 Mar 2013 20:17:22 commit). I've compiled the lttng-ust/doc/examp=
les/easy-ust/sample application. While I run it (as a user *not* belonging =
to the tracing group), I notice something unexpected:

* The local session daemon lists the sample user-space event ('lttng list -=
u')
* The kernel session daemon does not see the sample user-space event at all=
 ('sudo lttng list -u ')

   It was my understanding that the kernel daemon should see all kernel and=
 user-space events (for as many user-spaces as there might be).

   To test this further, I set up two traces using separate consoles.  The =
first is a user session:

$ lttng create usersession
$ lttng enable-event -u --all

   The other is a kernel session:

$ sudo -H lttng create kernelsession
$ sudo -H lttng enable-event -u --all
$ sudo -H lttng enable-event -k sched_switch

   I start each session (respectively '$ lttng start' and '$ sudo -H lttng =
start') and the sample application (from a third console, '$ ./sample').  I=
 wait until sample concludes, then shut down both sessions (respectively '$=
 lttng destroy' and '$ sudo -H lttng destroy').  Use of 'sudo -H' avoids cu=
rrent trace name collisions (contention over the .lttngrc file), as reporte=
d earlier on this list (but not filed as a bug...maybe I should do that too=
).

   The kernel trace contains no UST events, as can readily be discerned by =
the absence of a /ust branch in its folder structure.  This is confirmed by=
 babeltrace, which sees some 245 000 kernel events and nothing else.  There=
 are no missing events (babeltrace does not complain about skipped events, =
which it did with some other traces generated about the same time).  The Sy=
stem Monitor shows two lttng-sessiond daemons (one for me, another for root=
) and three lttng-consumerd daemons (one for me, two for root) as expected.

   What did I do wrong?

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
