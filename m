From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: one sessiond for multiuser system
Date: Mon, 12 Aug 2013 16:11:26 -0400
Message-ID: <CA+jJMxuWdmhzReR0Jy=y-tYFeGz3bod8FNUGBbY8mc0pdD_6LA__45457.1771006615$1376338351$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26661827@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V8ySi-0005Q4-QY
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 16:11:38 -0400
Received: by mail-wg0-f44.google.com with SMTP id l18so5871649wgh.35
	for <lttng-dev@lists.lttng.org>; Mon, 12 Aug 2013 13:11:26 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26661827@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Aug 12, 2013 at 9:23 AM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
> ----------------------------------------------------------------------
> Message: 5
> Date: Fri, 9 Aug 2013 10:54:49 -0400
> From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>
>
>> On Fri, Aug 9, 2013 at 4:01 AM, Stanislav Vovk <stanislav.vovk@ericsson.=
com> wrote:
>> > In my system there are two users, root and Bob. I am starting sessiond=
 at boot as root user. And instrumented programs are started as either root=
 or Bob. I am logged in to the system and controlling lttng as root user.
>> > - When executing "lttng list -u" I see events registered by programs s=
tarted as root. I don't see events from programs started as Bob. Why? Did I=
 forget something?
>> > - Now I switch user to Bob in the shell. Executing "lttng list -u" doe=
s not give any output at all, instead a new sessiond is started. How can I =
have one sessiond for the whole system?
>>
>> A non-privileged user can only interact with a root session daemon if he=
 is part of the "tracing" group. Is it the case for "Bob" in this example?
>>
>> Reproducing your scenario here with "Bob" being part of the tracing grou=
p:
>> - Root can list its own sessions as well as Bob's
>> - Bob's user space events can also be seen by root
>> - Bob can't see the sessions created by root.
>
>    Actually, a non-root user can also access the root daemon if he has su=
do privileges.
>
>    The root daemon will see the various user-space events, but it will *n=
ot* list the user sessions: the various lttng-sessiond daemons do not talk =
to each other.  (This may become possible with a later version of lttng)
>
>    To funnel all tracing through the root daemon, make sure any user lttn=
g-sessiond daemons are killed and only the root lttng-sessiond daemon is ru=
nning, then either make your users members of the 'tracing' group, or syste=
matically use 'sudo lttng ...' or 'sudo -H lttng ...' from the user shells.=
  The first form will put the trace outputs in each user's ~/lttng-traces, =
the second form will combine all trace outputs in /root/lttng-traces.  You =
may need to chmod the resulting folders and files if you want to later acce=
ss them as non-root.
>

Keep in mind that in this scenario, setting up your traces as root
(using sudo) will still not let users that are not part of the
'tracing' group trace their applications as no interactions with the
session daemon are allowed; that includes application registration.

Getting around that would require that your users also launch the
applications themselves as root (using sudo) which is an unnecessary
security risk.

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
