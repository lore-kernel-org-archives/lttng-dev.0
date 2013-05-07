From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Userspace events not seen by kernel daemon?
Date: Tue, 7 May 2013 10:08:02 -0400
Message-ID: <20130507140801.GC5118__40125.299341935$1367935721$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD0261A7@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZiYn-00026q-8f
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 10:08:05 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD0261A7@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, jeremie.galarneau@efficios.com
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    I'm running an up-to-date LTTng suite (except for lttng-ust, where I'm=
 using the 5 Mar 2013 20:17:22 commit). I've compiled the lttng-ust/doc/exa=
mples/easy-ust/sample application. While I run it (as a user *not* belongin=
g to the tracing group), I notice something unexpected:
> =

> * The local session daemon lists the sample user-space event ('lttng list=
 -u')
> * The kernel session daemon does not see the sample user-space event at a=
ll ('sudo lttng list -u ')

I guess you mean "per-user" rather than "local", and "system-wide"
rather than "kernel" here.

I will let Jeremie look into your question,

Thanks,

Mathieu

> =

>    It was my understanding that the kernel daemon should see all kernel a=
nd user-space events (for as many user-spaces as there might be).
> =

>    To test this further, I set up two traces using separate consoles.  Th=
e first is a user session:
> =

> $ lttng create usersession
> $ lttng enable-event -u --all
> =

>    The other is a kernel session:
> =

> $ sudo -H lttng create kernelsession
> $ sudo -H lttng enable-event -u --all
> $ sudo -H lttng enable-event -k sched_switch
> =

>    I start each session (respectively '$ lttng start' and '$ sudo -H lttn=
g start') and the sample application (from a third console, '$ ./sample'). =
 I wait until sample concludes, then shut down both sessions (respectively =
'$ lttng destroy' and '$ sudo -H lttng destroy').  Use of 'sudo -H' avoids =
current trace name collisions (contention over the .lttngrc file), as repor=
ted earlier on this list (but not filed as a bug...maybe I should do that t=
oo).
> =

>    The kernel trace contains no UST events, as can readily be discerned b=
y the absence of a /ust branch in its folder structure.  This is confirmed =
by babeltrace, which sees some 245 000 kernel events and nothing else.  The=
re are no missing events (babeltrace does not complain about skipped events=
, which it did with some other traces generated about the same time).  The =
System Monitor shows two lttng-sessiond daemons (one for me, another for ro=
ot) and three lttng-consumerd daemons (one for me, two for root) as expecte=
d.
> =

>    What did I do wrong?
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0/ Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
