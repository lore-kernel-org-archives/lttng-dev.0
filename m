From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Golang agent for LTTng-ust
Date: Tue, 29 May 2018 10:08:04 -0400
Message-ID: <CA+jJMxsAXvBoMGHW2vxYsyNiC5y9vwqDLBzyi3yT5XW8K2Tt6Q__30956.0783942745$1527602791$gmane$org@mail.gmail.com>
References: <29167624-BBCE-401B-8FD9-6DFEB14D3E0E@polymtl.ca>
 <CA+jJMxtUh1dA=KcVSLSfdFQnRxC905X-omh=uObgxNNpPgbtXw@mail.gmail.com>
 <20180528143056.Horde.mM3dXk9t6dVCD9zEbiuPwFi@www.imp.polymtl.ca>
 <CA+jJMxsHLZ+KpdCewhC7fmgyaAHW5w4XeaXVtzB=PRg0-nesZQ@mail.gmail.com>
 <20180529134733.Horde.Nqd88DxUsA9Xzr0DSFCiG40@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3965662164883003537=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40wFv02vxlz18pm
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 10:08:28 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id BB456224C3C
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 10:08:27 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id oQMKqUmwYMdT for <lttng-dev@lists.lttng.org>;
 Tue, 29 May 2018 10:08:26 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 86320224C33
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 10:08:26 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id uTiIFrUWfmpA for <lttng-dev@lists.lttng.org>;
 Tue, 29 May 2018 10:08:26 -0400 (EDT)
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com
 [209.85.128.170])
 by mail.efficios.com (Postfix) with ESMTPSA id 1F0ED224C15
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 10:08:26 -0400 (EDT)
Received: by mail-wr0-f170.google.com with SMTP id i12-v6so25783828wrc.4
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 07:08:26 -0700 (PDT)
In-Reply-To: <20180529134733.Horde.Nqd88DxUsA9Xzr0DSFCiG40@www.imp.polymtl.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?Lo=C3=AFc_Gelle?= <loic.gelle@polymtl.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3965662164883003537==
Content-Type: multipart/alternative; boundary="00000000000080f1f0056d58c47f"

--00000000000080f1f0056d58c47f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 29 May 2018 at 09:47, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:

> I agree that integrating C code into a Go codebase is somewhat inelegant.
>>
>
> Not only that, but it's not sustainable. It is more a hack than a feature=
.
>

I don't understand what you mean by "not sustainable".


>
> However, I'm not sure what you mean by "implementation issues that are
>> specific to the language itself".
>>
>
> I mean that if you put static calls to C tracepoints from a Go program,
> you always have a function call (and the ~50ns overhead) triggered each
> time you hit the tracepoint, whether the tracepoint is actually enabled o=
r
> not. So basically you can't count on the compiler (specific to the
> language) to do clever branch prediction for you, which reduces the
> interest of instrumenting your code.
>

In the case of the first solution, note that the agent tracks which events
are enabled or not. In that sense, the check is performed within the Go
code, as is currently done for Python and Java.


>
> I like the third solution that you propose. I think that the first one is
> definitely not ideal and that the second one is too much work and
> maintaining. How much time do you estimate is necessary for the developme=
nt
> of the third solution?
>

It really depends on who does it I would guess. It's very probably a couple
of months to get something that is bullet-proof and mergeable.


>
> By the way, I am currently working on instrumenting the Go runtime to
> capture information on the goroutines. I am using dyntrace (
> https://github.com/charpercyr/dyntrace) for that, which kind of works but
> is really hacky.
>

That sounds great. What kind of information are you capturing?

Thanks,
J=C3=A9r=C3=A9mie


>
> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9crit=
 :
>
> On 28 May 2018 at 10:30, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:
>>
>> Hi Jeremie,
>>>
>>> Thanks for your answer. I roughly estimated the overhead of calling an
>>> empty C function (passing two integer arguments) from Go to 50ns per
>>> call.
>>> Maybe not a big deal for a lot of use cases, but more problematic if yo=
u
>>> want to trace performance-critical parts of Go like its runtime itself.
>>> The
>>> overhead could even be bigger when it involves passing strings or array=
s
>>> that have different memory layouts in Golang and C. What was the overhe=
ad
>>> that you observed for Python and Java?
>>>
>>>
>> 50ns per call doesn't sound too bad honestly.
>>
>> You have to ask yourself if you could get within 50ns of lttng-ust's
>> performance with a custom ring buffer implemented in Go.
>>
>> To use some very rough numbers, lttng-ust for that payload, takes around
>> ~250ns per event. With Mathieu's work on restartable sequence, that numb=
er
>> will be shaved off quite a bit (by half, if I remember correctly), and I=
'm
>> not sure you'll be able to use that kind of mechanism from Go code.
>>
>> I don't have numbers on hand for Python and Java. In both cases, we are
>> hooking into logging frameworks so the overhead of calling into C code
>> probably pales in comparison to the time spent formatting strings.
>> That's another problem in using the current "agent" mechanism; it really
>> only accommodates a very specific tracepoint signature that takes a stri=
ng
>> payload.
>>
>>
>>
>>> From what I understand, it will always be a problem to have agents for
>>> languages different than C, especially if you want to keep relying on
>>> existing C code. Even if the sessiond part is independant from the agen=
t
>>> itself, there are tons of implementation issues that are specific to th=
e
>>> language itself. The problem with Go is that calling C functions is
>>> really
>>> a hack that does not integrate well with the build system that was
>>> designed
>>> for Go.
>>>
>>>
>>
>> The solutions I see:
>>
>> 1) Replicate the current "agent" scheme and serialize all Go events to
>> strings
>>
>> Not ideal as you lose the events' typing, you have to serialize to strin=
gs
>> on the fast path, and you can hardly filter on event payloads.
>>
>> 2) Write a native Go ring-buffer that can be consumed by LTTng
>>
>> In essence, all the tracing would happen in Go. Events would be serializ=
ed
>> by Go code and the Go "agent" would produce the CTF metadata that
>> describes
>> their layout.
>>
>> From an integration standpoint, that's probably the most elegant solutio=
n
>> as you have no hard dependency on native code in your go projects.
>> However,
>> it's a _lot_ of work.
>>
>> First, you have to re-implement a ring-buffer that needs to perform with=
in
>> 50ns of lttng-ust's ring-buffer to be useful. You also need to port the
>> event filtering bytecode interpreter to Go.
>> Then, we need to find a way to consume that ring-buffer's content from a
>> form of consumer daemon within lttng-tools.
>>
>> 3) Add an lttng-ust API to allow dynamic event declaration
>>
>> This is something we have been considering for a while.
>>
>> Basically, we would like to introduce an API that allows applications to
>> dynamically declare tracepoints.
>> Then, those events would be serialized from Go, but the ring-buffer logi=
c
>> would remain in C.
>>
>> On each event, we would:
>>   - Obtain a memory area from lttng-ust (reserve phase, C code called fr=
om
>> Go)
>>   - Write the event's content to that area (from Go code)
>>   - Commit the event (C code called from Go)
>>
>> With this, you don't have to manually declare tracepoints and integrate
>> them into a build system to generate providers; the Go application just
>> needs to link to lttng-ust at runtime.
>> It's not a perfect solution, but it seems like an interesting compromise=
.
>>
>>
>> What do you think?
>>
>> J=C3=A9r=C3=A9mie
>>
>>
>>
>>
>>> Did I provide more context?
>>>
>>> Cheers,
>>> Lo=C3=AFc.
>>>
>>> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9cr=
it :
>>>
>>> On 4 May 2018 at 06:03, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:
>>>
>>>>
>>>> Hi,
>>>>
>>>>>
>>>>> There has been a previous discussion on the mailing list about portin=
g
>>>>> LTTng to Golang, about a year ago: https://lists.lttng.org/
>>>>> pipermail/lttng-dev/2017-June/027203.html . This new topic is to
>>>>> discuss
>>>>>
>>>>> more precisely about implementation possibilities.
>>>>>
>>>>> Currently, one has to use the the C UST agent from LTTng in order to
>>>>> instrument Golang programs, and to compile the whole thing using cust=
om
>>>>> Makefiles and cgo. Here is a recent example that I wrote:
>>>>> https://github.com/loicgelle/jaeger-go-lttng-instr
>>>>>
>>>>> As you can guess, there are a low of drawbacks in that approach. It i=
s
>>>>> actually a hack and cannot be integrated into more complex Golang
>>>>> program
>>>>> that use a more complex build process (e.g. the Golang runtime itself=
),
>>>>> because of the compiler instructions that you have to include at the
>>>>> top
>>>>> of
>>>>> the Golang files. There is also a big concern about the performance o=
f
>>>>> this
>>>>> solution, as calling a C function from Go requires to do a full conte=
xt
>>>>> switch on the stack, because the calling conventions in C and Golang
>>>>> are
>>>>> different.
>>>>>
>>>>>
>>>>> I think a more integrated and performant solution is needed. We can=
=E2=80=99t
>>>>
>>>>> really ignore a language such as Golang that is now widely adopted fo=
r
>>>>> cloud applications. LTTng is really the best solution out there in
>>>>> terms
>>>>> of
>>>>> overhead per tracepoint, and could benefit from being made available =
to
>>>>> such a large community. My question to the experts on this mailing
>>>>> list:
>>>>> how much would it take to write a Golang agent for LTTng?
>>>>>
>>>>>
>>>>>
>>>> Hi Lo=C3=AFc,
>>>>
>>>> Without having performed any measurements myself, it does seem like
>>>> calling
>>>> C from Go is very expensive. In that context, I can see that LTTng wou=
ld
>>>> probably lose its performance advantage over any native Go solution.
>>>> However, it wouldn't hurt to measure the impact and see if it really i=
s
>>>> a
>>>> deal breaker.
>>>>
>>>> We faced the same dilemma when implementing the Java and Python suppor=
t
>>>> in
>>>> lttng-ust. In those cases, we ended up calling C code, with the
>>>> performance
>>>> penalties it implies. The correlation with other applications' and the
>>>> kernel's events, along with the rest of LTTng's features, provided
>>>> enough
>>>> value to make that solution worthwhile.
>>>>
>>>> There aren't a ton of solutions if we can't call existing C code. We
>>>> basically have to reimplement a ring-buffer and the setup/communicatio=
n
>>>> infrastructure to interact with the lttng-sessiond. The communication
>>>> with
>>>> the session daemon is not a big concern as the protocol is fairly
>>>> straightforward.
>>>>
>>>> The "hairy" part is that lttng-ust and lttng-consumerd use a shared
>>>> memory
>>>> map to produce and consume the tracing buffers. This means that all
>>>> changes
>>>> to that memory layout would need to be replicated in the Go tracer,
>>>> making
>>>> future evolution more difficult. Also, I don't know how easy it would =
be
>>>> to
>>>> synchronize C and Go applications interacting in a shared memory map
>>>> given
>>>> those languages have different memory models. My knowledge of Go doesn=
't
>>>> go
>>>> that far.
>>>>
>>>> A more viable solution could be to introduce a Go-native consumer daem=
on
>>>> implementing its own synchronization with Go applications. This way,
>>>> that
>>>> implementation could evolve on its own and could also start with a
>>>> simpler
>>>> ring buffer than lttng-ust's.
>>>>
>>>> Still, it is not a small undertaking and it basically means maintainin=
g
>>>> a
>>>> third tracer implementation.
>>>>
>>>>
>>>> What do you think?
>>>>
>>>> Thanks!
>>>> J=C3=A9r=C3=A9mie
>>>>
>>>>
>>>> Cheers,
>>>>
>>>>> Lo=C3=AFc.
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>>>
>>>>>
>>>>>
>>>> --
>>>> J=C3=A9r=C3=A9mie Galarneau
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--00000000000080f1f0056d58c47f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 29 May 2018 at 09:47, Lo=C3=AFc Gelle <span dir=3D"ltr">&lt;<a href=
=3D"mailto:loic.gelle@polymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
I agree that integrating C code into a Go codebase is somewhat inelegant.<b=
r>
</blockquote>
<br></span>
Not only that, but it&#39;s not sustainable. It is more a hack than a featu=
re.<span class=3D""><br></span></blockquote><div><br></div><div>I don&#39;t=
 understand what you mean by &quot;not sustainable&quot;.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
However, I&#39;m not sure what you mean by &quot;implementation issues that=
 are<br>
specific to the language itself&quot;.<br>
</blockquote>
<br></span>
I mean that if you put static calls to C tracepoints from a Go program, you=
 always have a function call (and the ~50ns overhead) triggered each time y=
ou hit the tracepoint, whether the tracepoint is actually enabled or not. S=
o basically you can&#39;t count on the compiler (specific to the language) =
to do clever branch prediction for you, which reduces the interest of instr=
umenting your code.<br></blockquote><div><br></div><div>In the case of the =
first solution, note that the agent tracks which events are enabled or not.=
 In that sense, the check is performed within the Go code, as is currently =
done for Python and Java.<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
I like the third solution that you propose. I think that the first one is d=
efinitely not ideal and that the second one is too much work and maintainin=
g. How much time do you estimate is necessary for the development of the th=
ird solution?<br></blockquote><div><br></div><div>It really depends on who =
does it I would guess. It&#39;s very probably a couple of months to get som=
ething that is bullet-proof and mergeable.<br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
By the way, I am currently working on instrumenting the Go runtime to captu=
re information on the goroutines. I am using dyntrace (<a href=3D"https://g=
ithub.com/charpercyr/dyntrace" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/charpercyr<wbr>/dyntrace</a>) for that, which kind of works but=
 is really hacky.<span class=3D""><br></span></blockquote><div><br></div><d=
iv>That sounds great. What kind of information are you capturing?</div><div=
><br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie<br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><span class=3D"">
<br>
J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficio=
s.com" target=3D"_blank">jeremie.galarneau@efficios.co<wbr>m</a>&gt; a =C3=
=A9crit=C2=A0:<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5">
On 28 May 2018 at 10:30, Lo=C3=AFc Gelle &lt;<a href=3D"mailto:loic.gelle@p=
olymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</a>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Jeremie,<br>
<br>
Thanks for your answer. I roughly estimated the overhead of calling an<br>
empty C function (passing two integer arguments) from Go to 50ns per call.<=
br>
Maybe not a big deal for a lot of use cases, but more problematic if you<br=
>
want to trace performance-critical parts of Go like its runtime itself. The=
<br>
overhead could even be bigger when it involves passing strings or arrays<br=
>
that have different memory layouts in Golang and C. What was the overhead<b=
r>
that you observed for Python and Java?<br>
<br>
</blockquote>
<br>
50ns per call doesn&#39;t sound too bad honestly.<br>
<br>
You have to ask yourself if you could get within 50ns of lttng-ust&#39;s<br=
>
performance with a custom ring buffer implemented in Go.<br>
<br>
To use some very rough numbers, lttng-ust for that payload, takes around<br=
>
~250ns per event. With Mathieu&#39;s work on restartable sequence, that num=
ber<br>
will be shaved off quite a bit (by half, if I remember correctly), and I&#3=
9;m<br>
not sure you&#39;ll be able to use that kind of mechanism from Go code.<br>
<br>
I don&#39;t have numbers on hand for Python and Java. In both cases, we are=
<br>
hooking into logging frameworks so the overhead of calling into C code<br>
probably pales in comparison to the time spent formatting strings.<br>
That&#39;s another problem in using the current &quot;agent&quot; mechanism=
; it really<br>
only accommodates a very specific tracepoint signature that takes a string<=
br>
payload.<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
From what I understand, it will always be a problem to have agents for<br>
languages different than C, especially if you want to keep relying on<br>
existing C code. Even if the sessiond part is independant from the agent<br=
>
itself, there are tons of implementation issues that are specific to the<br=
>
language itself. The problem with Go is that calling C functions is really<=
br>
a hack that does not integrate well with the build system that was designed=
<br>
for Go.<br>
<br>
</blockquote>
<br>
<br></div></div><div><div class=3D"h5">
The solutions I see:<br>
<br>
1) Replicate the current &quot;agent&quot; scheme and serialize all Go even=
ts to<br>
strings<br>
<br>
Not ideal as you lose the events&#39; typing, you have to serialize to stri=
ngs<br>
on the fast path, and you can hardly filter on event payloads.<br>
<br>
2) Write a native Go ring-buffer that can be consumed by LTTng<br>
<br>
In essence, all the tracing would happen in Go. Events would be serialized<=
br>
by Go code and the Go &quot;agent&quot; would produce the CTF metadata that=
 describes<br>
their layout.<br>
<br>
From an integration standpoint, that&#39;s probably the most elegant soluti=
on<br>
as you have no hard dependency on native code in your go projects. However,=
<br>
it&#39;s a _lot_ of work.<br>
<br>
First, you have to re-implement a ring-buffer that needs to perform within<=
br>
50ns of lttng-ust&#39;s ring-buffer to be useful. You also need to port the=
<br>
event filtering bytecode interpreter to Go.<br>
Then, we need to find a way to consume that ring-buffer&#39;s content from =
a<br>
form of consumer daemon within lttng-tools.<br>
<br>
3) Add an lttng-ust API to allow dynamic event declaration<br>
<br>
This is something we have been considering for a while.<br>
<br>
Basically, we would like to introduce an API that allows applications to<br=
>
dynamically declare tracepoints.<br>
Then, those events would be serialized from Go, but the ring-buffer logic<b=
r>
would remain in C.<br>
<br>
On each event, we would:<br>
=C2=A0 - Obtain a memory area from lttng-ust (reserve phase, C code called =
from<br>
Go)<br>
=C2=A0 - Write the event&#39;s content to that area (from Go code)<br>
=C2=A0 - Commit the event (C code called from Go)<br>
<br>
With this, you don&#39;t have to manually declare tracepoints and integrate=
<br>
them into a build system to generate providers; the Go application just<br>
needs to link to lttng-ust at runtime.<br>
It&#39;s not a perfect solution, but it seems like an interesting compromis=
e.<br>
<br>
<br>
What do you think?<br>
<br>
J=C3=A9r=C3=A9mie<br>
<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Did I provide more context?<br>
<br>
Cheers,<br>
Lo=C3=AFc.<br>
<br>
J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficio=
s.com" target=3D"_blank">jeremie.galarneau@efficios.co<wbr>m</a>&gt; a =C3=
=A9crit :<br>
<br>
On 4 May 2018 at 06:03, Lo=C3=AFc Gelle &lt;<a href=3D"mailto:loic.gelle@po=
lymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Hi,<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
There has been a previous discussion on the mailing list about porting<br>
LTTng to Golang, about a year ago: <a href=3D"https://lists.lttng.org/" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/</a><br>
pipermail/lttng-dev/2017-June/<wbr>027203.html . This new topic is to discu=
ss<br>
<br>
more precisely about implementation possibilities.<br>
<br>
Currently, one has to use the the C UST agent from LTTng in order to<br>
instrument Golang programs, and to compile the whole thing using custom<br>
Makefiles and cgo. Here is a recent example that I wrote:<br>
<a href=3D"https://github.com/loicgelle/jaeger-go-lttng-instr" rel=3D"noref=
errer" target=3D"_blank">https://github.com/loicgelle/j<wbr>aeger-go-lttng-=
instr</a><br>
<br>
As you can guess, there are a low of drawbacks in that approach. It is<br>
actually a hack and cannot be integrated into more complex Golang program<b=
r>
that use a more complex build process (e.g. the Golang runtime itself),<br>
because of the compiler instructions that you have to include at the top<br=
>
of<br>
the Golang files. There is also a big concern about the performance of<br>
this<br>
solution, as calling a C function from Go requires to do a full context<br>
switch on the stack, because the calling conventions in C and Golang are<br=
>
different.<br>
<br>
<br>
</blockquote>
I think a more integrated and performant solution is needed. We can=E2=80=
=99t<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
really ignore a language such as Golang that is now widely adopted for<br>
cloud applications. LTTng is really the best solution out there in terms<br=
>
of<br>
overhead per tracepoint, and could benefit from being made available to<br>
such a large community. My question to the experts on this mailing list:<br=
>
how much would it take to write a Golang agent for LTTng?<br>
<br>
<br>
</blockquote>
<br>
Hi Lo=C3=AFc,<br>
<br>
Without having performed any measurements myself, it does seem like<br>
calling<br>
C from Go is very expensive. In that context, I can see that LTTng would<br=
>
probably lose its performance advantage over any native Go solution.<br>
However, it wouldn&#39;t hurt to measure the impact and see if it really is=
 a<br>
deal breaker.<br>
<br>
We faced the same dilemma when implementing the Java and Python support in<=
br>
lttng-ust. In those cases, we ended up calling C code, with the<br>
performance<br>
penalties it implies. The correlation with other applications&#39; and the<=
br>
kernel&#39;s events, along with the rest of LTTng&#39;s features, provided =
enough<br>
value to make that solution worthwhile.<br>
<br>
There aren&#39;t a ton of solutions if we can&#39;t call existing C code. W=
e<br>
basically have to reimplement a ring-buffer and the setup/communication<br>
infrastructure to interact with the lttng-sessiond. The communication with<=
br>
the session daemon is not a big concern as the protocol is fairly<br>
straightforward.<br>
<br>
The &quot;hairy&quot; part is that lttng-ust and lttng-consumerd use a shar=
ed memory<br>
map to produce and consume the tracing buffers. This means that all<br>
changes<br>
to that memory layout would need to be replicated in the Go tracer, making<=
br>
future evolution more difficult. Also, I don&#39;t know how easy it would b=
e<br>
to<br>
synchronize C and Go applications interacting in a shared memory map given<=
br>
those languages have different memory models. My knowledge of Go doesn&#39;=
t<br>
go<br>
that far.<br>
<br>
A more viable solution could be to introduce a Go-native consumer daemon<br=
>
implementing its own synchronization with Go applications. This way, that<b=
r>
implementation could evolve on its own and could also start with a simpler<=
br>
ring buffer than lttng-ust&#39;s.<br>
<br>
Still, it is not a small undertaking and it basically means maintaining a<b=
r>
third tracer implementation.<br>
<br>
<br>
What do you think?<br>
<br>
Thanks!<br>
J=C3=A9r=C3=A9mie<br>
<br>
<br>
Cheers,<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Lo=C3=AFc.<br>
<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
<br>
<br>
<br>
</blockquote>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
<br>
</blockquote>
<br>
<br>
<br>
<br>
</blockquote>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</div></div></blockquote>
<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>E=
fficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http:=
//www.efficios.com</a></div>
</div></div>

--00000000000080f1f0056d58c47f--

--===============3965662164883003537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3965662164883003537==--
