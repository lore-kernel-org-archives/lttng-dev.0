From: Ojas Shirekar <ojas.shirekar@gmail.com>
Subject: Re: Which function/file allows babeltrace to print the
	logs?
Date: Mon, 6 Jun 2016 11:30:01 +0530
Message-ID: <CAPtQ1vfqc5QGs1x1Z60kSE8DwowGspPWKNPuqHzV93zbzRO4eQ__9138.51494337923$1465233226$gmane$org@mail.gmail.com>
References: <CAPtQ1vePkKYx8bkgtDxNaYpMNVyw+UBxnA=0qrznsNo7Wg3M5Q@mail.gmail.com>
 <CAB4xu_2zho1eETUEuNVDGmUn9fCdoFyhTae2xcuoE3089efA5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6956551343903807427=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A4638A37C7
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 06:00:22 +0000 (UTC)
Received: by mail-io0-f182.google.com with SMTP id n127so7968984iof.3
 for <lttng-dev@lists.lttng.org>; Sun, 05 Jun 2016 23:00:22 -0700 (PDT)
In-Reply-To: <CAB4xu_2zho1eETUEuNVDGmUn9fCdoFyhTae2xcuoE3089efA5Q@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6956551343903807427==
Content-Type: multipart/alternative; boundary=001a1140b8eca7b92d053495c93e

--001a1140b8eca7b92d053495c93e
Content-Type: text/plain; charset=UTF-8

Another query that I had was regarding the buffer in babeltrace. Where can
I find the trace buffer implementation, I just want to print out the size
of the buffer every few seconds.
The thing is that we are using lttng on a set top box, and the traces that
are sent during the boot process number at around 100000 per 5 secs or so,
the whole bootup lasts for about a minute and half, so I just want to the
buffer size every few seconds, is that possible? If yes, then where/how?

So I was wondering if I can have babeltrace write to a shared memory
location to make it faster, hence my first question, it would be great if
you could point me in the right direction for this.

Thank you

- Ojas

On Sun, Jun 5, 2016 at 9:18 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Fri, Jun 3, 2016 at 12:29 AM, Ojas Shirekar <ojas.shirekar@gmail.com>
> wrote:
> >
> > In which file is the function that allows babeltrace to print the CTF
> logs to STDOUT?
> > I am asking this because I need to modify it so that I can get JSON
> output, and also because I am new to babeltrace.
>
> This will certainly be a trivial feature to implement once the
> plugin-based Babeltrace 2 is released!
>
> In the meantime: the printing happens here:
> https://github.com/efficios/babeltrace/tree/master/formats/ctf-text.
>
> Phil
>
> >
> > Thank you for the help.
> > -Ojas Shirekar
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--001a1140b8eca7b92d053495c93e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Another query that I had was regarding=
 the buffer in babeltrace. Where can I find the trace buffer implementation=
, I just want to print out the size of the buffer every few seconds.<br></d=
iv>The thing is that we are using lttng on a set top box, and the traces th=
at are sent during the boot process number at around 100000 per 5 secs or s=
o, the whole bootup lasts for about a minute and half, so I just want to th=
e buffer size every few seconds, is that possible? If yes, then where/how?<=
br><br></div>So I was wondering if I can have babeltrace write to a shared =
memory location to make it faster, hence my first question, it would be gre=
at if you could point me in the right direction for this.<br><br></div>Than=
k you<br><br></div>- Ojas<br></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Sun, Jun 5, 2016 at 9:18 PM, Philippe Proulx <span dir=
=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank">e=
eppeliteloop@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><span class=3D"">On Fri, Jun 3, 2016 at 12:29 AM, Ojas Shirekar &lt;<a =
href=3D"mailto:ojas.shirekar@gmail.com">ojas.shirekar@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; In which file is the function that allows babeltrace to print the CTF =
logs to STDOUT?<br>
&gt; I am asking this because I need to modify it so that I can get JSON ou=
tput, and also because I am new to babeltrace.<br>
<br>
</span>This will certainly be a trivial feature to implement once the<br>
plugin-based Babeltrace 2 is released!<br>
<br>
In the meantime: the printing happens here:<br>
<a href=3D"https://github.com/efficios/babeltrace/tree/master/formats/ctf-t=
ext" rel=3D"noreferrer" target=3D"_blank">https://github.com/efficios/babel=
trace/tree/master/formats/ctf-text</a>.<br>
<br>
Phil<br>
<span class=3D""><br>
&gt;<br>
&gt; Thank you for the help.<br>
&gt; -Ojas Shirekar<br>
&gt;<br>
</span>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
&gt;<br>
</blockquote></div><br></div>

--001a1140b8eca7b92d053495c93e--

--===============6956551343903807427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6956551343903807427==--
