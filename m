From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: one sessiond for multiuser system
Date: Mon, 12 Aug 2013 13:23:20 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26661827__28136.3354567022$1376313861$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V8s5i-0000pu-0M
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 09:23:27 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=28jeremie=2Egalarneau=40efficios=2E?= =?iso-8859-1?Q?com=29?= <jeremie.galarneau@efficios.com>, Stanislav Vovk <stanislav.vovk@ericsson.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Message: 5
Date: Fri, 9 Aug 2013 10:54:49 -0400
From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>

> On Fri, Aug 9, 2013 at 4:01 AM, Stanislav Vovk <stanislav.vovk@ericsson.c=
om> wrote:
> > In my system there are two users, root and Bob. I am starting sessiond =
at boot as root user. And instrumented programs are started as either root =
or Bob. I am logged in to the system and controlling lttng as root user.
> > - When executing "lttng list -u" I see events registered by programs st=
arted as root. I don't see events from programs started as Bob. Why? Did I =
forget something?
> > - Now I switch user to Bob in the shell. Executing "lttng list -u" does=
 not give any output at all, instead a new sessiond is started. How can I h=
ave one sessiond for the whole system?
>
> A non-privileged user can only interact with a root session daemon if he =
is part of the "tracing" group. Is it the case for "Bob" in this example?
>
> Reproducing your scenario here with "Bob" being part of the tracing group:
> - Root can list its own sessions as well as Bob's
> - Bob's user space events can also be seen by root
> - Bob can't see the sessions created by root.

   Actually, a non-root user can also access the root daemon if he has sudo=
 privileges.

   The root daemon will see the various user-space events, but it will *not=
* list the user sessions: the various lttng-sessiond daemons do not talk to=
 each other.  (This may become possible with a later version of lttng)

   To funnel all tracing through the root daemon, make sure any user lttng-=
sessiond daemons are killed and only the root lttng-sessiond daemon is runn=
ing, then either make your users members of the 'tracing' group, or systema=
tically use 'sudo lttng ...' or 'sudo -H lttng ...' from the user shells.  =
The first form will put the trace outputs in each user's ~/lttng-traces, th=
e second form will combine all trace outputs in /root/lttng-traces.  You ma=
y need to chmod the resulting folders and files if you want to later access=
 them as non-root.

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
