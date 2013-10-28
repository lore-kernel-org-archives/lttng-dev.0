From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH] Add output module which write to an
 LTTng-UST tracepoint
Date: Mon, 28 Oct 2013 14:26:39 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A00C1__37886.232607025$1382970461$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VanmC-0004Vm-L9
	for lttng-dev@lists.lttng.org; Mon, 28 Oct 2013 10:26:46 -0400
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
Cc: "rsyslog@lists.adiscon.com" <rsyslog@lists.adiscon.com>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Date: Thu, 24 Oct 2013 15:45:33 -0400

> This module will call a LTTng-UST tracepoint with each syslog entry.
> When LTTng is activated, this will write the entries in a CTF
> (Common Trace Format) file. This allow the correlating of other trace
> sources (kernel traces, other userspace traces) with system events
> logged with the syslog deamon.
>
> 3 differents tracepoints are available (msg_string, msg_detailled and
> msg_detailled_time) and they are selected with the boolean
> configuration variables actionomlttngustmsgdetailled and
> actionomlttngustlogsyslogtime. The msg_detailled is the default one.

   The tracepoints should be named msg_detailed and msg_detailed_time, and =
the configuration variable actionomlttngustmsgdetailed.  "detailled" isn't =
English (I suspect it's a gallicism  :-)  ).

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
