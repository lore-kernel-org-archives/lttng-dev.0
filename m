From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: What is the point of the lttng --group option?
Date: Fri, 31 May 2013 16:39:48 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D224CE__5101.218695245$1370018508$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UiSO6-00083g-1d
	for lttng-dev@lists.lttng.org; Fri, 31 May 2013 12:41:10 -0400
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

   In order for a user-level (non-sudoed) lttng command to be handled by th=
e root lttng-sessiond daemon, the stars have to be properly aligned:

* The root daemon has to be running
* There must not be an lttng-sessiond daemon running for that user (other u=
sers' lttng-sessiond daemons are ignored)
* The user must belong to the root daemon's group name ('tracing' unless th=
e lttng-sessiond --group option was used to set it to something else)

   Otherwise the user-level lttng command is handled by the user's local lt=
tng-sessiond daemon (which is spawned if not already running).

   Specifying the lttng --group makes no difference.  Whether you belong to=
 it or not, the success of your non-sudoed root daemon command is decided b=
y the three bullets listed above.

   So what is this option supposed to be used for?
 =

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
