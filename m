From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Event redefinition/re-enablement
Date: Mon, 17 Mar 2014 12:26:53 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD31A61516__19969.0454210669$1395059265$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WPWdA-00066f-0T
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 08:27:04 -0400
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

----------------------------------------------------------------------
Date: Sun, 16 Mar 2014 00:41:28 -0700
From: Ruslan Uvashev <ruslan.uvashev@gmail.com>

> It seems that event once enabled for a channel cannot be reassigned to an=
other channel.
> If events are immutable will Feature #445 (https://bugs.lttng.org/issues/=
445)
>  account such situation? Or do we need to update man saying that events
> cannot be redefined?
>
> Command output below.
>
> $ sudo lttng create tst1
> Session tst1 created.
> Traces will be written in /home/rusty/lttng-traces/tst1-20140315-173020
> $ sudo lttng enable-event writeback_nothread -k
> Kernel event writeback_nothread created in channel channel0
> $ sudo lttng enable-channel ch1 -k
> Kernel channel ch1 enabled for session tst1
[...]
> $ sudo lttng disable-event writeback_nothread -k -c channel0
> Kernel event writeback_nothread disabled in channel channel0 for session =
tst1
> $ sudo lttng enable-event writeback_nothread -k -c ch1
> Error: Event writeback_nothread: Enable kernel event failed (channel ch1,=
 session tst1)
> Warning: Some command(s) went wrong

   That is a known feature/limitation of LTTng: kernel events can only be a=
ssigned once (within a session).  User-space events can be assigned to mult=
iple channels.

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
