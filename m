From: Yonghong Yan <yanyh15@gmail.com>
Subject: Re: tracing multithread user program and API support
 for enabling/disabling events and for adding/removing context fields
Date: Thu, 20 Dec 2018 15:27:20 -0500
Message-ID: <CACJEY87EOhJ6X12SS4n+uC1=67WuK2EZFe2WQge8xj4o+ucx=Q__49213.901095982$1545337535$gmane$org@mail.gmail.com>
References: <CACJEY87s+TAkMtKrW7UczWJCBaisjtKVJifM5cAqwDtnWnGt9A@mail.gmail.com>
 <1102294099.6322.1545254432246.JavaMail.zimbra@efficios.com>
 <CACJEY86A_nte0t7pqNQA_TnshWokXSUha44rh4aq+4-bMsN0Cg@mail.gmail.com>
 <172660935.7098.1545335355004.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3186490335684225047=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by lists.lttng.org (Postfix) with ESMTPS id 43LNbp19nqz16gR
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 15:27:33 -0500 (EST)
Received: by mail-pl1-x636.google.com with SMTP id g9so1396017plo.3
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 12:27:33 -0800 (PST)
In-Reply-To: <172660935.7098.1545335355004.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3186490335684225047==
Content-Type: multipart/alternative; boundary="000000000000ce44ae057d79f5be"

--000000000000ce44ae057d79f5be
Content-Type: text/plain; charset="UTF-8"

Apologize for the wrong terms. I will ask in another way: I have
multithread code, and if a thread calls lttng_enable_event (...), will it
impact only the calling thread, or the threads spawned after that call, or
all the threads of the process?

Got your answer about vtid context. It is similar to what I am doing. We
want to analyze behavior of all user threads. In the current LTTng, we need
have that vtid field for each event even if it is rare situation that a
thread migrate, and also for analyzing the traces, we need to check each
records and sort the traces according to the vtid. It impacts the
performance of both tracing and analysis. If I want to change the way of
how traces are fed to the buffer in LTTng, how complicated will it be? I am
guessing I will need to at least replace sched_getcpu with vtid (or alike
so all the user threads are numbered from 0), and/or have the ring buffer
bind to the user thread, and more.

Yonghong


On Thu, Dec 20, 2018 at 2:49 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi,
>
> Can you define what you mean by "per-user-thread tracepoint" and
> "whole-user-process" ? AFAIK
> those concepts don't appear anywhere in the LTTng documentations.
>
> Thanks,
>
> Mathieu
>
> ----- On Dec 19, 2018, at 6:06 PM, Yonghong Yan <yanyh15@gmail.com> wrote:
>
> Got another question about lttng_enable_event(): Using this API will
> impact per-user-thread tracepoint or the whole-user-process? I am thinking
> of the whole process, but want to confirm.
>
> Yonghong
>
>
> On Wed, Dec 19, 2018 at 4:20 PM Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> Hi Yonghong,
>>
>> ----- On Dec 19, 2018, at 1:19 PM, Yonghong Yan <yanyh15@gmail.com>
>> wrote:
>>
>> We are experimenting LTTng for tracing multi-threaded program, it works
>> very well for us. Thank you for having this great tool. But we have some
>> concerns about the overhead and scalability of the tracing. Could you share
>> some insight of the following questions?
>> 1. The session domain communicates with the user application via Unix
>> domain socket, from LTTng document. is the communication frequent, such as
>> each event requires communication, or the communication just happens at the
>> beginning to configure user space tracing?
>>
>> This Unix socket is only for "control" of tracing (infrequent
>> communication). The high-throughput tracing data goes through a shared
>> memory map (per-cpu buffers).
>>
>> 2. For the consumer domain, is the consumer domain has a thread per
>> CPU/channel to write to disk or relay the traces, or it is a single
>> threaded-process handling all the channels and ring buffers, which could
>> become a bottleneck if we have large number of user threads all feeding
>> traces?
>>
>> Each consumer daemon is a single thread at the moment. It could be
>> improved by implementing a multithreaded design in the future. It should
>> help especially in NUMA setups, where having the consumer daemon on the
>> same NUMA node as the ring buffer it reads from would minimize the amount
>> of remote NUMA accesses.
>>
>> Another point is cases where I/O is performed to various target locations
>> (different network interfaces or disks). When all I/O goes through the same
>> interface, the bottleneck becomes the block device or the network
>> interface. However, for scenarios involving many network interfaces or
>> block devices, then multithreading the consumer daemon could become useful.
>>
>> This has not been a priority for anyone so far though.
>>
>> 3. In the one channel/ring buffer per CPU setting, if a user thread
>> migrates from one CPU to another, are the traces generated by that user
>> thread fed to the two channels/buffers for the two CPUs?
>>
>> The event generated will belong to the per-cpu buffer on which the
>> "sched_getcpu()" invocation occurs for the event. It is only saved into a
>> single per-cpu buffer, even if the thread is migrated to a different CPU
>> before it completes writing the event. This effectively creates infrequent
>> situations where threads write into other cpu's per-cpu buffers. Note that
>> the "reserve" and "commit" operations are smp-safe in lttng-ust for that
>> reason.
>>
>> 4. So far, the events for tracing can be enabled and disabled from
>> command line, are you considering to have runtime options (APIs) to enable
>> or disable certain events? Or this is the feature that already in or can be
>> implemented in different way?
>>
>> We already expose a public LGPLv2.1 API for this. See lttng-tools:
>>
>> include/lttng/event.h: lttng_enable_event()
>>
>> It is implemented by liblttng-ctl.so
>>
>> 5. For context field, from the document, context fields cannot be removed
>> from a channel once you add it. I would like to request a feature to allow
>> removing context fields in the user program.
>>
>> That's unfortunately not that simple. The channel context field belongs
>> to the channel, which maps to the "stream" description in the resulting CTF
>> metadata in the output trace. That stream description is invariant once it
>> has been created.
>>
>> So currently the only way to remove a context would be to destroy your
>> tracing session and create a new one.
>>
>> Thanks for your interest in LTTng!
>>
>> Mathieu
>>
>>
>>
>> Thank you very much.
>> Yonghong
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--000000000000ce44ae057d79f5be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"m_-8059173662951442519gmail_signature" data-smartmail=3D"gmail_sign=
ature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">=
<div>Apologize for the wrong terms. I will ask in another way: I have multi=
thread code, and if a thread calls=C2=A0lttng_enable_event (...), will it i=
mpact only the calling thread, or the threads spawned after that call, or a=
ll the threads of the process?=C2=A0</div><br class=3D"m_-80591736629514425=
19gmail-Apple-interchange-newline"></div><div>Got your answer about vtid co=
ntext. It is similar to what I am doing. We want to analyze behavior of all=
 user threads. In the current LTTng, we need have that vtid field for each =
event even if it is rare situation that a thread migrate, and also for anal=
yzing the traces, we need to check each records and sort the traces accordi=
ng to the vtid. It impacts the performance of both tracing and analysis. If=
 I want to change the way of how traces are fed to the buffer in LTTng, how=
 complicated will it be? I am guessing I will need to at least replace sche=
d_getcpu with vtid (or alike so all the user threads are numbered from 0), =
and/or have the ring buffer bind to the user thread, and more.=C2=A0</div><=
div><br></div><div>Yonghong</div></div></div></div></div></div><br></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Dec 20, 2018 at 2:49 =
PM Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" =
target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div>Hi,<br=
></div><div><br></div><div>Can you define what you mean by &quot;per-user-t=
hread tracepoint&quot; and &quot;whole-user-process&quot; ? AFAIK</div><div=
>those concepts don&#39;t appear anywhere in the LTTng documentations.<br><=
/div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></=
div><div><br></div><div><span id=3D"gmail-m_-8059173662951442519gmail-m_730=
8152712778032493zwchr">----- On Dec 19, 2018, at 6:06 PM, Yonghong Yan &lt;=
<a href=3D"mailto:yanyh15@gmail.com" target=3D"_blank">yanyh15@gmail.com</a=
>&gt; wrote:<br></span></div><div><blockquote style=3D"border-left:2px soli=
d rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D=
"ltr">Got another question about lttng_enable_event(): Using this API will =
impact per-user-thread tracepoint or the whole-user-process? I am thinking =
of the whole process, but want to confirm.=C2=A0<div><br><div>Yonghong<br><=
br></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Wed, Dec 19, 2018 at 4:20 PM Mathieu Desnoyers &lt;<a href=3D"mailto:mat=
hieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;=
color:rgb(0,0,0)"><div>Hi Yonghong,<br></div><br><div><span id=3D"gmail-m_-=
8059173662951442519gmail-m_7308152712778032493gmail-m_2077673380353905976zw=
chr">----- On Dec 19, 2018, at 1:19 PM, Yonghong Yan &lt;<a href=3D"mailto:=
yanyh15@gmail.com" target=3D"_blank">yanyh15@gmail.com</a>&gt; wrote:<br></=
span></div><div><blockquote style=3D"border-left:2px solid rgb(16,16,255);m=
argin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr">We are experimenting LTTng fo=
r tracing multi-threaded program, it works very well for us. Thank you for =
having this great tool. But we have some concerns about the overhead and sc=
alability of the tracing. Could you share some insight of the following que=
stions?</div><div dir=3D"ltr"><div>1. The session domain communicates with =
the user application via Unix domain socket, from LTTng document. is the co=
mmunication frequent, such as each event requires communication, or the com=
munication just happens at the beginning to configure user space tracing?</=
div></div></div></blockquote><div>This Unix socket is only for &quot;contro=
l&quot; of tracing (infrequent communication). The high-throughput tracing =
data goes through a shared memory map (per-cpu buffers).<br></div><br><bloc=
kquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;paddin=
g-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decor=
ation:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><div dir=3D"ltr"><div>2. For the consumer domain, is the consumer =
domain has a thread per CPU/channel to write to disk or relay the traces, o=
r it is a single threaded-process handling all the channels and ring buffer=
s, which could become a bottleneck if we have large number of user threads =
all feeding traces?</div></div></div></blockquote><div>Each consumer daemon=
 is a single thread at the moment. It could be improved by implementing a m=
ultithreaded design in the future. It should help especially in NUMA setups=
, where having the consumer daemon on the same NUMA node as the ring buffer=
 it reads from would minimize the amount of remote NUMA accesses.<br></div>=
<br><div>Another point is cases where I/O is performed to various target lo=
cations (different network interfaces or disks). When all I/O goes through =
the same interface, the bottleneck becomes the block device or the network =
interface. However, for scenarios involving many network interfaces or bloc=
k devices, then multithreading the consumer daemon could become useful.</di=
v><br><div>This has not been a priority for anyone so far though.<br></div>=
<blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;p=
adding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div>3. In the one channel/ring buffer per CP=
U setting, if a user thread migrates from one CPU to another, are the trace=
s generated by that user thread fed to the two channels/buffers for the two=
 CPUs?</div></div></div></blockquote><div>The event generated will belong t=
o the per-cpu buffer on which the &quot;sched_getcpu()&quot; invocation occ=
urs for the event. It is only saved into a single per-cpu buffer, even if t=
he thread is migrated to a different CPU before it completes writing the ev=
ent. This effectively creates infrequent situations where threads write int=
o other cpu&#39;s per-cpu buffers. Note that the &quot;reserve&quot; and &q=
uot;commit&quot; operations are smp-safe in lttng-ust for that reason.</div=
><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;=
padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text=
-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><di=
v dir=3D"ltr"><div dir=3D"ltr"><div>4. So far, the events for tracing can b=
e enabled and disabled from command line, are you considering to have runti=
me options (APIs) to enable or disable certain events? Or this is the featu=
re that already in or can be implemented in different way?</div></div></div=
></blockquote><div>We already expose a public LGPLv2.1 API for this. See lt=
tng-tools:<br></div><br><div>include/lttng/event.h: lttng_enable_event()<br=
></div><br><div>It is implemented by liblttng-ctl.so<br></div><blockquote s=
tyle=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5=
px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">=
<div dir=3D"ltr"><div>5. For context field, from the document,=C2=A0context=
 fields cannot be removed from a channel once you add it. I would like to r=
equest a feature to allow removing context fields in the user program.=C2=
=A0</div></div></div></blockquote><div>That&#39;s unfortunately not that si=
mple. The channel context field belongs to the channel, which maps to the &=
quot;stream&quot; description in the resulting CTF metadata in the output t=
race. That stream description is invariant once it has been created.<br></d=
iv><br><div>So currently the only way to remove a context would be to destr=
oy your tracing session and create a new one.<br></div><br><div>Thanks for =
your interest in LTTng!<br></div><br><div>Mathieu<br></div><br><br><blockqu=
ote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-l=
eft:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"=
ltr"><div dir=3D"ltr"><br><div>Thank you very much.</div><div>Yonghong</div=
><br><br></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div><br><div>-- <br></div><d=
iv>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a><br></div></div></div></bloc=
kquote></div></div><br></blockquote></div><div><br></div><div>-- <br></div>=
<div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.c=
om" target=3D"_blank">http://www.efficios.com</a></div></div></div></blockq=
uote></div>
</div>

--000000000000ce44ae057d79f5be--

--===============3186490335684225047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3186490335684225047==--
