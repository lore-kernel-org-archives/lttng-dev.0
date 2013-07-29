From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: LTTng snapshot howto
Date: Mon, 29 Jul 2013 14:50:29 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1BE24ACC__20833.2024202265$1375109504$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V3omh-0005Bc-B3
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 10:50:54 -0400
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

Date: Sun, 21 Jul 2013 14:27:52 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[...]

> $ lttng create --snapshot
> $ lttng enable-event -k -a      # enable kernel tracing
> $ lttng enable-event -u -a      # enable user-space tracing
> $ lttng start

[...]

> Each "lttng snapshot" command records a snapshot of the current buffer st=
ate. "lttng enable --snapshot" automatically setups the buffers in overwrit=
e mode for flight recording, and does not attach any output file to the tra=
ce. The "lttng snapshot record" command can be performed either while traci=
ng is started or stopped.

That should rather be "'lttng create --snapshot' automatically sets up the =
buffers in overwrite mode [...]".

I see that the snapshot actions all check for the no-output session flag.  =
So one can set up a no-output session where the buffers are nevertheless in=
 discard mode, meaning they will fill up and then tracing effectively stops=
.  The snapshot command can later recover the buffer contents.  But could w=
e then have either an additional snapshot command (e.g. 'lttng snapshot flu=
sh') or a record action option (e.g. 'lttng snapshot record --flush') that =
would flush the buffers?  This way, one could start a session in discard mo=
de, snapshot the filled buffers to disc at some point after tracing has "st=
opped", then flush them in order to capture another batch of events.  I kno=
w it seems like an unlikely use-case, but why not?  (I think a flush record=
 option AND a flush action can be useful, allowing the user to flush the bu=
ffers either with or without taking a snapshot)

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
