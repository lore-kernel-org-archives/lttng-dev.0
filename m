From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [RFC] lttng-modules system call tracing filtering
Date: Mon, 21 Jul 2014 13:37:43 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359CE19A__34219.2420423546$1405949911$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1X9Dms-0002jF-Dd
 for lttng-dev@lists.lttng.org; Mon, 21 Jul 2014 09:37:57 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Sat, 19 Jul 2014 21:39:23 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Julien Desfossez <jdesfossez@efficios.com>

> For the curious, I implement this "filtering" with a per-channel bitmap t=
hat represents which system calls to trace.
> We might need to double-check that I got the NR_syscalls right for each a=
rchitecture, especially those with
> compatibility system call tables (64-bit archs having 32-bit compat sysca=
lls). For the common case (all system calls
> are traced), the pointer to the array is NULL, so this is a simple pointe=
r check, which is less expensive cache-wise
> than looking up within the bitmap.
>
> As far as lttng-tools is concerned, what is a bit different is that syste=
m calls don't each get a file descriptor assigned, =

> unlike other tracepoint events. Therefore, we interact with them at the c=
hannel level. If we can find a way to send =

> the disable-event command directly to the channel, with the new "u.syscal=
l.disable" flag I added to the lttng ABI, =

>we should be able to use disable-event with syscalls.
>
> However, I'm not sure how deeply we need to modify lttng-tools for this.
>
> Mathieu

   Why is the filter per-channel?  Last time I checked, syscalls could only=
 be assigned once per session, therefore there would only be a need for a p=
er-session filter bitmap.  Of course, if the intent is to allow syscalls to=
 be potentially multiply assigned, like user-space events are, then this is=
 the right way to go.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
