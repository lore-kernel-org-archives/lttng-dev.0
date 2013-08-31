From: Gianluca Borello <g.borello@gmail.com>
Subject: Re: Tracepoints overhead in x86_64
Date: Sat, 31 Aug 2013 15:16:35 -0700
Message-ID: <CAJWsiukmE7s1KkLwg_EJy_fsX4BsQYLb+R_skFBM6YQ_S6FB6Q__7474.98345231197$1377987444$gmane$org@mail.gmail.com>
References: <CAJWsiu=og9Xnt4m31e1KGqDnEaCq9QWe8HnW5RE4foh4KCo5XA@mail.gmail.com>
	<20130831202107.GA21499@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0409062104=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <g.borello@gmail.com>) id 1VFtTG-0003H0-Es
	for lttng-dev@lists.lttng.org; Sat, 31 Aug 2013 18:16:45 -0400
Received: by mail-lb0-f179.google.com with SMTP id x18so2844828lbi.24
	for <lttng-dev@lists.lttng.org>; Sat, 31 Aug 2013 15:16:36 -0700 (PDT)
In-Reply-To: <20130831202107.GA21499@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0409062104==
Content-Type: multipart/alternative; boundary=001a11c2672a3f28a104e545b134

--001a11c2672a3f28a104e545b134
Content-Type: text/plain; charset=UTF-8

On Aug 31, 2013 1:21 PM, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
wrote:
>
> My recommendation would be to implement a dummy trace_sys_enter and
> trace_sys_exit, and then benchmark the overhead of enabling system call
> tracing (this will set TIF_SYSCALL_TRACEPOINT in every thread). So at
> least it would help you pinpoint where most of the overhead comes from.
>

Yes, I already did that before writing the patch I attached in the previous
mail, and I can confirm that simply setting  TIF_SYSCALL_TRACEPOINT in all
threads (without registering any tracepoint) shows the same overhead.

> Indeed, if you come up with ways to shrink the overhead of this "slow
> path", I'm sure the LTTng community would gladly welcome this. Of
> course, these changes would have to be proposed to the Linux kernel
> community. You will need to keep in mind that they will frown upon
> pretty much _any_ slowdown of the fast path (common case, no tracing)
> for improving the speed of the slow (uncommon) case.
>

That might be interesting.
I guess I have a couple of questions:

1) Where do you think I could find an answer to the question "can
trace_sys_enter be safely called from the fast path?". In my tests it
worked just fine, but I'm concerned that calling the tracepoint without
using the IRET slow path could lead to the potential DoS the commit was
fixing.

2) How do you think the kernel community would react to a patch that adds
the tracepoint call to the fast path? Basically, if it works, I'd check the
TIF_SYSCALL_TRACEPOINT directly in the fast path and, if set, I would
proceed in saving the registers and calling the probes, so in the common
case there would be just one more check against the current thread's flags.

Thank you again!

--001a11c2672a3f28a104e545b134
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Aug 31, 2013 1:21 PM, &quot;Mathieu Desnoyers&quot; &lt;<a href=3D"mailt=
o:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; My recommendation would be to implement a dummy trace_sys_enter and<br=
>
&gt; trace_sys_exit, and then benchmark the overhead of enabling system cal=
l<br>
&gt; tracing (this will set TIF_SYSCALL_TRACEPOINT in every thread). So at<=
br>
&gt; least it would help you pinpoint where most of the overhead comes from=
.<br>
&gt;</p>
<p dir=3D"ltr">Yes, I already did that before writing the patch I attached =
in the previous mail, and I can confirm that simply setting=C2=A0 TIF_SYSCA=
LL_TRACEPOINT in all threads (without registering any tracepoint) shows the=
 same overhead.</p>

<p dir=3D"ltr">&gt; Indeed, if you come up with ways to shrink the overhead=
 of this &quot;slow<br>
&gt; path&quot;, I&#39;m sure the LTTng community would gladly welcome this=
. Of<br>
&gt; course, these changes would have to be proposed to the Linux kernel<br=
>
&gt; community. You will need to keep in mind that they will frown upon<br>
&gt; pretty much _any_ slowdown of the fast path (common case, no tracing)<=
br>
&gt; for improving the speed of the slow (uncommon) case.<br>
&gt;</p>
<p dir=3D"ltr">That might be interesting.<br>
I guess I have a couple of questions:</p>
<p dir=3D"ltr">1) Where do you think I could find an answer to the question=
 &quot;can trace_sys_enter be safely called from the fast path?&quot;. In m=
y tests it worked just fine, but I&#39;m concerned that calling the tracepo=
int without using the IRET slow path could lead to the potential DoS the co=
mmit was fixing.</p>

<p dir=3D"ltr">2) How do you think the kernel community would react to a pa=
tch that adds the tracepoint call to the fast path? Basically, if it works,=
 I&#39;d check the TIF_SYSCALL_TRACEPOINT directly in the fast path and, if=
 set, I would proceed in saving the registers and calling the probes, so in=
 the common case there would be just one more check against the current thr=
ead&#39;s flags.</p>

<p dir=3D"ltr">Thank you again!</p>

--001a11c2672a3f28a104e545b134--


--===============0409062104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0409062104==--
