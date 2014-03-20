From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng-health-check
Date: Thu, 20 Mar 2014 18:27:54 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3598FA27__22149.0298667506$1395340123$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WQhhB-0002Ty-CA
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 14:28:02 -0400
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

LTTNG_HEALTH_APP_MANAGE:
The lttng-health-check function will report the health of the application c=
ommand socket manager subsystem.  This session daemon thread (thread_manage=
_apps) watches the application command sockets; their closure indicates app=
lication shutdown (more accurately, shutdown of the application's tracepoin=
t provider) and triggers unregistration.

Would it be correct to say that if this component malfunctions, closure of =
application trace files (if tracing in per-process ID mode) will be delayed=
 until the session is destroyed, but that there won't be any other truly de=
leterious consequences?  It seems unlikely any events will be lost (the con=
sumer will commit the buffer contents normally), and this thread failure wo=
uld not hamper tracing of other applications nor client-controlled enabling=
 and disabling of events.  The lttng list of event sources would include gh=
osts (dead-and-gone apps).  Could lttng hang if the client tried to toggle =
the enabling of events published by the ghosts?

I guess my point is that, of all the possible health failures, this seems t=
he least catastrophic one.

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
