From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools] Fix: Some corrections to the
 lttng man page
Date: Thu, 24 Oct 2013 16:09:12 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2679FA2C__5967.71818022734$1382631012$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VZNTF-0004xK-O1
	for lttng-dev@lists.lttng.org; Thu, 24 Oct 2013 12:09:19 -0400
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

-----Message d'origine-----
Date: Wed, 23 Oct 2013 12:08:47 -0400
From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>

> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> [...]
> +All user-space applications instrumented with lttng-ust(3) will
> automatically register to the session daemon. This feature gives you the
> ability to list available traceable applications and tracepoints on a per=
 user
> basis. (See \fBlist\fP command).

   Is this a statement of intent?  LTTng 2.3.0's list command identifies us=
er-space events by trace provider name, event name, and process ID, but not=
 by user ID (in fact it doesn't even yet filter the kernel events out when =
one asks for 'list -u session'; see bug #654).  And there is as yet no way =
to filter the 'lttng list' output by user ID (an optional argument for the =
-u option could do the trick).

   Of course, listing available tracepoints is automatically per-user when =
using a local session daemon.  But if you're a member of the 'tracing' grou=
p, you'll deal exclusively with the root daemon and won't have that choice.

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
