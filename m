From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: checkinstall and lttng-ust with Java/JNI support
Date: Wed, 24 Apr 2013 21:25:36 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D10094__19936.4015520134$1366838840$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UV7DK-0000aH-S5
	for lttng-dev@lists.lttng.org; Wed, 24 Apr 2013 17:26:54 -0400
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

   I was fooling around with checkinstall in order to create installation p=
ackages for lttng-modules, userspace-rcu, etc., when I ran into what seems =
a very obscure bug (googling for the error message "unable to create `/proc=
/self/coredump_filter.dpkg-new'" brings up nothing).

   It occurs when building the Debian package for lttng-ust, but only if Ja=
va/JNI support was requested. That is to say, building lttng-ust with no ex=
tra support or with just systemtap support packages just fine.

   But when I build it with JNI/Java support, the 'sudo checkinstall make i=
nstall' runs into this at the end:

Selecting previously unselected package lttng-ust-java.
(Reading database ... 147274 files and directories currently installed.)
Unpacking lttng-ust-java (from .../lttng-ust-java_2.2.0-rc1-12_amd64.deb) .=
..
dpkg: error processing /home/daniel/Documents/git.lttng.org/lttng-ust-2.2.0=
-rc1+-a16877a-Java/lttng-ust-java_2.2.0-rc1-12_amd64.deb (--install):
 unable to create `/proc/self/coredump_filter.dpkg-new' (while processing `=
./proc/self/coredump_filter'): No such file or directory
Processing triggers for man-db ...
Errors were encountered while processing:
 /home/daniel/Documents/git.lttng.org/lttng-ust-2.2.0-rc1+-a16877a-Java/ltt=
ng-ust-java_2.2.0-rc1-12_amd64.deb

   Note that the install supervised by checkinstall worked fine, and the pa=
ckage was built successfully: the problem occurs when the package is fed to=
 apt, it seems.  The resulting package will cause the same error when run t=
hrough the Ubuntu Software Centre, for instance, meaning it is unusable.

   Any clues as to what is failing here?

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
