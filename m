From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Golang agent for LTTng-ust
Date: Mon, 28 May 2018 03:26:50 -0400
Message-ID: <CA+jJMxtUh1dA=KcVSLSfdFQnRxC905X-omh=uObgxNNpPgbtXw__31797.0850774602$1527492317$gmane$org@mail.gmail.com>
References: <29167624-BBCE-401B-8FD9-6DFEB14D3E0E@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8287240338448397824=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40vT2V55nVznXk
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 03:27:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 85E771B99DD
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 03:27:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id ionl8zhS2sqA for <lttng-dev@lists.lttng.org>;
 Mon, 28 May 2018 03:27:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id AE6141B99D3
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 03:27:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id VlNc6JA4RWOR for <lttng-dev@lists.lttng.org>;
 Mon, 28 May 2018 03:27:12 -0400 (EDT)
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
 [209.85.128.177])
 by mail.efficios.com (Postfix) with ESMTPSA id 439001B999E
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 03:27:12 -0400 (EDT)
Received: by mail-wr0-f177.google.com with SMTP id w3-v6so18562676wrl.12
 for <lttng-dev@lists.lttng.org>; Mon, 28 May 2018 00:27:12 -0700 (PDT)
In-Reply-To: <29167624-BBCE-401B-8FD9-6DFEB14D3E0E@polymtl.ca>
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

--===============8287240338448397824==
Content-Type: multipart/alternative; boundary="000000000000c00887056d3f0b13"

--000000000000c00887056d3f0b13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4 May 2018 at 06:03, Lo=C3=AFc Gelle <loic.gelle@polymtl.ca> wrote:

> Hi,
>
> There has been a previous discussion on the mailing list about porting
> LTTng to Golang, about a year ago: https://lists.lttng.org/
> pipermail/lttng-dev/2017-June/027203.html . This new topic is to discuss
> more precisely about implementation possibilities.
>
> Currently, one has to use the the C UST agent from LTTng in order to
> instrument Golang programs, and to compile the whole thing using custom
> Makefiles and cgo. Here is a recent example that I wrote:
> https://github.com/loicgelle/jaeger-go-lttng-instr
>
> As you can guess, there are a low of drawbacks in that approach. It is
> actually a hack and cannot be integrated into more complex Golang program
> that use a more complex build process (e.g. the Golang runtime itself),
> because of the compiler instructions that you have to include at the top =
of
> the Golang files. There is also a big concern about the performance of th=
is
> solution, as calling a C function from Go requires to do a full context
> switch on the stack, because the calling conventions in C and Golang are
> different.
>

> I think a more integrated and performant solution is needed. We can=E2=80=
=99t
> really ignore a language such as Golang that is now widely adopted for
> cloud applications. LTTng is really the best solution out there in terms =
of
> overhead per tracepoint, and could benefit from being made available to
> such a large community. My question to the experts on this mailing list:
> how much would it take to write a Golang agent for LTTng?
>


Hi Lo=C3=AFc,

Without having performed any measurements myself, it does seem like calling
C from Go is very expensive. In that context, I can see that LTTng would
probably lose its performance advantage over any native Go solution.
However, it wouldn't hurt to measure the impact and see if it really is a
deal breaker.

We faced the same dilemma when implementing the Java and Python support in
lttng-ust. In those cases, we ended up calling C code, with the performance
penalties it implies. The correlation with other applications' and the
kernel's events, along with the rest of LTTng's features, provided enough
value to make that solution worthwhile.

There aren't a ton of solutions if we can't call existing C code. We
basically have to reimplement a ring-buffer and the setup/communication
infrastructure to interact with the lttng-sessiond. The communication with
the session daemon is not a big concern as the protocol is fairly
straightforward.

The "hairy" part is that lttng-ust and lttng-consumerd use a shared memory
map to produce and consume the tracing buffers. This means that all changes
to that memory layout would need to be replicated in the Go tracer, making
future evolution more difficult. Also, I don't know how easy it would be to
synchronize C and Go applications interacting in a shared memory map given
those languages have different memory models. My knowledge of Go doesn't go
that far.

A more viable solution could be to introduce a Go-native consumer daemon
implementing its own synchronization with Go applications. This way, that
implementation could evolve on its own and could also start with a simpler
ring buffer than lttng-ust's.

Still, it is not a small undertaking and it basically means maintaining a
third tracer implementation.


What do you think?

Thanks!
J=C3=A9r=C3=A9mie


> Cheers,
> Lo=C3=AFc.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000c00887056d3f0b13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 4 May 2018 at 06:03, Lo=C3=AFc Gelle <span dir=3D"ltr">&lt;<a href=
=3D"mailto:loic.gelle@polymtl.ca" target=3D"_blank">loic.gelle@polymtl.ca</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div style=3D"word-w=
rap:break-word;line-break:after-white-space">Hi,<div><br></div><div>There h=
as been a previous discussion on the mailing list about porting LTTng to Go=
lang, about a year ago:=C2=A0<a href=3D"https://lists.lttng.org/pipermail/l=
ttng-dev/2017-June/027203.html" target=3D"_blank">https://lists.lttng.org/<=
wbr>pipermail/lttng-dev/2017-June/<wbr>027203.html</a>=C2=A0.=C2=A0This new=
 topic is to discuss more precisely about implementation possibilities.</di=
v><div><br></div><div>Currently, one has to use the the C UST agent from LT=
Tng in order to instrument Golang programs, and to compile the whole thing =
using custom Makefiles and cgo. Here is a recent example that I wrote:=C2=
=A0<a href=3D"https://github.com/loicgelle/jaeger-go-lttng-instr" target=3D=
"_blank">https://github.com/<wbr>loicgelle/jaeger-go-lttng-<wbr>instr</a></=
div><div><br></div><div>As you can guess, there are a low of drawbacks in t=
hat approach. It is actually a hack and cannot be integrated into more comp=
lex Golang program that use a more complex build process (e.g. the Golang r=
untime itself), because of the compiler instructions that you have to inclu=
de at the top of the Golang files. There is also a big concern about the pe=
rformance of this solution, as calling a C function from Go requires to do =
a full context switch on the stack, because the calling conventions in C an=
d Golang are different.</div></div></blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div style=3D"word-wrap:break-word;line-break:after-white-space"><div><=
br></div><div>I think a more integrated and performant solution is needed. =
We can=E2=80=99t really ignore a language such as Golang that is now widely=
 adopted for cloud applications. LTTng is really the best solution out ther=
e in terms of overhead per tracepoint, and could benefit from being made av=
ailable to such a large community. My question to the experts on this maili=
ng list: how much would it take to write a Golang agent for LTTng?</div></d=
iv></blockquote><div><br></div><div><div><br></div><div>Hi Lo=C3=AFc,</div>=
<div><br></div><div>Without having performed any measurements myself, it do=
es seem like calling C from Go is very expensive. In that context, I can se=
e that LTTng would probably lose its performance advantage over any native =
Go solution. However, it wouldn&#39;t hurt to measure the impact and see if=
 it really is a deal breaker.<br></div><div><br></div><div><div>We faced th=
e same dilemma when implementing the Java
 and Python support in lttng-ust. In those cases, we ended up calling C=20
code, with the performance penalties it implies. The correlation with=20
other applications&#39; and the kernel&#39;s events, along with the rest of=
 LTTng&#39;s features, provided enough value to=20
make that solution worthwhile.<br></div><div><br></div></div><div>There are=
n&#39;t a ton of solutions if we can&#39;t call existing C code. We basical=
ly have to reimplement a ring-buffer and the setup/communication infrastruc=
ture to interact with the lttng-sessiond. The communication with the sessio=
n daemon is not a big concern as the protocol is fairly straightforward.</d=
iv><div><br></div><div>The &quot;hairy&quot; part is that lttng-ust and ltt=
ng-consumerd use a shared memory map to produce and consume the tracing buf=
fers. This means that all changes to that memory layout would need to be re=
plicated in the Go tracer, making future evolution more difficult. Also, I =
don&#39;t know how easy it would be to synchronize C and Go applications in=
teracting in a shared memory map given those languages have different memor=
y models. My knowledge of Go doesn&#39;t go that far.<br></div><div><br></d=
iv><div>A more viable solution could be to introduce a Go-native consumer d=
aemon implementing its own synchronization with Go applications. This way, =
that implementation could evolve on its own and could also start with a sim=
pler ring buffer than lttng-ust&#39;s.<br></div><div></div><div><br></div><=
div>Still, it is not a small undertaking and it basically means maintaining=
 a third tracer implementation.<br></div></div><div></div><div><br></div><d=
iv><br></div><div>What do you think?<br></div><div><br></div><div>Thanks!<b=
r></div><div>J=C3=A9r=C3=A9mie<br></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div style=3D"word-wrap:break-word;line-break:after-white-space"=
><div><br></div><div>Cheers,</div><div>Lo=C3=AFc.</div></div><br>__________=
____________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<=
br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">h=
ttp://www.efficios.com</a></div>
</div></div>

--000000000000c00887056d3f0b13--

--===============8287240338448397824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8287240338448397824==--
