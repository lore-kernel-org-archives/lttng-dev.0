From: =?utf-8?q?Christophe_B=C3=A9dard_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Subject: Re: Correctly using callstack-user context
Date: Wed, 13 May 2020 09:42:42 -0400
Message-ID: <CAAS9dobxi52FyWn=9zVDkMMpmZztc1Q1msdiErMKhkDEYCtqCA@mail.gmail.com>
References: <CAAS9doY1Ez7N=_H6e-w9eWg0LBJp+MMasuOEmzbO0DGyLSzViA@mail.gmail.com>
 <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
Reply-To: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5450112476235330822=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by lists.lttng.org (Postfix) with ESMTPS id 49MbTz6z4Sz220Y
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 09:43:19 -0400 (EDT)
Received: by mail-ej1-x630.google.com with SMTP id s21so6120323ejd.2
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 06:43:19 -0700 (PDT)
In-Reply-To: <1486835767.11198.1589286441675.JavaMail.zimbra@efficios.com>
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

--===============5450112476235330822==
Content-Type: multipart/alternative; boundary="0000000000004058e905a587c316"

--0000000000004058e905a587c316
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2020 at 08:27, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> How does your test program issue the system call ? Is it directly with
> syscall() (see syscall(2) man page), or
> does it call into libc ? Is your entire libc compiled with
> -fno-omit-frame-pointer ?
>

Indirectly, through libc/libstdc++. We use the default system libs (which I
assume use -O, which in turn implies -fomit-frame-pointer).


> As soon as one library in the chain to the system call is compiled without
> frame pointers, this is where the
> stack walk stops. This is usually libc.
>

I see. Thanks for the information. Not sure we want to ship a custom libc
unfortunately.

Related question: how feasible would adding the callstack-user context to
userspace events be? If it is feasible, is such a feature planned?



Christophe

--0000000000004058e905a587c316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, 12 May 2020 at 08:27, Mathieu Des=
noyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_bla=
nk">mathieu.desnoyers@efficios.com</a>&gt; wrote:</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,helvetic=
a,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><div>How does your test =
program issue the system call ? Is it directly with syscall() (see syscall(=
2) man page), or<br></div><div>does it call into libc ? Is your entire libc=
 compiled with -fno-omit-frame-pointer ?</div></div></div></div></blockquot=
e><div><br></div><div>Indirectly, through libc/libstdc++. We use the defaul=
t system libs (which I assume use -O, which in turn implies -fomit-frame-po=
inter).</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)"><div></div><div>As soon as one library in the chain to the =
system call is compiled without frame pointers, this is where the<br></div>=
<div>stack walk stops. This is usually libc.</div></div></blockquote><div><=
br></div><div>I see. Thanks for the information. Not sure we want to ship a=
 custom libc unfortunately.</div><div><br></div><div>Related question: how =
feasible would adding the callstack-user context to userspace=C2=A0events b=
e? If it is feasible, is such a feature planned?</div><div><br></div><div><=
br></div><div><br></div><div>Christophe=C2=A0</div></div></div>

--0000000000004058e905a587c316--

--===============5450112476235330822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5450112476235330822==--
