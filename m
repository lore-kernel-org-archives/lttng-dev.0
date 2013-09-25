From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng snapshots and running traces
Date: Wed, 25 Sep 2013 21:18:06 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2679374E__28368.0819826715$1380143950$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VOwTH-0000T5-6T
	for lttng-dev@lists.lttng.org; Wed, 25 Sep 2013 17:18:12 -0400
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

   How does the 'lttng snapshot record' command affect a running (active) t=
race?  I presume very little, only to the extent that the consumer daemon s=
ervicing the request "steals" CPU cycles from the session daemon busily sho=
ving records into the buffer.

   Say we have a trace running in flight recorder mode and a heavy flow of =
events into its buffers.  When the 'lttng snapshot record' command is issue=
d, a consumer starts at the earliest (oldest) sub-buffer and starts dumping=
 the records to a trace directory.  As its "cursor" advances around the rin=
g of buffers, tracing continues.  By the time it wraps around the ring, the=
 tracer may very well have re-used a number of sub-buffers, so the consumer=
 keeps going, trying to catch up.  Am I right in supposing that if the read=
ing and writing speeds are well matched, this could theoretically go on nea=
rly forever, generating a huge trace?  (That's what the snapshot --max-size=
 option is for, along with the enable-channel --tracefile-size and --tracef=
ile-count options)

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
