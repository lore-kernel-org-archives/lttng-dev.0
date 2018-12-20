From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: tracing multithread user program and API support
 for enabling/disabling events and for adding/removing context fields
Date: Thu, 20 Dec 2018 16:23:02 -0500 (EST)
Message-ID: <1727262213.7749.1545340982446.JavaMail.zimbra__28907.7517496937$1545340873$gmane$org@efficios.com>
References: <CACJEY87s+TAkMtKrW7UczWJCBaisjtKVJifM5cAqwDtnWnGt9A@mail.gmail.com>
 <1102294099.6322.1545254432246.JavaMail.zimbra@efficios.com>
 <CACJEY86A_nte0t7pqNQA_TnshWokXSUha44rh4aq+4-bMsN0Cg@mail.gmail.com>
 <172660935.7098.1545335355004.JavaMail.zimbra@efficios.com>
 <CACJEY87EOhJ6X12SS4n+uC1=67WuK2EZFe2WQge8xj4o+ucx=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2376332527239063110=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43LPqx5VZgz16mS
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 16:23:09 -0500 (EST)
In-Reply-To: <CACJEY87EOhJ6X12SS4n+uC1=67WuK2EZFe2WQge8xj4o+ucx=Q@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2376332527239063110==
Content-Type: multipart/alternative;
	boundary="=_231b591d-9658-4774-8268-ae83517d4335"

--=_231b591d-9658-4774-8268-ae83517d4335
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

It will impact tracing of _all_ threads of _all_ processes tracked by the targeted tracing session. 
"lttng_enable_event()" is by no mean a "fast" operation. It is a tracing control operation meant to 
be performed outside of fast-paths. 

Changing the design of LTTng from per-cpu to something else would be a significant endeavor. 

Thanks, 

Mathieu 

----- On Dec 20, 2018, at 3:27 PM, Yonghong Yan <yanyh15@gmail.com> wrote: 

> Apologize for the wrong terms. I will ask in another way: I have multithread
> code, and if a thread calls lttng_enable_event (...), will it impact only the
> calling thread, or the threads spawned after that call, or all the threads of
> the process?

> Got your answer about vtid context. It is similar to what I am doing. We want to
> analyze behavior of all user threads. In the current LTTng, we need have that
> vtid field for each event even if it is rare situation that a thread migrate,
> and also for analyzing the traces, we need to check each records and sort the
> traces according to the vtid. It impacts the performance of both tracing and
> analysis. If I want to change the way of how traces are fed to the buffer in
> LTTng, how complicated will it be? I am guessing I will need to at least
> replace sched_getcpu with vtid (or alike so all the user threads are numbered
> from 0), and/or have the ring buffer bind to the user thread, and more.

> Yonghong

> On Thu, Dec 20, 2018 at 2:49 PM Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> Hi,

>> Can you define what you mean by "per-user-thread tracepoint" and
>> "whole-user-process" ? AFAIK
>> those concepts don't appear anywhere in the LTTng documentations.

>> Thanks,

>> Mathieu

>> ----- On Dec 19, 2018, at 6:06 PM, Yonghong Yan < [ mailto:yanyh15@gmail.com |
>> yanyh15@gmail.com ] > wrote:

>>> Got another question about lttng_enable_event(): Using this API will impact
>>> per-user-thread tracepoint or the whole-user-process? I am thinking of the
>>> whole process, but want to confirm.

>>> Yonghong

>>> On Wed, Dec 19, 2018 at 4:20 PM Mathieu Desnoyers < [
>>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>>> wrote:

>>>> Hi Yonghong,

>>>> ----- On Dec 19, 2018, at 1:19 PM, Yonghong Yan < [ mailto:yanyh15@gmail.com |
>>>> yanyh15@gmail.com ] > wrote:

>>>>> We are experimenting LTTng for tracing multi-threaded program, it works very
>>>>> well for us. Thank you for having this great tool. But we have some concerns
>>>>> about the overhead and scalability of the tracing. Could you share some insight
>>>>> of the following questions?
>>>>> 1. The session domain communicates with the user application via Unix domain
>>>>> socket, from LTTng document. is the communication frequent, such as each event
>>>>> requires communication, or the communication just happens at the beginning to
>>>>> configure user space tracing?

>>>> This Unix socket is only for "control" of tracing (infrequent communication).
>>>> The high-throughput tracing data goes through a shared memory map (per-cpu
>>>> buffers).

>>>>> 2. For the consumer domain, is the consumer domain has a thread per CPU/channel
>>>>> to write to disk or relay the traces, or it is a single threaded-process
>>>>> handling all the channels and ring buffers, which could become a bottleneck if
>>>>> we have large number of user threads all feeding traces?

>>>> Each consumer daemon is a single thread at the moment. It could be improved by
>>>> implementing a multithreaded design in the future. It should help especially in
>>>> NUMA setups, where having the consumer daemon on the same NUMA node as the ring
>>>> buffer it reads from would minimize the amount of remote NUMA accesses.

>>>> Another point is cases where I/O is performed to various target locations
>>>> (different network interfaces or disks). When all I/O goes through the same
>>>> interface, the bottleneck becomes the block device or the network interface.
>>>> However, for scenarios involving many network interfaces or block devices, then
>>>> multithreading the consumer daemon could become useful.

>>>> This has not been a priority for anyone so far though.

>>>>> 3. In the one channel/ring buffer per CPU setting, if a user thread migrates
>>>>> from one CPU to another, are the traces generated by that user thread fed to
>>>>> the two channels/buffers for the two CPUs?

>>>> The event generated will belong to the per-cpu buffer on which the
>>>> "sched_getcpu()" invocation occurs for the event. It is only saved into a
>>>> single per-cpu buffer, even if the thread is migrated to a different CPU before
>>>> it completes writing the event. This effectively creates infrequent situations
>>>> where threads write into other cpu's per-cpu buffers. Note that the "reserve"
>>>> and "commit" operations are smp-safe in lttng-ust for that reason.

>>>>> 4. So far, the events for tracing can be enabled and disabled from command line,
>>>>> are you considering to have runtime options (APIs) to enable or disable certain
>>>>> events? Or this is the feature that already in or can be implemented in
>>>>> different way?

>>>> We already expose a public LGPLv2.1 API for this. See lttng-tools:

>>>> include/lttng/event.h: lttng_enable_event()

>>>> It is implemented by liblttng-ctl.so

>>>>> 5. For context field, from the document, context fields cannot be removed from a
>>>>> channel once you add it. I would like to request a feature to allow removing
>>>>> context fields in the user program.

>>>> That's unfortunately not that simple. The channel context field belongs to the
>>>> channel, which maps to the "stream" description in the resulting CTF metadata
>>>> in the output trace. That stream description is invariant once it has been
>>>> created.

>>>> So currently the only way to remove a context would be to destroy your tracing
>>>> session and create a new one.

>>>> Thanks for your interest in LTTng!

>>>> Mathieu

>>>>> Thank you very much.
>>>>> Yonghong

>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_231b591d-9658-4774-8268-ae83517d4335
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>It will impact tracing of _all_ threads of =
_all_ processes tracked by the targeted tracing session.</div><div>"lttng_e=
nable_event()" is by no mean a "fast" operation. It is a tracing control op=
eration meant to</div><div>be performed outside of fast-paths.<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Changing the des=
ign of LTTng from per-cpu to something else would be a significant endeavor=
.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Th=
anks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- O=
n Dec 20, 2018, at 3:27 PM, Yonghong Yan &lt;yanyh15@gmail.com&gt; wrote:<b=
r></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"bo=
rder-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fon=
t-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetic=
a,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div dir=3D"ltr"><br c=
lear=3D"all"><div><div dir=3D"ltr" class=3D"m_-8059173662951442519gmail_sig=
nature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"=
><div>Apologize for the wrong terms. I will ask in another way: I have mult=
ithread code, and if a thread calls&nbsp;lttng_enable_event (...), will it =
impact only the calling thread, or the threads spawned after that call, or =
all the threads of the process?&nbsp;</div><br class=3D"m_-8059173662951442=
519gmail-Apple-interchange-newline"></div><div>Got your answer about vtid c=
ontext. It is similar to what I am doing. We want to analyze behavior of al=
l user threads. In the current LTTng, we need have that vtid field for each=
 event even if it is rare situation that a thread migrate, and also for ana=
lyzing the traces, we need to check each records and sort the traces accord=
ing to the vtid. It impacts the performance of both tracing and analysis. I=
f I want to change the way of how traces are fed to the buffer in LTTng, ho=
w complicated will it be? I am guessing I will need to at least replace sch=
ed_getcpu with vtid (or alike so all the user threads are numbered from 0),=
 and/or have the ring buffer bind to the user thread, and more.&nbsp;</div>=
<br><div>Yonghong</div></div></div></div></div></div><br></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr">On Thu, Dec 20, 2018 at 2:49 PM Mathieu=
 Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"=
_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,=
helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div>Hi,<br></div><br=
><div>Can you define what you mean by "per-user-thread tracepoint" and "who=
le-user-process" ? AFAIK</div><div>those concepts don't appear anywhere in =
the LTTng documentations.<br></div><br><div>Thanks,<br></div><br><div>Mathi=
eu<br></div><br><div><span id=3D"gmail-m_-8059173662951442519gmail-m_730815=
2712778032493zwchr">----- On Dec 19, 2018, at 6:06 PM, Yonghong Yan &lt;<a =
href=3D"mailto:yanyh15@gmail.com" target=3D"_blank">yanyh15@gmail.com</a>&g=
t; wrote:<br></span></div><div><blockquote style=3D"border-left:2px solid r=
gb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight=
:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,=
sans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r">Got another question about lttng_enable_event(): Using this API will imp=
act per-user-thread tracepoint or the whole-user-process? I am thinking of =
the whole process, but want to confirm.&nbsp;<div><br><div>Yonghong<br><br>=
</div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On =
Wed, Dec 19, 2018 at 4:20 PM Mathieu Desnoyers &lt;<a href=3D"mailto:mathie=
u.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;col=
or:rgb(0,0,0)"><div>Hi Yonghong,<br></div><br><div><span id=3D"gmail-m_-805=
9173662951442519gmail-m_7308152712778032493gmail-m_2077673380353905976zwchr=
">----- On Dec 19, 2018, at 1:19 PM, Yonghong Yan &lt;<a href=3D"mailto:yan=
yh15@gmail.com" target=3D"_blank">yanyh15@gmail.com</a>&gt; wrote:<br></spa=
n></div><div><blockquote style=3D"border-left:2px solid rgb(16,16,255);marg=
in-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt"><div dir=3D"ltr"><div dir=3D"ltr">We are experimenting LTTng for t=
racing multi-threaded program, it works very well for us. Thank you for hav=
ing this great tool. But we have some concerns about the overhead and scala=
bility of the tracing. Could you share some insight of the following questi=
ons?</div><div dir=3D"ltr"><div>1. The session domain communicates with the=
 user application via Unix domain socket, from LTTng document. is the commu=
nication frequent, such as each event requires communication, or the commun=
ication just happens at the beginning to configure user space tracing?</div=
></div></div></blockquote><div>This Unix socket is only for "control" of tr=
acing (infrequent communication). The high-throughput tracing data goes thr=
ough a shared memory map (per-cpu buffers).<br></div><br><blockquote style=
=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;c=
olor:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div>2. For the consumer domain, is the consumer domain has a =
thread per CPU/channel to write to disk or relay the traces, or it is a sin=
gle threaded-process handling all the channels and ring buffers, which coul=
d become a bottleneck if we have large number of user threads all feeding t=
races?</div></div></div></blockquote><div>Each consumer daemon is a single =
thread at the moment. It could be improved by implementing a multithreaded =
design in the future. It should help especially in NUMA setups, where havin=
g the consumer daemon on the same NUMA node as the ring buffer it reads fro=
m would minimize the amount of remote NUMA accesses.<br></div><br><div>Anot=
her point is cases where I/O is performed to various target locations (diff=
erent network interfaces or disks). When all I/O goes through the same inte=
rface, the bottleneck becomes the block device or the network interface. Ho=
wever, for scenarios involving many network interfaces or block devices, th=
en multithreading the consumer daemon could become useful.</div><br><div>Th=
is has not been a priority for anyone so far though.<br></div><blockquote s=
tyle=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5=
px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">=
<div dir=3D"ltr"><div>3. In the one channel/ring buffer per CPU setting, if=
 a user thread migrates from one CPU to another, are the traces generated b=
y that user thread fed to the two channels/buffers for the two CPUs?</div><=
/div></div></blockquote><div>The event generated will belong to the per-cpu=
 buffer on which the "sched_getcpu()" invocation occurs for the event. It i=
s only saved into a single per-cpu buffer, even if the thread is migrated t=
o a different CPU before it completes writing the event. This effectively c=
reates infrequent situations where threads write into other cpu's per-cpu b=
uffers. Note that the "reserve" and "commit" operations are smp-safe in ltt=
ng-ust for that reason.</div><blockquote style=3D"border-left:2px solid rgb=
(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr"><div>4. So far, =
the events for tracing can be enabled and disabled from command line, are y=
ou considering to have runtime options (APIs) to enable or disable certain =
events? Or this is the feature that already in or can be implemented in dif=
ferent way?</div></div></div></blockquote><div>We already expose a public L=
GPLv2.1 API for this. See lttng-tools:<br></div><br><div>include/lttng/even=
t.h: lttng_enable_event()<br></div><br><div>It is implemented by liblttng-c=
tl.so<br></div><blockquote style=3D"border-left:2px solid rgb(16,16,255);ma=
rgin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt"><div dir=3D"ltr"><div dir=3D"ltr"><div>5. For context field, fro=
m the document,&nbsp;context fields cannot be removed from a channel once y=
ou add it. I would like to request a feature to allow removing context fiel=
ds in the user program.&nbsp;</div></div></div></blockquote><div>That's unf=
ortunately not that simple. The channel context field belongs to the channe=
l, which maps to the "stream" description in the resulting CTF metadata in =
the output trace. That stream description is invariant once it has been cre=
ated.<br></div><br><div>So currently the only way to remove a context would=
 be to destroy your tracing session and create a new one.<br></div><br><div=
>Thanks for your interest in LTTng!<br></div><br><div>Mathieu<br></div><br>=
<br><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5=
px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">=
<div dir=3D"ltr"><div dir=3D"ltr"><br><div>Thank you very much.</div><div>Y=
onghong</div><br><br></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div><br><div>-- <br></div><d=
iv>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a><br></div></div></div></bloc=
kquote></div></div><br></blockquote></div><br><div>-- <br></div><div>Mathie=
u Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=
=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1"></div></div=
></div></blockquote></div>
</div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_231b591d-9658-4774-8268-ae83517d4335--

--===============2376332527239063110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2376332527239063110==--
