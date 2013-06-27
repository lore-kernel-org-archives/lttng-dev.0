From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Is lttng namespace-ready?
Date: Thu, 27 Jun 2013 20:26:05 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD13143A3C__4902.74390108443$1372364805$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UsIlc-0004n4-8A
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 16:26:08 -0400
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

   I was reading Michael Kerrisk's "Namespaces in operation" (http://lwn.ne=
t/Articles/531114/), which explains most of the namespace functionalities, =
and this brings to mind a number of questions.

   Are trace paths namespace-ready?  Per-PID traces are apparently not much=
 at risk since a process can join a PID namespace only upon its creation (t=
hat is to say, PIDs are immutable).  However, collisions are still possible=
, such as if two user-space processes start within the same one-second wind=
ow in two sibling PID namespaces such that they have the same virtual PID.

   But what of per-UID traces?  What happens to a trace in progress if one =
or more processes switch user namespaces?  Presumably new sub-directories w=
ould be created under "session-name/ust/uid/"?  What about the case where t=
wo processes run by two different users (and thus being recorded under diff=
erent uid subdirectories) switch to private user namespaces which happen to=
 both map to the same numerical virtual uid?  We need to make sure the seco=
nd process switch does not overwrite the trace files of the first (recall t=
hat per-uid trace paths do not include timestamps like per-pid trace paths =
do).

   Finally, in the case of a remote trace being received by the relay daemo=
n, could a network or UTS namespace switch of the traced processes cause tr=
ouble?  I suspect not, since the daemons at either end of the connection ar=
e lttng-owned and would presumably not undergo namespace switches themselve=
s.

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
