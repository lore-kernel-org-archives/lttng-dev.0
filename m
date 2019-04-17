From: Luis Ayuso <luis.f.ayuso@gmail.com>
Subject: Re: unable to profile example
Date: Wed, 17 Apr 2019 14:57:53 +0200
Message-ID: <CAGkk+5A3=cGh6oTO5TOESu0LYq61M9DDw3qC9bW+ufJa-OZpFg__14965.0378430792$1555510544$gmane$org@mail.gmail.com>
References: <CAGkk+5Be9mMt6Nni8BdRwH4hfXG_QsKKjNPtYWm2xDtGOvNruA@mail.gmail.com>
 <1864353373.2210.1555436765140.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7249629808424394895=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by lists.lttng.org (Postfix) with ESMTPS id 44kj2k1cWWz1KhP
 for <lttng-dev@lists.lttng.org>; Wed, 17 Apr 2019 08:58:05 -0400 (EDT)
Received: by mail-pl1-x636.google.com with SMTP id b3so12009050plr.7
 for <lttng-dev@lists.lttng.org>; Wed, 17 Apr 2019 05:58:05 -0700 (PDT)
In-Reply-To: <1864353373.2210.1555436765140.JavaMail.zimbra@efficios.com>
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

--===============7249629808424394895==
Content-Type: multipart/alternative; boundary="000000000000b425d50586b96f2f"

--000000000000b425d50586b96f2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

the example works now. thanks for your time

El mar., 16 abr. 2019 a las 19:46, Mathieu Desnoyers (<
mathieu.desnoyers@efficios.com>) escribi=C3=B3:

>
>
> ----- On Apr 16, 2019, at 11:34 AM, Luis Ayuso luis.f.ayuso@gmail.com
> wrote:
>
> > Dear Lttng community.
>
> > I tried to profile the example code, as described in the documentation =
@
> [
> > https://lttng.org/docs/v2.10 | https://lttng.org/docs/v2.10 ]
> > and I could not get any satisfactory result.
>
> > I am using
> > - lttng (LTTng Trace Control) 2.10.2 - KeKriek
> > - Ubuntu 18.04.2
>
> > I created the files hello-tp.c hello-tp.h hello.c as described in the
> > documentation
> > The code succesfully compiles.
> > Kernel modules are loaded.
> > lttng-sessiond --daemonize runs with not acknowledgement.
>
> > nevertheless, lttng create session command returns an error I am unable
> to
> > justify:
> > lttng create test
> > Session test created.
> > Traces will be written in /home/luis/lttng-traces/test-20190416-173219
> > Error: Unable to create config file
> > Error: Command error
>
> > - Do I need any extra setup step that is no documented in the web?
> > - Is the package at ubuntu repos working correctly?
> > - are there known conflicts with any other software
>
> This message appears when lttng fails to create either:
>
> - $LTTNG_HOME/.lttngrc (if the LTTNG_HOME environment variable is set), o=
r
> - $HOME/.lttngrc otherwise.
>
> Please double-check the content of those environment variables and access
> rights
> to the directories they lead to.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--000000000000b425d50586b96f2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">the example works now. thanks for your time<br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">El mar., 16=
 abr. 2019 a las 19:46, Mathieu Desnoyers (&lt;<a href=3D"mailto:mathieu.de=
snoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;) escribi=C3=B3=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
----- On Apr 16, 2019, at 11:34 AM, Luis Ayuso <a href=3D"mailto:luis.f.ayu=
so@gmail.com" target=3D"_blank">luis.f.ayuso@gmail.com</a> wrote:<br>
<br>
&gt; Dear Lttng community.<br>
<br>
&gt; I tried to profile the example code, as described in the documentation=
 @ [<br>
&gt; <a href=3D"https://lttng.org/docs/v2.10" rel=3D"noreferrer" target=3D"=
_blank">https://lttng.org/docs/v2.10</a> | <a href=3D"https://lttng.org/doc=
s/v2.10" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.10<=
/a> ]<br>
&gt; and I could not get any satisfactory result.<br>
<br>
&gt; I am using<br>
&gt; - lttng (LTTng Trace Control) 2.10.2 - KeKriek<br>
&gt; - Ubuntu 18.04.2<br>
<br>
&gt; I created the files hello-tp.c hello-tp.h hello.c as described in the<=
br>
&gt; documentation<br>
&gt; The code succesfully compiles.<br>
&gt; Kernel modules are loaded.<br>
&gt; lttng-sessiond --daemonize runs with not acknowledgement.<br>
<br>
&gt; nevertheless, lttng create session command returns an error I am unabl=
e to<br>
&gt; justify:<br>
&gt; lttng create test<br>
&gt; Session test created.<br>
&gt; Traces will be written in /home/luis/lttng-traces/test-20190416-173219=
<br>
&gt; Error: Unable to create config file<br>
&gt; Error: Command error<br>
<br>
&gt; - Do I need any extra setup step that is no documented in the web?<br>
&gt; - Is the package at ubuntu repos working correctly?<br>
&gt; - are there known conflicts with any other software<br>
<br>
This message appears when lttng fails to create either:<br>
<br>
- $LTTNG_HOME/.lttngrc (if the LTTNG_HOME environment variable is set), or<=
br>
- $HOME/.lttngrc otherwise.<br>
<br>
Please double-check the content of those environment variables and access r=
ights<br>
to the directories they lead to.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></div>

--000000000000b425d50586b96f2f--

--===============7249629808424394895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7249629808424394895==--
