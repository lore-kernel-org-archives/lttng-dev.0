From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Golang agent for LTTng-ust
Date: Tue, 29 May 2018 12:21:41 -0400
Message-ID: <CA+jJMxsOZhyRxG55iAouZEDC7aDV3w0PskhiEscz83AvsboLAw__2383.91620009697$1527610815$gmane$org@mail.gmail.com>
References: <29167624-BBCE-401B-8FD9-6DFEB14D3E0E@polymtl.ca>
 <CA+jJMxtUh1dA=KcVSLSfdFQnRxC905X-omh=uObgxNNpPgbtXw@mail.gmail.com>
 <20180528143056.Horde.mM3dXk9t6dVCD9zEbiuPwFi@www.imp.polymtl.ca>
 <CA+jJMxsHLZ+KpdCewhC7fmgyaAHW5w4XeaXVtzB=PRg0-nesZQ@mail.gmail.com>
 <20180529134733.Horde.Nqd88DxUsA9Xzr0DSFCiG40@www.imp.polymtl.ca>
 <CA+jJMxsAXvBoMGHW2vxYsyNiC5y9vwqDLBzyi3yT5XW8K2Tt6Q@mail.gmail.com>
 <20180529143249.Horde.huEeLvWyg8gza-OejCQu5oZ@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5249604981487451576=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40wJsJ0stmz17qF
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 12:22:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 250C9222C3F
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 12:22:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id sZ0zxCGiVplk for <lttng-dev@lists.lttng.org>;
 Tue, 29 May 2018 12:22:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id EF5A3222C21
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 12:22:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id VxenBUlg73X7 for <lttng-dev@lists.lttng.org>;
 Tue, 29 May 2018 12:22:03 -0400 (EDT)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by mail.efficios.com (Postfix) with ESMTPSA id 844B3222C01
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 12:22:03 -0400 (EDT)
Received: by mail-wm0-f42.google.com with SMTP id l1-v6so42345953wmb.2
 for <lttng-dev@lists.lttng.org>; Tue, 29 May 2018 09:22:03 -0700 (PDT)
In-Reply-To: <20180529143249.Horde.huEeLvWyg8gza-OejCQu5oZ@www.imp.polymtl.ca>
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

--===============5249604981487451576==
Content-Type: multipart/alternative; boundary="00000000000061e6d8056d5aa2e4"

--00000000000061e6d8056d5aa2e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 29 May 2018 at 10:32, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:

> I don't understand what you mean by "not sustainable".
>>
>
> Not something you can keep in your codebase forever.
>

I think we're talking past each other on this point. Beyond being "not
elegant", I am not aware of Go dropping the support for calling C code.

I am not seeing how this isn't sustainable in the literal sense.


>
> It really depends on who does it I would guess. It's very probably a coup=
le
>> of months to get something that is bullet-proof and mergeable.
>>
>
> Is it on the roadmap for a future version of LTTng?
>

It's something we would like to support, but it isn't on the roadmap in the
short term, at least. This is not to say it can't be worked on.

J=C3=A9r=C3=A9mie


>
> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9crit=
 :
>
> On 29 May 2018 at 09:47, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:
>>
>> I agree that integrating C code into a Go codebase is somewhat inelegant=
.
>>>
>>>>
>>>>
>>> Not only that, but it's not sustainable. It is more a hack than a
>>> feature.
>>>
>>>
>>
>>
>>
>>> However, I'm not sure what you mean by "implementation issues that are
>>>
>>>> specific to the language itself".
>>>>
>>>>
>>> I mean that if you put static calls to C tracepoints from a Go program,
>>> you always have a function call (and the ~50ns overhead) triggered each
>>> time you hit the tracepoint, whether the tracepoint is actually enabled
>>> or
>>> not. So basically you can't count on the compiler (specific to the
>>> language) to do clever branch prediction for you, which reduces the
>>> interest of instrumenting your code.
>>>
>>>
>> In the case of the first solution, note that the agent tracks which even=
ts
>> are enabled or not. In that sense, the check is performed within the Go
>> code, as is currently done for Python and Java.
>>
>>
>>
>>> I like the third solution that you propose. I think that the first one =
is
>>> definitely not ideal and that the second one is too much work and
>>> maintaining. How much time do you estimate is necessary for the
>>> development
>>> of the third solution?
>>>
>>>
>>
>>
>>
>>> By the way, I am currently working on instrumenting the Go runtime to
>>> capture information on the goroutines. I am using dyntrace (
>>> https://github.com/charpercyr/dyntrace) for that, which kind of works
>>> but
>>> is really hacky.
>>>
>>>
>> That sounds great. What kind of information are you capturing?
>>
>> Thanks,
>> J=C3=A9r=C3=A9mie
>>
>>
>>
>>> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9cr=
it :
>>>
>>> On 28 May 2018 at 10:30, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:
>>>
>>>>
>>>> Hi Jeremie,
>>>>
>>>>>
>>>>> Thanks for your answer. I roughly estimated the overhead of calling a=
n
>>>>> empty C function (passing two integer arguments) from Go to 50ns per
>>>>> call.
>>>>> Maybe not a big deal for a lot of use cases, but more problematic if
>>>>> you
>>>>> want to trace performance-critical parts of Go like its runtime itsel=
f.
>>>>> The
>>>>> overhead could even be bigger when it involves passing strings or
>>>>> arrays
>>>>> that have different memory layouts in Golang and C. What was the
>>>>> overhead
>>>>> that you observed for Python and Java?
>>>>>
>>>>>
>>>>> 50ns per call doesn't sound too bad honestly.
>>>>
>>>> You have to ask yourself if you could get within 50ns of lttng-ust's
>>>> performance with a custom ring buffer implemented in Go.
>>>>
>>>> To use some very rough numbers, lttng-ust for that payload, takes arou=
nd
>>>> ~250ns per event. With Mathieu's work on restartable sequence, that
>>>> number
>>>> will be shaved off quite a bit (by half, if I remember correctly), and
>>>> I'm
>>>> not sure you'll be able to use that kind of mechanism from Go code.
>>>>
>>>> I don't have numbers on hand for Python and Java. In both cases, we ar=
e
>>>> hooking into logging frameworks so the overhead of calling into C code
>>>> probably pales in comparison to the time spent formatting strings.
>>>> That's another problem in using the current "agent" mechanism; it real=
ly
>>>> only accommodates a very specific tracepoint signature that takes a
>>>> string
>>>> payload.
>>>>
>>>>
>>>>
>>>> From what I understand, it will always be a problem to have agents for
>>>>> languages different than C, especially if you want to keep relying on
>>>>> existing C code. Even if the sessiond part is independant from the
>>>>> agent
>>>>> itself, there are tons of implementation issues that are specific to
>>>>> the
>>>>> language itself. The problem with Go is that calling C functions is
>>>>> really
>>>>> a hack that does not integrate well with the build system that was
>>>>> designed
>>>>> for Go.
>>>>>
>>>>>
>>>>>
>>>> The solutions I see:
>>>>
>>>> 1) Replicate the current "agent" scheme and serialize all Go events to
>>>> strings
>>>>
>>>> Not ideal as you lose the events' typing, you have to serialize to
>>>> strings
>>>> on the fast path, and you can hardly filter on event payloads.
>>>>
>>>> 2) Write a native Go ring-buffer that can be consumed by LTTng
>>>>
>>>> In essence, all the tracing would happen in Go. Events would be
>>>> serialized
>>>> by Go code and the Go "agent" would produce the CTF metadata that
>>>> describes
>>>> their layout.
>>>>
>>>> From an integration standpoint, that's probably the most elegant
>>>> solution
>>>> as you have no hard dependency on native code in your go projects.
>>>> However,
>>>> it's a _lot_ of work.
>>>>
>>>> First, you have to re-implement a ring-buffer that needs to perform
>>>> within
>>>> 50ns of lttng-ust's ring-buffer to be useful. You also need to port th=
e
>>>> event filtering bytecode interpreter to Go.
>>>> Then, we need to find a way to consume that ring-buffer's content from=
 a
>>>> form of consumer daemon within lttng-tools.
>>>>
>>>> 3) Add an lttng-ust API to allow dynamic event declaration
>>>>
>>>> This is something we have been considering for a while.
>>>>
>>>> Basically, we would like to introduce an API that allows applications =
to
>>>> dynamically declare tracepoints.
>>>> Then, those events would be serialized from Go, but the ring-buffer
>>>> logic
>>>> would remain in C.
>>>>
>>>> On each event, we would:
>>>>   - Obtain a memory area from lttng-ust (reserve phase, C code called
>>>> from
>>>> Go)
>>>>   - Write the event's content to that area (from Go code)
>>>>   - Commit the event (C code called from Go)
>>>>
>>>> With this, you don't have to manually declare tracepoints and integrat=
e
>>>> them into a build system to generate providers; the Go application jus=
t
>>>> needs to link to lttng-ust at runtime.
>>>> It's not a perfect solution, but it seems like an interesting
>>>> compromise.
>>>>
>>>>
>>>> What do you think?
>>>>
>>>> J=C3=A9r=C3=A9mie
>>>>
>>>>
>>>>
>>>>
>>>> Did I provide more context?
>>>>>
>>>>> Cheers,
>>>>> Lo=C3=AFc.
>>>>>
>>>>> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9=
crit :
>>>>>
>>>>> On 4 May 2018 at 06:03, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote=
:
>>>>>
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>>> There has been a previous discussion on the mailing list about
>>>>>>> porting
>>>>>>> LTTng to Golang, about a year ago: https://lists.lttng.org/
>>>>>>> pipermail/lttng-dev/2017-June/027203.html . This new topic is to
>>>>>>> discuss
>>>>>>>
>>>>>>> more precisely about implementation possibilities.
>>>>>>>
>>>>>>> Currently, one has to use the the C UST agent from LTTng in order t=
o
>>>>>>> instrument Golang programs, and to compile the whole thing using
>>>>>>> custom
>>>>>>> Makefiles and cgo. Here is a recent example that I wrote:
>>>>>>> https://github.com/loicgelle/jaeger-go-lttng-instr
>>>>>>>
>>>>>>> As you can guess, there are a low of drawbacks in that approach. It
>>>>>>> is
>>>>>>> actually a hack and cannot be integrated into more complex Golang
>>>>>>> program
>>>>>>> that use a more complex build process (e.g. the Golang runtime
>>>>>>> itself),
>>>>>>> because of the compiler instructions that you have to include at th=
e
>>>>>>> top
>>>>>>> of
>>>>>>> the Golang files. There is also a big concern about the performance
>>>>>>> of
>>>>>>> this
>>>>>>> solution, as calling a C function from Go requires to do a full
>>>>>>> context
>>>>>>> switch on the stack, because the calling conventions in C and Golan=
g
>>>>>>> are
>>>>>>> different.
>>>>>>>
>>>>>>>
>>>>>>> I think a more integrated and performant solution is needed. We can=
=E2=80=99t
>>>>>>>
>>>>>>
>>>>>> really ignore a language such as Golang that is now widely adopted f=
or
>>>>>>> cloud applications. LTTng is really the best solution out there in
>>>>>>> terms
>>>>>>> of
>>>>>>> overhead per tracepoint, and could benefit from being made availabl=
e
>>>>>>> to
>>>>>>> such a large community. My question to the experts on this mailing
>>>>>>> list:
>>>>>>> how much would it take to write a Golang agent for LTTng?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi Lo=C3=AFc,
>>>>>>
>>>>>> Without having performed any measurements myself, it does seem like
>>>>>> calling
>>>>>> C from Go is very expensive. In that context, I can see that LTTng
>>>>>> would
>>>>>> probably lose its performance advantage over any native Go solution.
>>>>>> However, it wouldn't hurt to measure the impact and see if it really
>>>>>> is
>>>>>> a
>>>>>> deal breaker.
>>>>>>
>>>>>> We faced the same dilemma when implementing the Java and Python
>>>>>> support
>>>>>> in
>>>>>> lttng-ust. In those cases, we ended up calling C code, with the
>>>>>> performance
>>>>>> penalties it implies. The correlation with other applications' and t=
he
>>>>>> kernel's events, along with the rest of LTTng's features, provided
>>>>>> enough
>>>>>> value to make that solution worthwhile.
>>>>>>
>>>>>> There aren't a ton of solutions if we can't call existing C code. We
>>>>>> basically have to reimplement a ring-buffer and the
>>>>>> setup/communication
>>>>>> infrastructure to interact with the lttng-sessiond. The communicatio=
n
>>>>>> with
>>>>>> the session daemon is not a big concern as the protocol is fairly
>>>>>> straightforward.
>>>>>>
>>>>>> The "hairy" part is that lttng-ust and lttng-consumerd use a shared
>>>>>> memory
>>>>>> map to produce and consume the tracing buffers. This means that all
>>>>>> changes
>>>>>> to that memory layout would need to be replicated in the Go tracer,
>>>>>> making
>>>>>> future evolution more difficult. Also, I don't know how easy it woul=
d
>>>>>> be
>>>>>> to
>>>>>> synchronize C and Go applications interacting in a shared memory map
>>>>>> given
>>>>>> those languages have different memory models. My knowledge of Go
>>>>>> doesn't
>>>>>> go
>>>>>> that far.
>>>>>>
>>>>>> A more viable solution could be to introduce a Go-native consumer
>>>>>> daemon
>>>>>> implementing its own synchronization with Go applications. This way,
>>>>>> that
>>>>>> implementation could evolve on its own and could also start with a
>>>>>> simpler
>>>>>> ring buffer than lttng-ust's.
>>>>>>
>>>>>> Still, it is not a small undertaking and it basically means
>>>>>> maintaining
>>>>>> a
>>>>>> third tracer implementation.
>>>>>>
>>>>>>
>>>>>> What do you think?
>>>>>>
>>>>>> Thanks!
>>>>>> J=C3=A9r=C3=A9mie
>>>>>>
>>>>>>
>>>>>> Cheers,
>>>>>>
>>>>>> Lo=C3=AFc.
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> lttng-dev mailing list
>>>>>>> lttng-dev@lists.lttng.org
>>>>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>>> EfficiOS Inc.
>>>>>> http://www.efficios.com
>>>>>>
>>>>>>
>>>>>>
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

--00000000000061e6d8056d5aa2e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 29 May 2018 at 10:32, Lo=C3=AFc Gelle <span dir=3D"ltr">&lt;<a href=
=3D"mailto:loic.gelle@polymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
I don&#39;t understand what you mean by &quot;not sustainable&quot;.<br>
</blockquote>
<br></span>
Not something you can keep in your codebase forever.<span class=3D""><br></=
span></blockquote><br></div><div class=3D"gmail_quote">I think we&#39;re ta=
lking past each other on this point. Beyond being &quot;not elegant&quot;, =
I am not aware of Go dropping the support for calling C code.</div><div cla=
ss=3D"gmail_quote"><br></div><div class=3D"gmail_quote">I am not seeing how=
 this isn&#39;t sustainable in the literal sense.<br><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><span class=3D"">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
It really depends on who does it I would guess. It&#39;s very probably a co=
uple<br>
of months to get something that is bullet-proof and mergeable.<br>
</blockquote>
<br></span>
Is it on the roadmap for a future version of LTTng?<span class=3D""><br></s=
pan></blockquote><div><br></div><div>It&#39;s something we would like to su=
pport, but it isn&#39;t on the roadmap in the short term, at least. This is=
 not to say it can&#39;t be worked on.</div><div><br></div><div>J=C3=A9r=C3=
=A9mie<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">
<br>
J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficio=
s.com" target=3D"_blank">jeremie.galarneau@efficios.co<wbr>m</a>&gt; a =C3=
=A9crit=C2=A0:<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">
On 29 May 2018 at 09:47, Lo=C3=AFc Gelle &lt;<a href=3D"mailto:loic.gelle@p=
olymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</a>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I agree that integrating C code into a Go codebase is somewhat inelegant.<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
</blockquote>
<br>
Not only that, but it&#39;s not sustainable. It is more a hack than a featu=
re.<br>
<br>
</blockquote>
<br>
<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br><span class=3D"">
However, I&#39;m not sure what you mean by &quot;implementation issues that=
 are<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
specific to the language itself&quot;.<br>
<br>
</blockquote>
<br>
I mean that if you put static calls to C tracepoints from a Go program,<br>
you always have a function call (and the ~50ns overhead) triggered each<br>
time you hit the tracepoint, whether the tracepoint is actually enabled or<=
br>
not. So basically you can&#39;t count on the compiler (specific to the<br>
language) to do clever branch prediction for you, which reduces the<br>
interest of instrumenting your code.<br>
<br>
</span></blockquote><span class=3D"">
<br>
In the case of the first solution, note that the agent tracks which events<=
br>
are enabled or not. In that sense, the check is performed within the Go<br>
code, as is currently done for Python and Java.<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
I like the third solution that you propose. I think that the first one is<b=
r>
definitely not ideal and that the second one is too much work and<br>
maintaining. How much time do you estimate is necessary for the development=
<br>
of the third solution?<br>
<br>
</blockquote>
<br>
<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br><div><div class=3D"h5">
By the way, I am currently working on instrumenting the Go runtime to<br>
capture information on the goroutines. I am using dyntrace (<br>
<a href=3D"https://github.com/charpercyr/dyntrace" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/charpercyr/<wbr>dyntrace</a>) for that, whi=
ch kind of works but<br>
is really hacky.<br>
<br>
</div></div></blockquote><div><div class=3D"h5">
<br>
That sounds great. What kind of information are you capturing?<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficio=
s.com" target=3D"_blank">jeremie.galarneau@efficios.co<wbr>m</a>&gt; a =C3=
=A9crit :<br>
<br>
On 28 May 2018 at 10:30, Lo=C3=AFc Gelle &lt;<a href=3D"mailto:loic.gelle@p=
olymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Hi Jeremie,<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Thanks for your answer. I roughly estimated the overhead of calling an<br>
empty C function (passing two integer arguments) from Go to 50ns per<br>
call.<br>
Maybe not a big deal for a lot of use cases, but more problematic if you<br=
>
want to trace performance-critical parts of Go like its runtime itself.<br>
The<br>
overhead could even be bigger when it involves passing strings or arrays<br=
>
that have different memory layouts in Golang and C. What was the overhead<b=
r>
that you observed for Python and Java?<br>
<br>
<br>
</blockquote>
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
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From what I understand, it will always be a problem to have agents for<br>
languages different than C, especially if you want to keep relying on<br>
existing C code. Even if the sessiond part is independant from the agent<br=
>
itself, there are tons of implementation issues that are specific to the<br=
>
language itself. The problem with Go is that calling C functions is<br>
really<br>
a hack that does not integrate well with the build system that was<br>
designed<br>
for Go.<br>
<br>
<br>
</blockquote>
<br>
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
<br>
describes<br>
their layout.<br>
<br>
From an integration standpoint, that&#39;s probably the most elegant soluti=
on<br>
as you have no hard dependency on native code in your go projects.<br>
However,<br>
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
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
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
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Hi,<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
There has been a previous discussion on the mailing list about porting<br>
LTTng to Golang, about a year ago: <a href=3D"https://lists.lttng.org/" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/</a><br>
pipermail/lttng-dev/2017-June/<wbr>027203.html . This new topic is to<br>
discuss<br>
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
actually a hack and cannot be integrated into more complex Golang<br>
program<br>
that use a more complex build process (e.g. the Golang runtime itself),<br>
because of the compiler instructions that you have to include at the<br>
top<br>
of<br>
the Golang files. There is also a big concern about the performance of<br>
this<br>
solution, as calling a C function from Go requires to do a full context<br>
switch on the stack, because the calling conventions in C and Golang<br>
are<br>
different.<br>
<br>
<br>
I think a more integrated and performant solution is needed. We can=E2=80=
=99t<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
really ignore a language such as Golang that is now widely adopted for<br>
cloud applications. LTTng is really the best solution out there in<br>
terms<br>
of<br>
overhead per tracepoint, and could benefit from being made available to<br>
such a large community. My question to the experts on this mailing<br>
list:<br>
how much would it take to write a Golang agent for LTTng?<br>
<br>
<br>
<br>
</blockquote>
Hi Lo=C3=AFc,<br>
<br>
Without having performed any measurements myself, it does seem like<br>
calling<br>
C from Go is very expensive. In that context, I can see that LTTng would<br=
>
probably lose its performance advantage over any native Go solution.<br>
However, it wouldn&#39;t hurt to measure the impact and see if it really is=
<br>
a<br>
deal breaker.<br>
<br>
We faced the same dilemma when implementing the Java and Python support<br>
in<br>
lttng-ust. In those cases, we ended up calling C code, with the<br>
performance<br>
penalties it implies. The correlation with other applications&#39; and the<=
br>
kernel&#39;s events, along with the rest of LTTng&#39;s features, provided<=
br>
enough<br>
value to make that solution worthwhile.<br>
<br>
There aren&#39;t a ton of solutions if we can&#39;t call existing C code. W=
e<br>
basically have to reimplement a ring-buffer and the setup/communication<br>
infrastructure to interact with the lttng-sessiond. The communication<br>
with<br>
the session daemon is not a big concern as the protocol is fairly<br>
straightforward.<br>
<br>
The &quot;hairy&quot; part is that lttng-ust and lttng-consumerd use a shar=
ed<br>
memory<br>
map to produce and consume the tracing buffers. This means that all<br>
changes<br>
to that memory layout would need to be replicated in the Go tracer,<br>
making<br>
future evolution more difficult. Also, I don&#39;t know how easy it would b=
e<br>
to<br>
synchronize C and Go applications interacting in a shared memory map<br>
given<br>
those languages have different memory models. My knowledge of Go doesn&#39;=
t<br>
go<br>
that far.<br>
<br>
A more viable solution could be to introduce a Go-native consumer daemon<br=
>
implementing its own synchronization with Go applications. This way,<br>
that<br>
implementation could evolve on its own and could also start with a<br>
simpler<br>
ring buffer than lttng-ust&#39;s.<br>
<br>
Still, it is not a small undertaking and it basically means maintaining<br>
a<br>
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
<br>
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
<br>
</blockquote>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
<br>
<br>
</blockquote>
<br>
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

--00000000000061e6d8056d5aa2e4--

--===============5249604981487451576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5249604981487451576==--
