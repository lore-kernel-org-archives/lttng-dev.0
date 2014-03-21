From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: Regarding LTTng Support for ARM NO-HZ
Date: Fri, 21 Mar 2014 17:12:32 +0800
Message-ID: <CAOhR-w0L8CF6sPpdFo5+tsKPM=VeLPnmXoZS7VufN+YiCzQebQ__38140.8573863611$1395393522$gmane$org@mail.gmail.com>
References: <CAOhR-w0_0oy1aOfc64fXmxzpeqtObU4Vv3Pnp810eH+XQrmymw@mail.gmail.com>
	<1103599687.7927.1395346867026.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1630986555=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <hongbo.zhang@linaro.org>) id 1WQvaM-0000vQ-Cr
	for lttng-dev@lists.lttng.org; Fri, 21 Mar 2014 05:17:56 -0400
Received: by mail-ve0-f180.google.com with SMTP id jz11so2260883veb.11
	for <lttng-dev@lists.lttng.org>; Fri, 21 Mar 2014 02:17:48 -0700 (PDT)
In-Reply-To: <1103599687.7927.1395346867026.JavaMail.zimbra@efficios.com>
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

--===============1630986555==
Content-Type: multipart/alternative; boundary=047d7b342d8a2b421104f51a497e

--047d7b342d8a2b421104f51a497e
Content-Type: text/plain; charset=ISO-8859-1

On 21 March 2014 04:21, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>wrote:

> ------------------------------
>
> *From: *"Hongbo Zhang" <hongbo.zhang@linaro.org>
> *To: *"mathieu desnoyers" <mathieu.desnoyers@efficios.com>,
> lttng-dev@lists.lttng.org
> *Sent: *Tuesday, March 18, 2014 4:07:19 AM
> *Subject: *Regarding LTTng Support for ARM NO-HZ
>
>
> Hi Mathieu Desnoyers and all LTTng developers,
>
>
> Hi,
>
> This is Hongbo Zhang, working for Linaro. We have to enable the NO-HZ
> feature for some special case, and this leads to the question whether the
> LTTng can work without kernel ticks on ARM or not.
>
> I found out some clue that LTTng only supports x86 NO-HZ in an old link:
>
> http://git.lttng.org/?p=lttv.git;a=blob_plain;f=doc/developer/lttng-lttv-roadmap.html
>
>
> This is an old LTTng 0.x link, and does not apply to LTTng 2.x.
>
> I think the the LTTng doesn't support ARM NO-HZ, right?
>
>
> While lib ring buffer within lttng-modules has configuration modes to allow
> minimizing the impact on NO_HZ systems, the current lttng-modules 2.x
> is not setup to use those configuration options, so lttng-modules will
> wakeup
> cpus periodically to flush buffers (when kernel tracing is active).
>
> And I am going to add the ARM NO-HZ support to it now, so could you please
> give me some instructions for quick start?
>
>
> You will probably want to start by looking at the "read timer" option of
> channels, and see how it is handled within lttng-modules, and how it
> impacts
> the lib ring buffer client configuration with lttng-modules.
>
> what you probably want is lttng-modules:
>
> lib/ringbuffer/config.h
>
> RING_BUFFER_WAKEUP_BY_TIMER
> RING_BUFFER_WAKEUP_BY_WRITER
> (and compare the various wakeup modes)
>
> However, if you use wakeup by writer, this has impacts on the
> instrumentation
> coverage (e.g. you then can trigger issues when instrumenting some core
> scheduler
> code paths, NMIs, etc). So wakeup by timer is really the mode that allows
> being
> called from the entire kernel code base without risking having
> side-effects due to
> interaction of the wakeup mechanism with the rest of the kernel.
>
>
> 1. Which part of LTTng relies on kernel ticks? currently I only find the
> ring-bugger by "grep NO*HZ -i -r" command.
>
> ring_buffer_tick_nohz_callback() was a callback meant to be called by the
> in-kernel code that manages no hz. This was implemented when lib ring
> buffer
> was an in-kernel library (a patchset to the Linux kernel) rather than
> sitting within
> lttng-modules.
>
> When it was a in-kernel patchset, we could modify the nohz notifier code
> from
> the Linux kernel to notify the ring buffer that it enters or exits nohz
> mode. Unfortunately,
> there is no such notifier in the kernel today (and Thomas Gleixner refused
> to add one).
>
> So we need to add this notifier to the Linux kernel if we want to make the
> "timer-based"
> mode of the lib ring buffer work well on nohz kernels (meaning: don't wake
> up the CPUs
> that entered idle state needlessly).
>
> A possible work-around to try is to change the per-cpu timers within lib
> ring buffer into
> deferrable timers. This should be attempted too.
>
> Another possible solution would be to implement a global system wide timer
> rather than
> a per-cpu timer. This would lessen the impact of the timers on idle CPUs,
> at the expense
> of scalability. The loss of scalability is the reason why I did not
> implement this solution.
>
> 2. How does this part(ring-buffer and maybe others) relies on kernel
> ticks? can you give some explanations or do you have any document of
> it/them?
>
> I will look through the codes, but I think some clear explanations can
> make me go to the right way and speed up before reading so many codes
> without any dedicated target.
>
>
> lttng-modules lib ring buffer is the only part of lttng-modules that
> depends on timers,
> and therefore is the only part that should interact with NO HZ.
>
> Hopefully the above explanations shed some light on the topic.
>
> Please let me know if you have more questions,
>
>
Thank you Mathieu very much, I will look into the codes and raise questions
about further details/solutions if(likely) I have.

But quick questions for now:
I see there was an attempt to unify ring buffer for lttng, ftrace and perf,
but nowadays they are still using their own ring buffer respectively, am I
right? no further effort to unify it any more?

And by the way, do you have any idea about ftrace and perf, do they relies
on kernel ticks?
Thanks.


Thanks,
>
> Mathieu
>
>
> Thanks.
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b342d8a2b421104f51a497e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On 21 March 2014 04:21, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.de=
snoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div style=3D"font-size:12pt;font-famil=
y:times new roman,new york,times,serif"><hr><blockquote style=3D"padding-le=
ft:5px;font-size:12pt;font-style:normal;margin-left:5px;font-family:Helveti=
ca,Arial,sans-serif;text-decoration:none;font-weight:normal;border-left:2px=
 solid #1010ff">
<b>From: </b>&quot;Hongbo Zhang&quot; &lt;<a href=3D"mailto:hongbo.zhang@li=
naro.org" target=3D"_blank">hongbo.zhang@linaro.org</a>&gt;<br><b>To: </b>&=
quot;mathieu desnoyers&quot; &lt;<a href=3D"mailto:mathieu.desnoyers@effici=
os.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;, <a href=
=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.ltt=
ng.org</a><br>
<b>Sent: </b>Tuesday, March 18, 2014 4:07:19 AM<br><b>Subject: </b>Regardin=
g LTTng Support for ARM NO-HZ<div class=3D""><br><div><br></div><div dir=3D=
"ltr">Hi=A0Mathieu Desnoyers and all LTTng developers,</div></div></blockqu=
ote>
<div><br></div><div>Hi,<br></div><div class=3D""><div><br></div><blockquote=
 style=3D"padding-left:5px;font-size:12pt;font-style:normal;margin-left:5px=
;font-family:Helvetica,Arial,sans-serif;text-decoration:none;font-weight:no=
rmal;border-left:2px solid #1010ff">
<div dir=3D"ltr"><div>This is Hongbo Zhang, working for Linaro. We have to =
enable the NO-HZ feature for some special case, and this leads to the quest=
ion whether the LTTng can work without kernel ticks on ARM or not.</div><di=
v>
<br></div><div>I found out some clue that LTTng only supports x86 NO-HZ in =
an old link:</div><div><a href=3D"http://git.lttng.org/?p=3Dlttv.git;a=3Dbl=
ob_plain;f=3Ddoc/developer/lttng-lttv-roadmap.html" target=3D"_blank">http:=
//git.lttng.org/?p=3Dlttv.git;a=3Dblob_plain;f=3Ddoc/developer/lttng-lttv-r=
oadmap.html</a><br>
</div></div></blockquote><div><br></div></div><div>This is an old LTTng 0.x=
 link, and does not apply to LTTng 2.x.<br></div><div class=3D""><div><br><=
/div><blockquote style=3D"padding-left:5px;font-size:12pt;font-style:normal=
;margin-left:5px;font-family:Helvetica,Arial,sans-serif;text-decoration:non=
e;font-weight:normal;border-left:2px solid #1010ff">
<div dir=3D"ltr"><div>I think the the LTTng doesn&#39;t support ARM NO-HZ, =
right?</div></div></blockquote><div><br></div></div><div>While lib ring buf=
fer within lttng-modules has configuration modes to allow<br></div><div>min=
imizing the impact on NO_HZ systems, the current lttng-modules 2.x<br>
</div><div>is not setup to use those configuration options, so lttng-module=
s will wakeup<br></div><div>cpus periodically to flush buffers (when kernel=
 tracing is active).<br></div><div class=3D""><div><br></div><blockquote st=
yle=3D"padding-left:5px;font-size:12pt;font-style:normal;margin-left:5px;fo=
nt-family:Helvetica,Arial,sans-serif;text-decoration:none;font-weight:norma=
l;border-left:2px solid #1010ff">
<div dir=3D"ltr"><div>And I am going to add the ARM NO-HZ support to it now=
, so could you please give me some instructions for quick start?</div></div=
></blockquote><div><br></div></div><div>You will probably want to start by =
looking at the &quot;read timer&quot; option of<br>
</div><div>channels, and see how it is handled within lttng-modules, and ho=
w it impacts<br></div><div>the lib ring buffer client configuration with lt=
tng-modules.<br></div><div><br></div><div>what you probably want is lttng-m=
odules:<br>
</div><div><br></div><div>lib/ringbuffer/config.h<br></div><div><br></div><=
div>RING_BUFFER_WAKEUP_BY_TIMER</div><div>RING_BUFFER_WAKEUP_BY_WRITER<br><=
/div><div>(and compare the various wakeup modes)<br></div><div><br></div>
<div>However, if you use wakeup by writer, this has impacts on the instrume=
ntation<br></div><div>coverage (e.g. you then can trigger issues when instr=
umenting some core scheduler<br></div><div>code paths, NMIs, etc). So wakeu=
p by timer is really the mode that allows being<br>
</div><div>called from the entire kernel code base without risking having s=
ide-effects due to</div><div>interaction of the wakeup mechanism with the r=
est of the kernel.<br></div><div class=3D""><div><br></div><blockquote styl=
e=3D"padding-left:5px;font-size:12pt;font-style:normal;margin-left:5px;font=
-family:Helvetica,Arial,sans-serif;text-decoration:none;font-weight:normal;=
border-left:2px solid #1010ff">
<div dir=3D"ltr"><div><br></div><div>1. Which part of LTTng relies on kerne=
l ticks? currently I only find the ring-bugger by &quot;grep NO*HZ -i -r&qu=
ot; command.</div></div></blockquote></div><div>ring_buffer_tick_nohz_callb=
ack() was a callback meant to be called by the<br>
</div><div>in-kernel code that manages no hz. This was implemented when lib=
 ring buffer<br></div><div>was an in-kernel library (a patchset to the Linu=
x kernel) rather than sitting within<br></div><div>lttng-modules.<br></div>
<div><br></div><div>When it was a in-kernel patchset, we could modify the n=
ohz notifier code from<br></div><div>the Linux kernel to notify the ring bu=
ffer that it enters or exits nohz mode. Unfortunately,<br></div><div>there =
is no such notifier in the kernel today (and Thomas Gleixner refused to add=
 one).<br>
</div><div><br></div><div>So we need to add this notifier to the Linux kern=
el if we want to make the &quot;timer-based&quot;<br></div><div>mode of the=
 lib ring buffer work well on nohz kernels (meaning: don&#39;t wake up the =
CPUs</div>
<div>that entered idle state needlessly).<br></div><div><br></div><div>A po=
ssible work-around to try is to change the per-cpu timers within lib ring b=
uffer into</div><div>deferrable timers. This should be attempted too.<br>
</div><div><br></div><div>Another possible solution would be to implement a=
 global system wide timer rather than<br></div><div>a per-cpu timer. This w=
ould lessen the impact of the timers on idle CPUs, at the expense<br></div>
<div>of scalability. The loss of scalability is the reason why I did not im=
plement this solution.<br></div><div class=3D""><div><br></div><blockquote =
style=3D"padding-left:5px;font-size:12pt;font-style:normal;margin-left:5px;=
font-family:Helvetica,Arial,sans-serif;text-decoration:none;font-weight:nor=
mal;border-left:2px solid #1010ff">
<div dir=3D"ltr"><div>2. How does this part(ring-buffer and maybe others) r=
elies on kernel ticks? can you give some explanations or do you have any do=
cument of it/them?</div><div><br></div><div>I will look through the codes, =
but I think some clear explanations can make me go to the right way and spe=
ed up before reading so many codes without any dedicated=A0target.</div>
</div></blockquote><div><br></div></div><div>lttng-modules lib ring buffer =
is the only part of lttng-modules that depends on timers,</div><div>and the=
refore is the only part that should interact with NO HZ.<br></div><div>
<br></div><div>Hopefully the above explanations shed some light on the topi=
c.<br></div><div><br></div><div>Please let me know if you have more questio=
ns,<br></div><div><br></div></div></div></blockquote><div><br></div><div>
Thank you Mathieu very much, I will look into the codes and raise questions=
 about further details/solutions if(likely) I have.</div><div><br></div><di=
v>But quick questions for now:</div><div>I see there was an attempt to unif=
y ring buffer for lttng, ftrace and perf, but nowadays they are still using=
 their own ring buffer respectively, am I right? no further effort to unify=
 it any more?</div>
<div><br></div><div>And by the way, do you have any idea about ftrace and p=
erf, do they relies on kernel ticks?</div><div>Thanks.</div><div><br></div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<div><div style=3D"font-size:12pt;font-family:times new roman,new york,time=
s,serif"><div></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></=
div><div><br></div><blockquote style=3D"padding-left:5px;font-size:12pt;fon=
t-style:normal;margin-left:5px;font-family:Helvetica,Arial,sans-serif;text-=
decoration:none;font-weight:normal;border-left:2px solid #1010ff">
<div dir=3D"ltr"><div><br></div><div>Thanks.</div></div></blockquote><span =
class=3D"HOEnZb"><font color=3D"#888888"><div><br><br></div><div><br></div>=
<div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiO=
S Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><span name=3D"x"></span><br></div></font></span></div></div></blockqu=
ote></div><br></div></div>

--047d7b342d8a2b421104f51a497e--


--===============1630986555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1630986555==--
