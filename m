From: Evgeniy Ivanov <i@eivanov.com>
Subject: Re: Problem with perf:thread in 2.5.0
Date: Fri, 25 Jul 2014 00:10:01 +0400
Message-ID: <CAO6Ho0c3TsMVAC5P=oDWkwmfoH4sKeRBc=np+w19CV2U=8AEGQ__26887.3101602823$1406232685$gmane$org@mail.gmail.com>
References: <CAO6Ho0fvPCgt6vK3S1DjsjfnRymRG=NUDSb8M_gJPdOjJ8UP0g@mail.gmail.com>
 <53D11FD0.8060400@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1796806102=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lolkaantimat@gmail.com>) id 1XAPL5-0007yv-NP
 for lttng-dev@lists.lttng.org; Thu, 24 Jul 2014 16:10:14 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so3120736igd.2
 for <lttng-dev@lists.lttng.org>; Thu, 24 Jul 2014 13:10:01 -0700 (PDT)
In-Reply-To: <53D11FD0.8060400@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1796806102==
Content-Type: multipart/alternative; boundary=001a11c3184eb4178404fef60ae8

--001a11c3184eb4178404fef60ae8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jonathan, sorry, I've copied wrong output, original command was with
perf:thread:cpu-cycles:

> lttng add-context -u -t vpid -t perf:thread:cpu-cycles -t
perf:thread:instructions -t perf:thread:cache-misses
Session auto-20140724-091524 created.
Traces will be written in
/export/home/eiva/lttng-traces/auto-20140724-091524
UST context vpid added to all channels
Error: perf:thread:cpu-cycles: UST invalid context
Error: perf:thread:instructions: UST invalid context
Error: perf:thread:cache-misses: UST invalid context
Warning: Some command(s) went wrong
UST event eiva_test:* created in channel channel0

> lttng --version
lttng (LTTng Trace Control) 2.5.0 - Fumisterie

Later I've tried cpu-cycles separately and then accidentally switched to
perf:cpu. Now everything started to work, but nothing changed since then.
Though didn't check if we still get zeroes on another machine.


On Thu, Jul 24, 2014 at 7:01 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@ericsson.com> wrote:

> Hi!
>
> > Hi!
> >
> > I use lttng-2.5.0 (tools, modules, =E2=80=A6) and linux-3.8.13. When I =
try to
> add context for performance counters I get the following error:
> >
> >> lttng add-context -u -t perf:cpu:cpu-cycles
> > Error: perf:cpu:cpu-cycles: UST invalid context
> > Warning: Some command(s) went wrong
>
> Well i think we will both agree that the help page does not help very
> much.(Should fix that)
>
> If we go deep down into the code we get the supported context for UST
> domain. :)
>
> Ust domain support 6 type of context:
> LTTNG_EVENT_CONTEXT_VTID
> LTTNG_EVENT_CONTEXT_VPID
> LTTNG_UST_CONTEXT_VPID
> LTTNG_EVENT_CONTEXT_PTHREAD_ID
> LTTNG_EVENT_CONTEXT_PROCNAME
> LTTNG_EVENT_CONTEXT_IP
> LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER
>
> Well this does help a little ... If we dig a little deeper and search
> around we get more info and see that an enum from
> "./lttng-tools/include/lttng/event.h" lttng_event_context_t maps to anoth=
er
> one in the lttng-tool side ( context_type in add_context.c)
>
> *Important Part*
> So if we decrypt the macros and functions in add-context.c, we get that
> the following contexts are supported for UST:
>
> vpid
> vtid
> pthread_id
> procname
> ip
>
> perf:thread:cpu-cycles
> perf:thread:cycles
> perf:thread:stalled-cycles-frontend
> perf:thread:idle-cycles-frontend
> perf:thread:stalled-cycles-backend
> perf:thread:idle-cycles-backend
> perf:thread:instructions
> perf:thread:cache-references
> perf:thread:cache-misses
> perf:thread:branch-instructions
> perf:thread:branches
> perf:thread:branch-misses
> perf:thread:bus-cycles
>
> perf:thread:L1-dcache
> perf:thread:L1-icache
> perf:thread:LLC
> perf:thread:dTLB
> perf:thread:iTLB-loads
> perf:thread:iTLB-load-misses
> perf:thread:branch-loads
> perf:thread:branch-load-misses
>
> perf:thread:cpu-clock
> perf:thread:task-clock
> perf:thread:page-fault
> perf:thread:faults
> perf:thread:major-faults
> perf:thread:minor-faults
> perf:thread:context-switches
> perf:thread:cs
> perf:thread:cpu-migrations
> perf:thread:migrations
> perf:thread:alignment-faults
> perf:thread:emulation-faults
>
> **(TL;DR : perf:cpu:cpu-cycles is not in the list)**
>
> If you want perf:cpu:cpu-cycles you will need a kernel tracing domain.
>
> Even if it make sense that a ust tracing session cannot touch hardware
> stuff it won=E2=80=99t hurt to be more explicit about it. :).
>
> >
> > We have another machine with 2.5.0 (modules are not installed though)
> and adding perf:cpu:cpu-cycles works fine, but it is always zero in resul=
ts.
>
> As for this, I cannot explain why lttng-tool does not complain on adding
> the context.
> You can open a bug here http://bugs.lttng.org/projects/lttng-tools (you
> will need to create an account and sign in)
>
> Cheers,
> Jonathan
>
> >
> > --
> > Cheers,
> > Evgeniy
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>


--=20
Cheers,
Evgeniy

--001a11c3184eb4178404fef60ae8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Jonathan, sorry, I&#39;ve copied wrong output, original co=
mmand was with perf:thread:cpu-cycles:<div><br></div><div>&gt; lttng add-co=
ntext -u -t vpid -t perf:thread:cpu-cycles -t perf:thread:instructions -t p=
erf:thread:cache-misses</div>
<div>Session auto-20140724-091524 created.</div><div>Traces will be written=
 in /export/home/eiva/lttng-traces/auto-20140724-091524</div><div>UST conte=
xt vpid added to all channels</div><div>Error: perf:thread:cpu-cycles: UST =
invalid context</div>
<div>Error: perf:thread:instructions: UST invalid context</div><div>Error: =
perf:thread:cache-misses: UST invalid context</div><div>Warning: Some comma=
nd(s) went wrong</div><div>UST event eiva_test:* created in channel channel=
0</div>
<div><br>&gt; lttng --version</div><div>lttng (LTTng Trace Control) 2.5.0 -=
 Fumisterie</div><div><br></div><div>Later I&#39;ve tried cpu-cycles separa=
tely and then accidentally switched to perf:cpu. Now everything started to =
work, but nothing changed since then. Though didn&#39;t check if we still g=
et zeroes on another machine.</div>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu,=
 Jul 24, 2014 at 7:01 PM, Jonathan Rajotte-Julien <span dir=3D"ltr">&lt;<a =
href=3D"mailto:jonathan.rajotte-julien@ericsson.com" target=3D"_blank">jona=
than.rajotte-julien@ericsson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi!<br>
<div class=3D""><br>
&gt; Hi!<br>
&gt;<br>
&gt; I use lttng-2.5.0 (tools, modules, =E2=80=A6) and linux-3.8.13. When I=
 try to add context for performance counters I get the following error:<br>
&gt;<br>
&gt;&gt; lttng add-context -u -t perf:cpu:cpu-cycles<br>
&gt; Error: perf:cpu:cpu-cycles: UST invalid context<br>
&gt; Warning: Some command(s) went wrong<br>
<br>
</div>Well i think we will both agree that the help page does not help very=
 much.(Should fix that)<br>
<br>
If we go deep down into the code we get the supported context for UST domai=
n. :)<br>
<br>
Ust domain support 6 type of context:<br>
LTTNG_EVENT_CONTEXT_VTID<br>
LTTNG_EVENT_CONTEXT_VPID<br>
LTTNG_UST_CONTEXT_VPID<br>
LTTNG_EVENT_CONTEXT_PTHREAD_ID<br>
LTTNG_EVENT_CONTEXT_PROCNAME<br>
LTTNG_EVENT_CONTEXT_IP<br>
LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER<br>
<br>
Well this does help a little ... If we dig a little deeper and search aroun=
d we get more info and see that an enum from &quot;./lttng-tools/include/lt=
tng/event.h&quot; lttng_event_context_t maps to another one in the lttng-to=
ol side ( context_type in add_context.c)<br>

<br>
*Important Part*<br>
So if we decrypt the macros and functions in add-context.c, we get that the=
 following contexts are supported for UST:<br>
<br>
vpid<br>
vtid<br>
pthread_id<br>
procname<br>
ip<br>
<br>
perf:thread:cpu-cycles<br>
perf:thread:cycles<br>
perf:thread:stalled-cycles-frontend<br>
perf:thread:idle-cycles-frontend<br>
perf:thread:stalled-cycles-backend<br>
perf:thread:idle-cycles-backend<br>
perf:thread:instructions<br>
perf:thread:cache-references<br>
perf:thread:cache-misses<br>
perf:thread:branch-instructions<br>
perf:thread:branches<br>
perf:thread:branch-misses<br>
perf:thread:bus-cycles<br>
<br>
perf:thread:L1-dcache<br>
perf:thread:L1-icache<br>
perf:thread:LLC<br>
perf:thread:dTLB<br>
perf:thread:iTLB-loads<br>
perf:thread:iTLB-load-misses<br>
perf:thread:branch-loads<br>
perf:thread:branch-load-misses<br>
<br>
perf:thread:cpu-clock<br>
perf:thread:task-clock<br>
perf:thread:page-fault<br>
perf:thread:faults<br>
perf:thread:major-faults<br>
perf:thread:minor-faults<br>
perf:thread:context-switches<br>
perf:thread:cs<br>
perf:thread:cpu-migrations<br>
perf:thread:migrations<br>
perf:thread:alignment-faults<br>
perf:thread:emulation-faults<br>
<br>
**(TL;DR : perf:cpu:cpu-cycles is not in the list)**<br>
<br>
If you want perf:cpu:cpu-cycles you will need a kernel tracing domain.<br>
<br>
Even if it make sense that a ust tracing session cannot touch hardware stuf=
f it won=E2=80=99t hurt to be more explicit about it. :).<br>
<div class=3D""><br>
&gt;<br>
&gt; We have another machine with 2.5.0 (modules are not installed though) =
and adding perf:cpu:cpu-cycles works fine, but it is always zero in results=
.<br>
<br>
</div>As for this, I cannot explain why lttng-tool does not complain on add=
ing the context.<br>
You can open a bug here <a href=3D"http://bugs.lttng.org/projects/lttng-too=
ls" target=3D"_blank">http://bugs.lttng.org/projects/lttng-tools</a> (you w=
ill need to create an account and sign in)<br>
<br>
Cheers,<br>
Jonathan<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
&gt;<br>
&gt; --<br>
&gt; Cheers,<br>
&gt; Evgeniy<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Cheers,<br>Evgeniy
</div>

--001a11c3184eb4178404fef60ae8--


--===============1796806102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1796806102==--
