From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: one sessiond for multiuser system
Date: Mon, 12 Aug 2013 20:23:23 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2666421B__22922.0134941444$1376339058$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD26661827@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxuWdmhzReR0Jy=y-tYFeGz3bod8FNUGBbY8mc0pdD_6LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V8yeD-0006p3-Od
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 16:23:31 -0400
In-Reply-To: <CA+jJMxuWdmhzReR0Jy=y-tYFeGz3bod8FNUGBbY8mc0pdD_6LA@mail.gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Envoy=E9=A0: 12 ao=FBt 2013 16:11

On Mon, Aug 12, 2013 at 9:23 AM, Thibault, Daniel <Daniel.Thibault@drdc-rdd=
c.gc.ca> wrote:
> ----------------------------------------------------------------------
>    Actually, a non-root user can also access the root daemon if he has su=
do privileges.
>
>    The root daemon will see the various user-space events, but it will =

> *not* list the user sessions: the various lttng-sessiond daemons do =

> not talk to each other.  (This may become possible with a later =

> version of lttng)
>
>    To funnel all tracing through the root daemon, make sure any user lttn=
g-sessiond daemons are killed and only the root lttng-sessiond daemon is ru=
nning, then either make your users members of the 'tracing' group, or syste=
matically use 'sudo lttng ...' or 'sudo -H lttng ...' from the user shells.=
  The first form will put the trace outputs in each user's ~/lttng-traces, =
the second form will combine all trace outputs in /root/lttng-traces.  You =
may need to chmod the resulting folders and files if you want to later acce=
ss them as non-root.

Keep in mind that in this scenario, setting up your traces as root (using s=
udo) will still not let users that are not part of the 'tracing' group trac=
e their applications as no interactions with the session daemon are allowed=
; that includes application registration.

Getting around that would require that your users also launch the applicati=
ons themselves as root (using sudo) which is an unnecessary security risk.

J=E9r=E9mie Galarneau
EfficiOS Inc.
-----Fin du message d'origine-----

   I'm not sure I understand what you're getting at when you say "setting u=
p your traces as root (using sudo) will still not let users that are not pa=
rt of the 'tracing' group trace their applications as no interactions with =
the session daemon are allowed; that includes application registration."  U=
sers that are not part of the 'tracing' group need take no special action t=
o get their apps traced: the root session daemon sees all user-spaces.

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
