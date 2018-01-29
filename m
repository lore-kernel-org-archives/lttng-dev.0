From: pedro pinto <pedro.e.pinto@gmail.com>
Subject: Re: statically linking liblttng
Date: Mon, 29 Jan 2018 12:14:26 -0500
Message-ID: <CAKOJUhSbXqVxq0LKFtdZQyu==Pgmkewhsw6+9QY+ne+n=1MiAA__4263.57176988876$1517253474$gmane$org@mail.gmail.com>
References: <CAKOJUhQSk9YZsSvUiGV_u0C0YT43KvFVTBNwAR861m4-=LWa9Q@mail.gmail.com>
 <1988871731.11498.1517245236733.JavaMail.zimbra@efficios.com>
Reply-To: pedro.e.pinto@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6396428875470863892=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x232.google.com (mail-qk0-x232.google.com
 [IPv6:2607:f8b0:400d:c09::232])
 by lists.lttng.org (Postfix) with ESMTPS id 3zVbjM5JN3zC9Y
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jan 2018 17:14:47 +0000 (UTC)
Received: by mail-qk0-x232.google.com with SMTP id l64so6465479qke.13
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jan 2018 09:14:47 -0800 (PST)
In-Reply-To: <1988871731.11498.1517245236733.JavaMail.zimbra@efficios.com>
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

--===============6396428875470863892==
Content-Type: multipart/alternative; boundary="001a1149694607c3f40563ed623b"

--001a1149694607c3f40563ed623b
Content-Type: text/plain; charset="UTF-8"

Thank you Mathieu.

On Mon, Jan 29, 2018 at 12:00 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Jan 29, 2018, at 8:56 AM, pedro pinto <pedro.e.pinto@gmail.com>
> wrote:
>
> Hi there. I would like to instrument a C++ statically linked application
> using the lttng static libraries (i.e. libllttng-ust.a, etc). To try to get
> this working I took the quick start example and changed it to use the
> following link command line:
>
> gcc -o hello hello.o hello-tp.o -Wl,-Bstatic -llttng-ust
> -llttng-ust-tracepoint -lurcu-bp -lurcu-cds -Wl,-Bdynamic -lrt -ldl
> -pthread
>
> This does not return any errors but the resulting trace is empty. I was
> able to get a trace using the liblttng shared object though.
>
> Is it possible to statically link liblttng ? I am using v2.9.5 of lttng
>
> Static linking of lttng-ust is not supported. For a start, the library
> constructors are not
> executed in a statically linked library.
>
> Thanks,
>
> Mathieu
>
>
>
>
> Thanks in advance!
>
> -pp
>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a1149694607c3f40563ed623b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Mathieu.</div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Mon, Jan 29, 2018 at 12:00 PM, Mathieu Desnoyers=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" ta=
rget=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,=
sans-serif;font-size:12pt;color:#000000"><span class=3D""><div><span id=3D"=
m_3802064364517024908zwchr">----- On Jan 29, 2018, at 8:56 AM, pedro pinto =
&lt;<a href=3D"mailto:pedro.e.pinto@gmail.com" target=3D"_blank">pedro.e.pi=
nto@gmail.com</a>&gt; wrote:<br></span></div></span><div><span class=3D""><=
blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-l=
eft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><=
div>Hi there. I would like to instrument a C++ statically linked applicatio=
n using the lttng static libraries (i.e. libllttng-ust.a, etc). To try to g=
et this working I took the quick start example and changed it to use the fo=
llowing link command line:=C2=A0</div><br><div>gcc -o hello hello.o hello-t=
p.o -Wl,-Bstatic -llttng-ust -llttng-ust-tracepoint -lurcu-bp -lurcu-cds -W=
l,-Bdynamic -lrt -ldl -pthread=C2=A0</div><br><div><div>This does not retur=
n any errors but the resulting trace is empty. I was able to get a trace us=
ing the liblttng shared object though.<br></div></div><br><div>Is it possib=
le to statically link liblttng ? I am using v2.9.5 of lttng</div></div></bl=
ockquote></span><div>Static linking of lttng-ust is not supported. For a st=
art, the library constructors are not<br></div><div>executed in a staticall=
y linked library.<br></div><div><br></div><div>Thanks,<br></div><div><br></=
div><div>Mathieu<br></div><div><br></div><div><br></div><div><br></div><blo=
ckquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><br>=
<div>Thanks in advance!</div><br><div>-pp</div><br><br><br><br></div><br>__=
____________________________<wbr>_________________<br>lttng-dev mailing lis=
t<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bi=
n/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=3D"#8888=
88"><br></font></span></blockquote></div><span class=3D"HOEnZb"><font color=
=3D"#888888"><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>Eff=
iciOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://=
www.efficios.com</a></div></font></span></div></div></blockquote></div><br>=
</div>

--001a1149694607c3f40563ed623b--

--===============6396428875470863892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6396428875470863892==--
