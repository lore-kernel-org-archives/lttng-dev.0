From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracing network events in the kernel using lttng
Date: Fri, 12 Aug 2016 20:41:45 +0000 (UTC)
Message-ID: <1729632151.9416.1471034505021.JavaMail.zimbra__47470.7374735319$1471034517$gmane$org@efficios.com>
References: <CAFMzwX6csrXt6aQwy0b7oW7CzfEKRr28uXYZcE4NhPrOWyCr4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4491335953373007523=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4C435A2B0E
 for <lttng-dev@lists.lttng.org>; Fri, 12 Aug 2016 20:41:46 +0000 (UTC)
In-Reply-To: <CAFMzwX6csrXt6aQwy0b7oW7CzfEKRr28uXYZcE4NhPrOWyCr4g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Adel Belkhiri <adel.belkhiri@ensi-uma.tn>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4491335953373007523==
Content-Type: multipart/alternative;
	boundary="=_9e7480f2-b7e8-46e3-82d5-795d7363884b"

--=_9e7480f2-b7e8-46e3-82d5-795d7363884b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Aug 12, 2016, at 12:50 AM, Adel Belkhiri <adel.belkhiri@ensi-uma.t=
n> wrote:=20

> Hello,

> I'm, from some time, working on tracing linux kernel using lttng to get s=
ome
> information about the system' network activities. Tracing bare system cal=
ls
> (--syscall) didn't give me much information so I realized that i should f=
irst
> place some static probes in the kernel source files to be able to trace
> (mainly) TCP socket operations (bind, accept, create, ...). Running out o=
f time
> in my project, I wonder if there are any patch for the kernel that place =
those
> probes in the right source files.

> My linux Kernel version is 3.2.0-4-486 and I'm using Lttng 2.7.

You'll be interested in recent commits that made their way into lttng=20
master branch:=20

At the networking level:=20

commit e5990fd415d46da69523dfe7943bc3168664fde8=20
Author: Genevi=C3=A8ve Bastien <gbastien+lttng@versatic.net>=20
Date: Mon Jul 11 09:34:02 2016 -0400=20

net: Add IPv4/IPv6 header data to net_* tracepoints=20

commit 9cf9736a1715a1fec4857fac2784a12596675ce2=20
Author: Genevi=C3=A8ve Bastien <gbastien+lttng@versatic.net>=20
Date: Tue Jul 12 13:26:14 2016 -0400=20

net: Add TCP header data to net_* tracepoints=20

and for the accept and connect syscalls (in stable-2.8 and=20
master):=20

commit 7ca580f8aca4f8c2b9e0066ad52ebfc226b3d645=20
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Date: Thu Jul 24 12:47:46 2014 -0400=20

Extract input/output arguments from accept and connect syscalls=20

This is all you should need to extract the kind of information you=20
want. Perhaps we should add other specialized system call=20
tracepoint probe functions to get more information about the=20
arguments, but it should not require any kernel modification nor=20
dynamic probing.=20

Hoping this helps!=20

Mathieu=20

> Thank very much you for your help.

> Adel Belkhiri

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_9e7480f2-b7e8-46e3-82d5-795d7363884b
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Aug 12, 2016, at 12:50 AM, Adel Belkhiri &lt;adel.belkhiri@ens=
i-uma.tn&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><=
span style=3D"font-family: arial,helvetica,sans-serif;" data-mce-style=3D"f=
ont-family: arial,helvetica,sans-serif;" face=3D"arial, helvetica, sans-ser=
if">Hello,</span><div><span style=3D"font-family: arial,helvetica,sans-seri=
f;" data-mce-style=3D"font-family: arial,helvetica,sans-serif;" face=3D"ari=
al, helvetica, sans-serif"><br></span></div><div><span style=3D"font-family=
: arial,helvetica,sans-serif;" data-mce-style=3D"font-family: arial,helveti=
ca,sans-serif;" face=3D"arial, helvetica, sans-serif"><br></span></div><div=
><span style=3D"font-family: arial,helvetica,sans-serif;" data-mce-style=3D=
"font-family: arial,helvetica,sans-serif;" face=3D"arial, helvetica, sans-s=
erif">I'm, from some time, working on tracing linux kernel using lttng to g=
et some information about the system' network activities.&nbsp;Tracing bare=
 system calls (--syscall) didn't give me much information so I realized tha=
t i should first place some static probes in the kernel source files to be =
able to trace (mainly) <b>TCP socket operations</b> (bind, accept, create, =
...). Running out of time in my project, I wonder if there are <b>any patch=
 for the kernel</b> that place those probes in the right source files.&nbsp=
;</span></div><div><span style=3D"font-family: arial,helvetica,sans-serif;"=
 data-mce-style=3D"font-family: arial,helvetica,sans-serif;" face=3D"arial,=
 helvetica, sans-serif"><br></span></div><div><span style=3D"font-family: a=
rial,helvetica,sans-serif;" data-mce-style=3D"font-family: arial,helvetica,=
sans-serif;" face=3D"arial, helvetica, sans-serif">My linux Kernel version =
is&nbsp;3.2.0-4-486 and I'm using Lttng 2.7.</span></div></div></blockquote=
><div><br></div><div>You'll be interested in recent commits that made their=
 way into lttng</div><div>master branch:<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>At the networking level:<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>commit e5990fd415=
d46da69523dfe7943bc3168664fde8<br>Author: Genevi=C3=A8ve Bastien &lt;gbasti=
en+lttng@versatic.net&gt;<br>Date:&nbsp;&nbsp; Mon Jul 11 09:34:02 2016 -04=
00<br><br>&nbsp;&nbsp;&nbsp; net: Add IPv4/IPv6 header data to net_* tracep=
oints<br><br data-mce-bogus=3D"1"></div><div>commit 9cf9736a1715a1fec4857fa=
c2784a12596675ce2<br>Author: Genevi=C3=A8ve Bastien &lt;gbastien+lttng@vers=
atic.net&gt;<br>Date:&nbsp;&nbsp; Tue Jul 12 13:26:14 2016 -0400<br><br>&nb=
sp;&nbsp;&nbsp; net: Add TCP header data to net_* tracepoints<br><br data-m=
ce-bogus=3D"1"></div><div>and for the accept and connect syscalls (in stabl=
e-2.8 and<br data-mce-bogus=3D"1"></div><div>master):<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>commit 7ca580f8aca4f8c2b9=
e0066ad52ebfc226b3d645<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@e=
fficios.com&gt;<br>Date:&nbsp;&nbsp; Thu Jul 24 12:47:46 2014 -0400<br><br>=
&nbsp;&nbsp;&nbsp; Extract input/output arguments from accept and connect s=
yscalls<br><br data-mce-bogus=3D"1"></div><div>This is all you should need =
to extract the kind of information you<br data-mce-bogus=3D"1"></div><div>w=
ant. Perhaps we should add other specialized system call<br data-mce-bogus=
=3D"1"></div><div>tracepoint probe functions to get more information about =
the<br data-mce-bogus=3D"1"></div><div>arguments, but it should not require=
 any kernel modification nor<br data-mce-bogus=3D"1"></div><div>dynamic pro=
bing.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Hoping this helps!<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"=
><div dir=3D"ltr"><div><span style=3D"font-family: arial,helvetica,sans-ser=
if;" data-mce-style=3D"font-family: arial,helvetica,sans-serif;" face=3D"ar=
ial, helvetica, sans-serif"><br></span></div><div><span style=3D"font-famil=
y: arial,helvetica,sans-serif;" data-mce-style=3D"font-family: arial,helvet=
ica,sans-serif;" face=3D"arial, helvetica, sans-serif"><br></span></div><di=
v><span style=3D"font-family: arial,helvetica,sans-serif;" data-mce-style=
=3D"font-family: arial,helvetica,sans-serif;" face=3D"arial, helvetica, san=
s-serif">Thank very much you for your help.</span></div><br><br><br><div>Ad=
el Belkhiri</div></div><br>_______________________________________________<=
br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></=
div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_9e7480f2-b7e8-46e3-82d5-795d7363884b--

--===============4491335953373007523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4491335953373007523==--
