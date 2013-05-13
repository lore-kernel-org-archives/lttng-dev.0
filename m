From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: User-space tracing by the root lttng-sessiond
Date: Mon, 13 May 2013 20:58:50 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D1201A__8558.96938960559$1368480456$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Ubzqc-0001iE-Ny
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:59:54 -0400
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

   I ran a little experiment whose results surprised me.  Using a non-traci=
ng group user account, I first made sure I had a root lttng-sessiond runnin=
g and a user-space lttng-sessiond.  In the first I set up a trace for some =
kernel events plus all user-space events.  In the second I set up a trace f=
or all user-space events only.  Both traces were started, then the lttng-us=
t/doc/examples/easy-ust/sample demo was run to generate the user-space even=
ts.  Then both traces were stopped and destroyed.

   I noted there were three lttng-consumerd daemons: one in user-space, the=
 other two owned by root.  Presumably one is servicing the kernel events wh=
ile the other is servicing the user-space events.  (Question: If there were=
 several users active at once, would there be several root user-space lttng=
-consumerd daemons or still just one?)

   As expected, both traces show the sample user-space events (with no loss=
es, it turns out).  What surprised me, however, is that the pairs of events=
 were not in synch. Since they're all coming out of the same trace provider=
, I would expect the time-stamp to be issued once (by the tracepoint provid=
er), and then two copies of the event to go into the two trace buffers for =
eventual storage.  Could it be that the tracepoint provider instead issues =
two separate events, one for each of its clients?  (For the record, the pai=
rs of events were out of synch by at least 4187 ns (670 times out of 100 00=
0), and as much as 3 326 405 ns (once); in 93% of the time root event lags =
after the user-space event)

   This seems problematic to me, since multiple traces capturing the same e=
vent won't be able to reconcile their copies with each other.

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
