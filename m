From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Overwrite mode, lost events, and reader behaviour
Date: Mon, 18 Nov 2013 14:43:06 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A2924__19294.7126379751$1384785863$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1ViQ2f-0002LW-Md
	for lttng-dev@lists.lttng.org; Mon, 18 Nov 2013 09:43:15 -0500
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

   I'd like a clarification.  In overwrite mode, and assuming the writers a=
re overwhelming the consumers, what is the behaviour?

   Assume we have this situation within a given channel (numbering the sub-=
buffers in chronological order), and the writers are about to catch up with=
 the reader (the extra sub-buffer is double-bracketed and the sub-buffer it=
 is "shadowing" is marked with a trailing asterisk):

[8] [9] [2] [3] [4] [5] [6] [7] [[-]]   reader at [2], writers at [9], spar=
e sub-buffer unused/unallocated

[8] [9] [10]* [3] [4] [5] [6] [7] [[2]]   reader at [[2]], writers at [10],=
 spare sub-buffer shadowing [10]

[8] [9] [10]* [11] [4] [5] [6] [7] [[2]]   reader at [[2]], writers at [11]=
, spare sub-buffer shadowing [10]

   Now, when the reader completes evacuating [[2]], it moves on to [11] and=
 realises there is a time gap.  I suspect it does not just jump its clock a=
head, because that would give up on [4] through [10].  Does it skip to the =
next sub-buffer until it sees the clock go backward (the circularity of the=
 buffer guarantees there is always one such discontinuity), resuming its wo=
rk with [4]?  If yes, in the worst case the reader will go once around the =
sub-buffers, checking timestamps, before resuming its work.  This could be =
avoided if the buffer metadata kept the spare sub-buffer chained to the old=
est one (i.e. the third step is [8] [9] [10] [11]* [4] [5] [6] [7] [[2]]), =
so the reader never needs to call "next()" more than once.  Is this what lt=
tng already does?

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
