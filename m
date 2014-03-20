From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Regarding LTTng Support for ARM NO-HZ
Date: Thu, 20 Mar 2014 20:21:07 +0000 (UTC)
Message-ID: <1103599687.7927.1395346867026.JavaMail.zimbra__37442.9061929279$1395346913$gmane$org@efficios.com>
References: <CAOhR-w0_0oy1aOfc64fXmxzpeqtObU4Vv3Pnp810eH+XQrmymw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0145818233=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WQjSc-0003OW-Vq
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 16:21:08 -0400
In-Reply-To: <CAOhR-w0_0oy1aOfc64fXmxzpeqtObU4Vv3Pnp810eH+XQrmymw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0145818233==
Content-Type: multipart/alternative;
	boundary="----=_Part_7926_2049036197.1395346867025"

------=_Part_7926_2049036197.1395346867025
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Hongbo Zhang" <hongbo.zhang@linaro.org>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>,
> lttng-dev@lists.lttng.org
> Sent: Tuesday, March 18, 2014 4:07:19 AM
> Subject: Regarding LTTng Support for ARM NO-HZ

> Hi Mathieu Desnoyers and all LTTng developers,

Hi, 

> This is Hongbo Zhang, working for Linaro. We have to enable the NO-HZ feature
> for some special case, and this leads to the question whether the LTTng can
> work without kernel ticks on ARM or not.

> I found out some clue that LTTng only supports x86 NO-HZ in an old link:
> http://git.lttng.org/?p=lttv.git;a=blob_plain;f=doc/developer/lttng-lttv-roadmap.html

This is an old LTTng 0.x link, and does not apply to LTTng 2.x. 

> I think the the LTTng doesn't support ARM NO-HZ, right?

While lib ring buffer within lttng-modules has configuration modes to allow 
minimizing the impact on NO_HZ systems, the current lttng-modules 2.x 
is not setup to use those configuration options, so lttng-modules will wakeup 
cpus periodically to flush buffers (when kernel tracing is active). 

> And I am going to add the ARM NO-HZ support to it now, so could you please
> give me some instructions for quick start?

You will probably want to start by looking at the "read timer" option of 
channels, and see how it is handled within lttng-modules, and how it impacts 
the lib ring buffer client configuration with lttng-modules. 

what you probably want is lttng-modules: 

lib/ringbuffer/config.h 

RING_BUFFER_WAKEUP_BY_TIMER 
RING_BUFFER_WAKEUP_BY_WRITER 
(and compare the various wakeup modes) 

However, if you use wakeup by writer, this has impacts on the instrumentation 
coverage (e.g. you then can trigger issues when instrumenting some core scheduler 
code paths, NMIs, etc). So wakeup by timer is really the mode that allows being 
called from the entire kernel code base without risking having side-effects due to 
interaction of the wakeup mechanism with the rest of the kernel. 

> 1. Which part of LTTng relies on kernel ticks? currently I only find the
> ring-bugger by "grep NO*HZ -i -r" command.

ring_buffer_tick_nohz_callback() was a callback meant to be called by the 
in-kernel code that manages no hz. This was implemented when lib ring buffer 
was an in-kernel library (a patchset to the Linux kernel) rather than sitting within 
lttng-modules. 

When it was a in-kernel patchset, we could modify the nohz notifier code from 
the Linux kernel to notify the ring buffer that it enters or exits nohz mode. Unfortunately, 
there is no such notifier in the kernel today (and Thomas Gleixner refused to add one). 

So we need to add this notifier to the Linux kernel if we want to make the "timer-based" 
mode of the lib ring buffer work well on nohz kernels (meaning: don't wake up the CPUs 
that entered idle state needlessly). 

A possible work-around to try is to change the per-cpu timers within lib ring buffer into 
deferrable timers. This should be attempted too. 

Another possible solution would be to implement a global system wide timer rather than 
a per-cpu timer. This would lessen the impact of the timers on idle CPUs, at the expense 
of scalability. The loss of scalability is the reason why I did not implement this solution. 

> 2. How does this part(ring-buffer and maybe others) relies on kernel ticks?
> can you give some explanations or do you have any document of it/them?

> I will look through the codes, but I think some clear explanations can make
> me go to the right way and speed up before reading so many codes without any
> dedicated target.

lttng-modules lib ring buffer is the only part of lttng-modules that depends on timers, 
and therefore is the only part that should interact with NO HZ. 

Hopefully the above explanations shed some light on the topic. 

Please let me know if you have more questions, 

Thanks, 

Mathieu 

> Thanks.

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_7926_2049036197.1395346867025
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"Hongbo Zhang" &lt;hongbo=
.zhang@linaro.org&gt;<br><b>To: </b>"mathieu desnoyers" &lt;mathieu.desnoye=
rs@efficios.com&gt;, lttng-dev@lists.lttng.org<br><b>Sent: </b>Tuesday, Mar=
ch 18, 2014 4:07:19 AM<br><b>Subject: </b>Regarding LTTng Support for ARM N=
O-HZ<br><div><br></div><div dir=3D"ltr">Hi&nbsp;Mathieu Desnoyers and all L=
TTng developers,</div></blockquote><div><br></div><div>Hi,<br></div><div><b=
r></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;=
padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decor=
ation:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce=
-style=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5=
px; color: #000; font-weight: normal; font-style: normal; text-decoration: =
none; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div dir=
=3D"ltr"><div>This is Hongbo Zhang, working for Linaro. We have to enable t=
he NO-HZ feature for some special case, and this leads to the question whet=
her the LTTng can work without kernel ticks on ARM or not.</div><div><br></=
div><div>I found out some clue that LTTng only supports x86 NO-HZ in an old=
 link:</div><div><a href=3D"http://git.lttng.org/?p=3Dlttv.git;a=3Dblob_pla=
in;f=3Ddoc/developer/lttng-lttv-roadmap.html" target=3D"_blank" data-mce-hr=
ef=3D"http://git.lttng.org/?p=3Dlttv.git;a=3Dblob_plain;f=3Ddoc/developer/l=
ttng-lttv-roadmap.html">http://git.lttng.org/?p=3Dlttv.git;a=3Dblob_plain;f=
=3Ddoc/developer/lttng-lttv-roadmap.html</a><br></div></div></blockquote><d=
iv><br></div><div>This is an old LTTng 0.x link, and does not apply to LTTn=
g 2.x.<br></div><div><br></div><blockquote style=3D"border-left:2px solid #=
1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; margin-lef=
t: 5px; padding-left: 5px; color: #000; font-weight: normal; font-style: no=
rmal; text-decoration: none; font-family: Helvetica,Arial,sans-serif; font-=
size: 12pt;"><div dir=3D"ltr"><div>I think the the LTTng doesn't support AR=
M NO-HZ, right?</div></div></blockquote><div><br></div><div>While lib ring =
buffer within lttng-modules has configuration modes to allow<br></div><div>=
minimizing the impact on NO_HZ systems, the current lttng-modules 2.x<br></=
div><div>is not setup to use those configuration options, so lttng-modules =
will wakeup<br></div><div>cpus periodically to flush buffers (when kernel t=
racing is active).<br></div><div><br></div><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF=
; margin-left: 5px; padding-left: 5px; color: #000; font-weight: normal; fo=
nt-style: normal; text-decoration: none; font-family: Helvetica,Arial,sans-=
serif; font-size: 12pt;"><div dir=3D"ltr"><div>And I am going to add the AR=
M NO-HZ support to it now, so could you please give me some instructions fo=
r quick start?</div></div></blockquote><div><br></div><div>You will probabl=
y want to start by looking at the "read timer" option of<br></div><div>chan=
nels, and see how it is handled within lttng-modules, and how it impacts<br=
></div><div>the lib ring buffer client configuration with lttng-modules.<br=
></div><div><br></div><div>what you probably want is lttng-modules:<br></di=
v><div><br></div><div>lib/ringbuffer/config.h<br></div><div><br></div><div>=
RING_BUFFER_WAKEUP_BY_TIMER</div><div>RING_BUFFER_WAKEUP_BY_WRITER<br></div=
><div>(and compare the various wakeup modes)<br></div><div><br></div><div>H=
owever, if you use wakeup by writer, this has impacts on the instrumentatio=
n<br></div><div>coverage (e.g. you then can trigger issues when instrumenti=
ng some core scheduler<br></div><div>code paths, NMIs, etc). So wakeup by t=
imer is really the mode that allows being<br></div><div>called from the ent=
ire kernel code base without risking having side-effects due to</div><div>i=
nteraction of the wakeup mechanism with the rest of the kernel.<br></div><d=
iv><br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" dat=
a-mce-style=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-le=
ft: 5px; color: #000; font-weight: normal; font-style: normal; text-decorat=
ion: none; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div =
dir=3D"ltr"><div><br></div><div>1. Which part of LTTng relies on kernel tic=
ks? currently I only find the ring-bugger by "grep NO*HZ -i -r" command.</d=
iv></div></blockquote><div>ring_buffer_tick_nohz_callback() was a callback =
meant to be called by the<br></div><div>in-kernel code that manages no hz. =
This was implemented when lib ring buffer<br></div><div>was an in-kernel li=
brary (a patchset to the Linux kernel) rather than sitting within<br></div>=
<div>lttng-modules.<br></div><div><br></div><div>When it was a in-kernel pa=
tchset, we could modify the nohz notifier code from<br></div><div>the Linux=
 kernel to notify the ring buffer that it enters or exits nohz mode. Unfort=
unately,<br></div><div>there is no such notifier in the kernel today (and T=
homas Gleixner refused to add one).<br></div><div><br></div><div>So we need=
 to add this notifier to the Linux kernel if we want to make the "timer-bas=
ed"<br></div><div>mode of the lib ring buffer work well on nohz kernels (me=
aning: don't wake up the CPUs</div><div>that entered idle state needlessly)=
.<br></div><div><br></div><div>A possible work-around to try is to change t=
he per-cpu timers within lib ring buffer into</div><div>deferrable timers. =
This should be attempted too.<br></div><div><br></div><div>Another possible=
 solution would be to implement a global system wide timer rather than<br><=
/div><div>a per-cpu timer. This would lessen the impact of the timers on id=
le CPUs, at the expense<br></div><div>of scalability. The loss of scalabili=
ty is the reason why I did not implement this solution.<br></div><div><br><=
/div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-st=
yle=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px;=
 color: #000; font-weight: normal; font-style: normal; text-decoration: non=
e; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div dir=3D"l=
tr"><div>2. How does this part(ring-buffer and maybe others) relies on kern=
el ticks? can you give some explanations or do you have any document of it/=
them?</div><div><br></div><div>I will look through the codes, but I think s=
ome clear explanations can make me go to the right way and speed up before =
reading so many codes without any dedicated&nbsp;target.</div></div></block=
quote><div><br></div><div>lttng-modules lib ring buffer is the only part of=
 lttng-modules that depends on timers,</div><div>and therefore is the only =
part that should interact with NO HZ.<br></div><div><br></div><div>Hopefull=
y the above explanations shed some light on the topic.<br></div><div><br></=
div><div>Please let me know if you have more questions,<br></div><div><br><=
/div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></=
div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padd=
ing-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-sty=
le=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; =
color: #000; font-weight: normal; font-style: normal; text-decoration: none=
; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div dir=3D"lt=
r"><div><br></div><div>Thanks.</div></div></blockquote><div><br><br></div><=
div><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoy=
ers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br>=
</div></div></body></html>
------=_Part_7926_2049036197.1395346867025--


--===============0145818233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0145818233==--
