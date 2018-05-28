From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Golang agent for LTTng-ust
Date: Mon, 28 May 2018 11:49:34 -0400
Message-ID: <CA+jJMxsHLZ+KpdCewhC7fmgyaAHW5w4XeaXVtzB=PRg0-nesZQ__43895.309608388$1527522482$gmane$org@mail.gmail.com>
References: <29167624-BBCE-401B-8FD9-6DFEB14D3E0E@polymtl.ca>
 <CA+jJMxtUh1dA=KcVSLSfdFQnRxC905X-omh=uObgxNNpPgbtXw@mail.gmail.com>
 <20180528143056.Horde.mM3dXk9t6dVCD9zEbiuPwFi@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5590608150854127169=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40vhBZ4GH9zpHW
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 11:49:58 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E75F31BBCA8
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 11:49:57 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id L815mVWX8zZO for <lttng-dev@lists.lttng.org>;
 Mon, 28 May 2018 11:49:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E3B321BBC8A
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 11:49:56 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id aOfXHiyYEUuD for <lttng-dev@lists.lttng.org>;
 Mon, 28 May 2018 11:49:56 -0400 (EDT)
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by mail.efficios.com (Postfix) with ESMTPSA id 767FB1BBC68
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 11:49:56 -0400 (EDT)
Received: by mail-wm0-f51.google.com with SMTP id x2-v6so25814945wmh.5
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 08:49:56 -0700 (PDT)
In-Reply-To: <20180528143056.Horde.mM3dXk9t6dVCD9zEbiuPwFi@www.imp.polymtl.ca>
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

--===============5590608150854127169==
Content-Type: multipart/alternative; boundary="000000000000ac47aa056d4611af"

--000000000000ac47aa056d4611af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 May 2018 at 10:30, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:

> Hi Jeremie,
>
> Thanks for your answer. I roughly estimated the overhead of calling an
> empty C function (passing two integer arguments) from Go to 50ns per call=
.
> Maybe not a big deal for a lot of use cases, but more problematic if you
> want to trace performance-critical parts of Go like its runtime itself. T=
he
> overhead could even be bigger when it involves passing strings or arrays
> that have different memory layouts in Golang and C. What was the overhead
> that you observed for Python and Java?
>

50ns per call doesn't sound too bad honestly.

You have to ask yourself if you could get within 50ns of lttng-ust's
performance with a custom ring buffer implemented in Go.

To use some very rough numbers, lttng-ust for that payload, takes around
~250ns per event. With Mathieu's work on restartable sequence, that number
will be shaved off quite a bit (by half, if I remember correctly), and I'm
not sure you'll be able to use that kind of mechanism from Go code.

I don't have numbers on hand for Python and Java. In both cases, we are
hooking into logging frameworks so the overhead of calling into C code
probably pales in comparison to the time spent formatting strings.
That's another problem in using the current "agent" mechanism; it really
only accommodates a very specific tracepoint signature that takes a string
payload.


>
> From what I understand, it will always be a problem to have agents for
> languages different than C, especially if you want to keep relying on
> existing C code. Even if the sessiond part is independant from the agent
> itself, there are tons of implementation issues that are specific to the
> language itself. The problem with Go is that calling C functions is reall=
y
> a hack that does not integrate well with the build system that was design=
ed
> for Go.
>

I agree that integrating C code into a Go codebase is somewhat inelegant.
However, I'm not sure what you mean by "implementation issues that are
specific to the language itself".

The solutions I see:

1) Replicate the current "agent" scheme and serialize all Go events to
strings

Not ideal as you lose the events' typing, you have to serialize to strings
on the fast path, and you can hardly filter on event payloads.

2) Write a native Go ring-buffer that can be consumed by LTTng

In essence, all the tracing would happen in Go. Events would be serialized
by Go code and the Go "agent" would produce the CTF metadata that describes
their layout.

From an integration standpoint, that's probably the most elegant solution
as you have no hard dependency on native code in your go projects. However,
it's a _lot_ of work.

First, you have to re-implement a ring-buffer that needs to perform within
50ns of lttng-ust's ring-buffer to be useful. You also need to port the
event filtering bytecode interpreter to Go.
Then, we need to find a way to consume that ring-buffer's content from a
form of consumer daemon within lttng-tools.

3) Add an lttng-ust API to allow dynamic event declaration

This is something we have been considering for a while.

Basically, we would like to introduce an API that allows applications to
dynamically declare tracepoints.
Then, those events would be serialized from Go, but the ring-buffer logic
would remain in C.

On each event, we would:
  - Obtain a memory area from lttng-ust (reserve phase, C code called from
Go)
  - Write the event's content to that area (from Go code)
  - Commit the event (C code called from Go)

With this, you don't have to manually declare tracepoints and integrate
them into a build system to generate providers; the Go application just
needs to link to lttng-ust at runtime.
It's not a perfect solution, but it seems like an interesting compromise.


What do you think?

J=C3=A9r=C3=A9mie



>
> Did I provide more context?
>
> Cheers,
> Lo=C3=AFc.
>
> J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com> a =C3=A9crit=
 :
>
> On 4 May 2018 at 06:03, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:
>>
>> Hi,
>>>
>>> There has been a previous discussion on the mailing list about porting
>>> LTTng to Golang, about a year ago: https://lists.lttng.org/
>>> pipermail/lttng-dev/2017-June/027203.html . This new topic is to discus=
s
>>>
>>> more precisely about implementation possibilities.
>>>
>>> Currently, one has to use the the C UST agent from LTTng in order to
>>> instrument Golang programs, and to compile the whole thing using custom
>>> Makefiles and cgo. Here is a recent example that I wrote:
>>> https://github.com/loicgelle/jaeger-go-lttng-instr
>>>
>>> As you can guess, there are a low of drawbacks in that approach. It is
>>> actually a hack and cannot be integrated into more complex Golang progr=
am
>>> that use a more complex build process (e.g. the Golang runtime itself),
>>> because of the compiler instructions that you have to include at the to=
p
>>> of
>>> the Golang files. There is also a big concern about the performance of
>>> this
>>> solution, as calling a C function from Go requires to do a full context
>>> switch on the stack, because the calling conventions in C and Golang ar=
e
>>> different.
>>>
>>>
>> I think a more integrated and performant solution is needed. We can=E2=
=80=99t
>>> really ignore a language such as Golang that is now widely adopted for
>>> cloud applications. LTTng is really the best solution out there in term=
s
>>> of
>>> overhead per tracepoint, and could benefit from being made available to
>>> such a large community. My question to the experts on this mailing list=
:
>>> how much would it take to write a Golang agent for LTTng?
>>>
>>>
>>
>> Hi Lo=C3=AFc,
>>
>> Without having performed any measurements myself, it does seem like
>> calling
>> C from Go is very expensive. In that context, I can see that LTTng would
>> probably lose its performance advantage over any native Go solution.
>> However, it wouldn't hurt to measure the impact and see if it really is =
a
>> deal breaker.
>>
>> We faced the same dilemma when implementing the Java and Python support =
in
>> lttng-ust. In those cases, we ended up calling C code, with the
>> performance
>> penalties it implies. The correlation with other applications' and the
>> kernel's events, along with the rest of LTTng's features, provided enoug=
h
>> value to make that solution worthwhile.
>>
>> There aren't a ton of solutions if we can't call existing C code. We
>> basically have to reimplement a ring-buffer and the setup/communication
>> infrastructure to interact with the lttng-sessiond. The communication wi=
th
>> the session daemon is not a big concern as the protocol is fairly
>> straightforward.
>>
>> The "hairy" part is that lttng-ust and lttng-consumerd use a shared memo=
ry
>> map to produce and consume the tracing buffers. This means that all
>> changes
>> to that memory layout would need to be replicated in the Go tracer, maki=
ng
>> future evolution more difficult. Also, I don't know how easy it would be
>> to
>> synchronize C and Go applications interacting in a shared memory map giv=
en
>> those languages have different memory models. My knowledge of Go doesn't
>> go
>> that far.
>>
>> A more viable solution could be to introduce a Go-native consumer daemon
>> implementing its own synchronization with Go applications. This way, tha=
t
>> implementation could evolve on its own and could also start with a simpl=
er
>> ring buffer than lttng-ust's.
>>
>> Still, it is not a small undertaking and it basically means maintaining =
a
>> third tracer implementation.
>>
>>
>> What do you think?
>>
>> Thanks!
>> J=C3=A9r=C3=A9mie
>>
>>
>> Cheers,
>>> Lo=C3=AFc.
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
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

--000000000000ac47aa056d4611af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 28 May 2018 at 10:30, Lo=C3=AFc Gelle <span dir=3D"ltr">&lt;<a href=
=3D"mailto:loic.gelle@polymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Jeremie,<br>
<br>
Thanks for your answer. I roughly estimated the overhead of calling an empt=
y C function (passing two integer arguments) from Go to 50ns per call. Mayb=
e not a big deal for a lot of use cases, but more problematic if you want t=
o trace performance-critical parts of Go like its runtime itself. The overh=
ead could even be bigger when it involves passing strings or arrays that ha=
ve different memory layouts in Golang and C. What was the overhead that you=
 observed for Python and Java?<br></blockquote><div><br></div><div>50ns per=
 call doesn&#39;t sound too bad honestly.</div><div><br></div><div>You have=
 to ask yourself if you could get within 50ns of lttng-ust&#39;s performanc=
e with a custom ring buffer implemented in Go.</div><div><br></div><div>To =
use some very rough numbers, lttng-ust for that payload, takes around ~250n=
s per event. With Mathieu&#39;s work on restartable sequence, that number w=
ill be shaved off quite a bit (by half, if I remember correctly), and I&#39=
;m not sure you&#39;ll be able to use that kind of mechanism from Go code.<=
br></div><div><br></div><div>I don&#39;t have numbers on hand for Python an=
d Java. In both cases, we are hooking into logging frameworks so the overhe=
ad of calling into C code probably pales in comparison to the time spent fo=
rmatting strings.</div><div>That&#39;s another problem in using the current=
 &quot;agent&quot; mechanism; it really only accommodates a very specific t=
racepoint signature that takes a string payload.<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
From what I understand, it will always be a problem to have agents for lang=
uages different than C, especially if you want to keep relying on existing =
C code. Even if the sessiond part is independant from the agent itself, the=
re are tons of implementation issues that are specific to the language itse=
lf. The problem with Go is that calling C functions is really a hack that d=
oes not integrate well with the build system that was designed for Go.<br><=
/blockquote><div><br></div><div>I agree that integrating C code into a Go c=
odebase is somewhat inelegant. However, I&#39;m not sure what you mean by &=
quot;implementation issues that are specific to the language itself&quot;.<=
/div></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">=
The solutions I see:</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">1) Replicate the current &quot;agent&quot; scheme and seri=
alize all Go events to strings</div><div class=3D"gmail_quote"><br></div><d=
iv class=3D"gmail_quote">Not ideal as you lose the events&#39; typing, you =
have to serialize to strings on the fast path, and you can hardly filter on=
 event payloads.<br></div><div class=3D"gmail_quote"><br></div>2) Write a n=
ative Go ring-buffer that can be consumed by LTTng</div><div class=3D"gmail=
_extra"><br></div><div class=3D"gmail_extra">In essence, all the tracing wo=
uld happen in Go. Events would be serialized by Go code and the Go &quot;ag=
ent&quot; would produce the CTF metadata that describes their layout.<br></=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">From an=
 integration standpoint, that&#39;s probably the most elegant solution as y=
ou have no hard dependency on native code in your go projects. However, it&=
#39;s a _lot_ of work.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">First, you have to re-implement a ring-buffer that needs t=
o perform within 50ns of lttng-ust&#39;s ring-buffer to be useful. You also=
 need to port the event filtering bytecode interpreter to Go.</div><div cla=
ss=3D"gmail_extra">Then, we need to find a way to consume that ring-buffer&=
#39;s content from a form of consumer daemon within lttng-tools.</div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">3) Add an lttng-=
ust API to allow dynamic event declaration</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra">This is something we have been conside=
ring for a while.</div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">Basically, we would like to introduce an API that allows applic=
ations to dynamically declare tracepoints.</div><div class=3D"gmail_extra">=
</div><div>Then, those events would be serialized from Go, but the ring-buf=
fer logic would remain in C.</div><div><br></div><div>On each event, we wou=
ld:</div><div>=C2=A0 - Obtain a memory area from lttng-ust (reserve phase, =
C code called from Go)<br></div><div>=C2=A0 - Write the event&#39;s content=
 to that area (from Go code)</div><div>=C2=A0 - Commit the event (C code ca=
lled from Go)<br></div><div><br></div><div>With this, you don&#39;t have to=
 manually declare tracepoints and integrate them into a build system to gen=
erate providers; the Go application just needs to link to lttng-ust at runt=
ime.</div><div>It&#39;s not a perfect solution, but it seems like an intere=
sting compromise.<br></div><div><div class=3D"gmail_extra"><br></div><div c=
lass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">What do you think=
?<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
J=C3=A9r=C3=A9mie<br></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Did I provide more context?<br>
<br>
Cheers,<br>
Lo=C3=AFc.<br>
<br>
J=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficio=
s.com" target=3D"_blank">jeremie.galarneau@efficios.co<wbr>m</a>&gt; a =C3=
=A9crit=C2=A0:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">
On 4 May 2018 at 06:03, Lo=C3=AFc Gelle &lt;<a href=3D"mailto:loic.gelle@po=
lymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</a>&gt; wrote:<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">
Hi,<br>
<br>
There has been a previous discussion on the mailing list about porting<br>
LTTng to Golang, about a year ago: <a href=3D"https://lists.lttng.org/" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/</a><br></span>
pipermail/lttng-dev/2017-June/<wbr>027203.html . This new topic is to discu=
ss<div><div class=3D"h5"><br>
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
because of the compiler instructions that you have to include at the top of=
<br>
the Golang files. There is also a big concern about the performance of this=
<br>
solution, as calling a C function from Go requires to do a full context<br>
switch on the stack, because the calling conventions in C and Golang are<br=
>
different.<br>
<br>
</div></div></blockquote><div><div class=3D"h5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I think a more integrated and performant solution is needed. We can=E2=80=
=99t<br>
really ignore a language such as Golang that is now widely adopted for<br>
cloud applications. LTTng is really the best solution out there in terms of=
<br>
overhead per tracepoint, and could benefit from being made available to<br>
such a large community. My question to the experts on this mailing list:<br=
>
how much would it take to write a Golang agent for LTTng?<br>
<br>
</blockquote>
<br>
<br>
Hi Lo=C3=AFc,<br>
<br>
Without having performed any measurements myself, it does seem like calling=
<br>
C from Go is very expensive. In that context, I can see that LTTng would<br=
>
probably lose its performance advantage over any native Go solution.<br>
However, it wouldn&#39;t hurt to measure the impact and see if it really is=
 a<br>
deal breaker.<br>
<br>
We faced the same dilemma when implementing the Java and Python support in<=
br>
lttng-ust. In those cases, we ended up calling C code, with the performance=
<br>
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
map to produce and consume the tracing buffers. This means that all changes=
<br>
to that memory layout would need to be replicated in the Go tracer, making<=
br>
future evolution more difficult. Also, I don&#39;t know how easy it would b=
e to<br>
synchronize C and Go applications interacting in a shared memory map given<=
br>
those languages have different memory models. My knowledge of Go doesn&#39;=
t go<br>
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
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Cheers,<br>
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
</div></div></div>

--000000000000ac47aa056d4611af--

--===============5590608150854127169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5590608150854127169==--
