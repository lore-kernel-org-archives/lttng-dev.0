From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Buffer multiplicity in user-space
Date: Wed, 4 Dec 2013 15:42:17 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B2978__39935.8177361593$1386171804$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VoEao-0005E6-Op
	for lttng-dev@lists.lttng.org; Wed, 04 Dec 2013 10:42:32 -0500
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

   I'd appreciate a confirmation (or correction) of my understanding of buf=
fer multiplicity in user-space.  Assume we have just the root session manag=
er running, and we've created a single session and enabled all user-space e=
vents in the default channel channel0.

   In per-userID mode, if instrumented apps are running under several user =
IDs, we will have one buffer (set of sub-buffers) per user ID, collecting t=
hat userID's channel's events, and the consumer daemon simply round-robins =
servicing the buffers to the matching sub-traces (lttng-traces/session-name=
/ust/uid/1001/64-bit/channel0_0, lttng-traces/session-name/ust/uid/1002/64-=
bit/channel0_0, etc.).

   Similarly, in per-processID mode, the buffer organization is the same ex=
cept that we have a buffer per process ID (regardless of each process's own=
ing userID), and the consumer daemon round-robins between a greater number =
of buffers, dispatching the records to more sub-traces (lttng-traces/sessio=
n-name/ust/pid/app1-1001/channel0_0, lttng-traces/session-name/ust/pid/app2=
-1001/channel0_0, lttng-traces/session-name/ust/pid/app1-1002/channel0_0, e=
tc.).

   In this latter case, don't we potentially run into a lot of overhead if =
a multitude of short-lived processes occurs (i.e. going through the busines=
s of creating a buffer every time)?  Is the buffer creation triggered by th=
e process's registration with the session daemon, and does this slow the pr=
ocess start up (i.e. does the registration call return immediately or does =
it wait until the buffer is ready?)?  If the registration call returns imme=
diately, what happens if the process emits an event before the buffer creat=
ion is complete?

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
