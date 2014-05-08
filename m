From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: clarification on limiting the size of the trace file
Date: Thu, 8 May 2014 13:28:11 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599F42A__23350.1196526506$1399555753$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WiON0-0005oF-1H
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 09:28:20 -0400
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
Cc: "Sadon, Mirit" <Mirit.Sadon@emc.com>, "Eshel,
 Ayelet" <Ayelet.Eshel@emc.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Mon, 5 May 2014 16:10:06 +0000

>   Your command sets up a single user-space channel named perf which uses =
a 32-part buffer of total size 32*262144=3D8388608 (8 MiB).
>   The trace is itself limited to 32 chunks of size 262144 each.  By defau=
lt, user-space channels run in discard mode.  So in this case LTTng
> should capture about 8 MiB of events to disc, and a further 8 MiB in memo=
ry before "giving up" altogether.
>
>   When the trace is started the 8 MiB buffer will start filling up, and t=
he consumer daemon will start dumping the events to the trace file.
> Once the trace file saturates at 8 MiB total size, the consumer daemon wi=
ll stop emptying the buffer.  The buffer will then capture
> another 8 MiB of events.  Once the buffer is full, LTTng will systematica=
lly discard new events as they occur.
>
>   It would be an interesting feature if the snapshot command could be use=
d at this point to dump the 8 MiB of otherwise-lost events to another trace=
 file.

   My apologies, I misspoke.  The discard/overwrite setting of the channel =
is independent of the trace file size/count settings, in the sense that it =
only matters when comparing the relative data rates of the trace providers =
and consumers.  In the example above, the on-disc trace file does *not* sat=
urate: rather, once all 32 file chunks have been written, the consumer daem=
on re-uses chunk 0, then chunk 1, etc.  The on-disc trace file in effect be=
comes a circular buffer itself.

   It could be an interesting feature to have a separate option, say 'trace=
file-discard', which would have the trace file, when tracefile-size is spec=
ified, prevent re-use of its files (or chunks if also specified).  This cou=
ld be used to capture a trace of the boot process events, for instance (whi=
ch you can already do using snapshot+discard mode).  If anyone thinks this =
may be of use, please submit a feature request on bugs.lttng.org.

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
