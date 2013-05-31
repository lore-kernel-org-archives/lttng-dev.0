From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Interplay of enable-channel options
Date: Fri, 31 May 2013 19:48:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D2256E__49705.7591252544$1370029815$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UiVKV-00013R-Bv
	for lttng-dev@lists.lttng.org; Fri, 31 May 2013 15:49:39 -0400
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

Harking back to Mathieu's post of 3 May 2013 10:42:22, I'd like to see if I=
 understand the options correctly.  I'm pretty sure I don't.

When a channel has been set to use per-UID buffering, if an event-producing=
 user-space process dies suddenly it may create a "hole" in one of the chan=
nel's sub-buffers, temporarily preventing the consumer from getting access =
to the sub-buffer.  Once the other event producers have filled the remainin=
g sub-buffers, the session daemon will try to re-use the "hung" sub-buffer,=
 at which point it will be discarded.  Unrelated events in the sub-buffer w=
ill be lost.

If the channel is also set to --discard, does this mean the session daemon =
will not flush the hung sub-buffer?  This would mean the consumer daemon wa=
its at the holed sub-buffer and never gets past it.

What if --read-timer has been set to a non-zero value?  Will the holed sub-=
buffer be flushed at that point in time?  In this case the producers may no=
t even have time to fill the remaining sub-buffers.

How can the session daemon create a hole in a sub-buffer, anyway?  Doesn't =
it get all of the event's description and payload in its own working memory=
 before starting to write it out to the sub-buffer?
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
