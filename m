From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Userspace events not seen by kernel daemon?
Date: Tue, 7 May 2013 15:51:39 -0400
Message-ID: <CA+jJMxskr5v+dzT6T0bzErO2UwrZUTonrPZotkkjSP-nOn2DqQ__956.63566976345$1367956361$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD0261A7@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<20130507140801.GC5118@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f171.google.com ([74.125.82.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UZnvN-0005CQ-Vk
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 15:51:46 -0400
Received: by mail-we0-f171.google.com with SMTP id u55so980512wes.30
	for <lttng-dev@lists.lttng.org>; Tue, 07 May 2013 12:51:40 -0700 (PDT)
In-Reply-To: <20130507140801.GC5118@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

This is the expected behaviour. Only users that belong to the
"tracing" group can interact with the root session daemon as pointed
out in the lttng-tools manpage:

"LTTng provides the use of a tracing group (default: tracing).
Whomever is in that group can interact with the root session daemon
and thus trace the kernel. Session daemons can co-exist meaning that
you can have a session daemon running as Alice that can be used to
trace her applications along side with a root daemon or even a Bob
daemon."

Since your user-space application is running as a non-tracing user, it
can only interact with a session daemon running as that same user.
There is currently no way (that I know of) to create an omniscient
session that would pickup events from the kernel and from every user
without forcing them to be part of the tracing group.

Regards,
J=E9r=E9mie

On Tue, May 7, 2013 at 10:08 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>>    I'm running an up-to-date LTTng suite (except for lttng-ust, where I'=
m using the 5 Mar 2013 20:17:22 commit). I've compiled the lttng-ust/doc/ex=
amples/easy-ust/sample application. While I run it (as a user *not* belongi=
ng to the tracing group), I notice something unexpected:
>>
>> * The local session daemon lists the sample user-space event ('lttng lis=
t -u')
>> * The kernel session daemon does not see the sample user-space event at =
all ('sudo lttng list -u ')
>
> I guess you mean "per-user" rather than "local", and "system-wide"
> rather than "kernel" here.
>
> I will let Jeremie look into your question,
>
> Thanks,
>
> Mathieu
>
>>
>>    It was my understanding that the kernel daemon should see all kernel =
and user-space events (for as many user-spaces as there might be).
>>
>>    To test this further, I set up two traces using separate consoles.  T=
he first is a user session:
>>
>> $ lttng create usersession
>> $ lttng enable-event -u --all
>>
>>    The other is a kernel session:
>>
>> $ sudo -H lttng create kernelsession
>> $ sudo -H lttng enable-event -u --all
>> $ sudo -H lttng enable-event -k sched_switch
>>
>>    I start each session (respectively '$ lttng start' and '$ sudo -H ltt=
ng start') and the sample application (from a third console, '$ ./sample').=
  I wait until sample concludes, then shut down both sessions (respectively=
 '$ lttng destroy' and '$ sudo -H lttng destroy').  Use of 'sudo -H' avoids=
 current trace name collisions (contention over the .lttngrc file), as repo=
rted earlier on this list (but not filed as a bug...maybe I should do that =
too).
>>
>>    The kernel trace contains no UST events, as can readily be discerned =
by the absence of a /ust branch in its folder structure.  This is confirmed=
 by babeltrace, which sees some 245 000 kernel events and nothing else.  Th=
ere are no missing events (babeltrace does not complain about skipped event=
s, which it did with some other traces generated about the same time).  The=
 System Monitor shows two lttng-sessiond daemons (one for me, another for r=
oot) and three lttng-consumerd daemons (one for me, two for root) as expect=
ed.
>>
>>    What did I do wrong?
>>
>> Daniel U. Thibault
>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence =
R&D Canada - Valcartier (DRDC Valcartier)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critic=
al Cyber Security (MCCS)
>> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & =
Countermeasures (SPC)
>> 2459 route de la Bravoure
>> Qu=E9bec, QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada / Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
