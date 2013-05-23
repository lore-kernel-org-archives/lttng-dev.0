From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: CTF viewing with timeless events
Date: Thu, 23 May 2013 13:13:29 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D1A81F__43876.2610349388$1369314923$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UfVLx-0004P9-7T
	for lttng-dev@lists.lttng.org; Thu, 23 May 2013 09:14:45 -0400
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

Date: Wed, 22 May 2013 10:04:41 -0400
From: Matthew Khouzam <matthew.khouzam@ericsson.com>

I was given an interesting corner case and want to explain how I believe it=
 should be handled.

You are given a trace with no timestamps, and n channels.  How do you displ=
ay the events?

I propose (and have implemented) that we have a secondary fallback key to s=
ort events.
Right now, I believe babeltrace will sort by timestamp and that's it.
The eclipse viewer sorts by timestamp and if timestamps match, it sorts by =
stream file name.
In one given trace, stream file names are unique like (channel_0).

This means if you have 5 stream files with five events each, it will always=
 output as
"stream1: e1-e2-e3-e4-e5 stream2: e1-e2-e3-e4-e5 stream3: e1-e2-e3-e4-e5 st=
ream4: e1-e2-e3-e4-e5 stream5: e1-e2-e3-e4-e5"

This should avoid confusion from a reader's perspective.

Comments?
------------------------------
   At first I thought this had to be wrong because trace events always have=
 a time-stamp, but then I reread the CTF spec and, indeed, *all* of the eve=
nt packet context fields are optional, so it is possible to have a timeless=
 trace.  In which case I agree with this design.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
