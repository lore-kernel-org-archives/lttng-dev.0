From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: babeltrace : Clock "monotonic" offset differs
	between traces
Date: Mon, 19 Aug 2013 12:07:31 -0400
Message-ID: <CA+jJMxsU2LHxjx=0gGBC-G0=vBrOyLzmkWMF3V9237k1s1XF5w__47885.9044182629$1376928512$gmane$org@mail.gmail.com>
References: <1376922726.78813.YahooMailBasic@web163905.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VBRzV-0008LQ-I5
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 12:07:43 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so4054868wes.34
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 09:07:31 -0700 (PDT)
In-Reply-To: <1376922726.78813.YahooMailBasic@web163905.mail.gq1.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thuya Aung <thuyaaung2002@yahoo.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Aug 19, 2013 at 10:32 AM, Thuya Aung <thuyaaung2002@yahoo.com> wrot=
e:
> Hello lttng-dev,
>
> First of all, I like to thank LTTng development team for such a wonderful=
 tracing tool for us to use.
>
> I am having the following messages when I viewed the trace file in babelt=
race.
> [warning] Clock "monotonic" offset differs between traces (delta 52116 ns=
). Using average.
> [warning] Clock "monotonic" offset differs between traces (delta 72396 ns=
). Using average.
>
> My questions are,
> 1. Why am I having these warning? Can I reliably analyze traces after hav=
ing these warning?
> 2. How can I minimize or eliminate that kind of offset?

The discrepancy may be caused by a number of factors.

The clock offset is sampled when the session is started ("lttng
start"). That means that each application being traced will sample the
correlation between UTC and a monotonic clock. The applications may
report a different offset when the system is under heavy load. Note
that this mostly affects user space tracing.

This behavior was changed as of the 2.2 release. The session daemon
now handles the UTC/monotonic correlation sampling. That means
preemption is much less likely to cause the offsets to differ.

The clocks may also lack precision on your particular kernel/architecture.

I'd encourage you to start by upgrading to 2.2 and see if you still
encounter the problem.

As for the reliability of the traces, it entirely depends on what you
are trying to observe/measure. Just be aware that events from
different apps may not appear in the correct order as the time stamps
are not based on the same clock. The difference between the clocks'
offsets lets you know how "off" the events can be off from each other.

Regards,
J=E9r=E9mie

>
> The version of LTTng tools we are using are,
> lttng-modules : 2.1.1
> lttng-tools   : 2.1.1
> lttng-ust     : 2.1.2
> userspace-rcu : 0.7.6
> babeltrace    : 1.0.3
>
> kernel version : 2.6.37.6 for power-pc
>
> Best Regards,
> Thuya
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
