From: Rui Han <r.han@umiami.edu>
Subject: Re: Could I enable a particular system call tracing in
 LTTng 2.0
Date: Thu, 12 Jul 2012 15:16:32 -0400
Message-ID: <CABy43G9R9Hjz1pJUJqvop3c9y2-ffPPhfaXpKT+P4zena9BF-A__21388.7629834518$1342120629$gmane$org@mail.gmail.com>
References: <CABy43G-toVGrA4s5AkMWk8f_F-q_V+3A+VQYxqTTV+hfYf-RmQ@mail.gmail.com>
	<5cf3b8d7e8694b949e946a6fd1199ca7@UMEX001.cgcent.miami.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1988973406=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1SpOsR-0007dl-3x
	for lttng-dev@lists.lttng.org; Thu, 12 Jul 2012 15:16:39 -0400
Received: by wibhn17 with SMTP id hn17so4789999wib.5
	for <lttng-dev@lists.lttng.org>; Thu, 12 Jul 2012 12:16:33 -0700 (PDT)
In-Reply-To: <5cf3b8d7e8694b949e946a6fd1199ca7@UMEX001.cgcent.miami.edu>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1988973406==
Content-Type: multipart/alternative; boundary=e0cb4e6ffa2930c94904c4a6cdc6

--e0cb4e6ffa2930c94904c4a6cdc6
Content-Type: text/plain; charset=ISO-8859-1

Hi Mathieu,

Thank you for your reply. Then I probably will filter the tracing info by
post processing. I will keep exploring this great tool. It is very useful.
Thanks again.

Regards,
Rui

On Thu, Jul 12, 2012 at 1:10 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> * Rui Han (r.han@umiami.edu) wrote:
> > Hi,
> >
> > I just start using LTTng for my project. I found the system call tracing
> is
> > verbose. What if I only want have one or several particular syscalls
> > logged, how could I do that? Is there an easy way to do this like for
> > kernel events by "lttng enable-event sched_switch -k."?
>
> No at this point, sorry.
>
> Eventually, this could be done once the filter bytecode gets ported from
> LTTng-UST to LTTng-modules, but we have no ETA on this at this point.
>
> Thanks,
>
> Mathieu
>
> >
> > Thank you very much.
> >
> > Regards,
> > Rui
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--e0cb4e6ffa2930c94904c4a6cdc6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi=A0Mathieu,<div><br></div><div>Thank you for your reply. Then I probably =
will filter the tracing info by post processing. I will keep exploring this=
 great tool. It is very useful. Thanks again.=A0</div><div><br></div><div>R=
egards,</div>
<div>Rui =A0</div><div><br><div class=3D"gmail_quote">On Thu, Jul 12, 2012 =
at 1:10 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathi=
eu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">* Rui Han (<a href=3D"mail=
to:r.han@umiami.edu">r.han@umiami.edu</a>) wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I just start using LTTng for my project. I found the system call traci=
ng is<br>
&gt; verbose. What if I only want have one or several particular syscalls<b=
r>
&gt; logged, how could I do that? Is there an easy way to do this like for<=
br>
&gt; kernel events by &quot;lttng enable-event sched_switch -k.&quot;?<br>
<br>
</div>No at this point, sorry.<br>
<br>
Eventually, this could be done once the filter bytecode gets ported from<br=
>
LTTng-UST to LTTng-modules, but we have no ETA on this at this point.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Thank you very much.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Rui<br>
<br>
</div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--e0cb4e6ffa2930c94904c4a6cdc6--


--===============1988973406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1988973406==--
