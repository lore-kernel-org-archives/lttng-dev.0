From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Re: Tracepoints firing without being enabled in LTTng
Date: Wed, 20 Feb 2019 21:26:47 -0500
Message-ID: <CAJyWpKHLXEm9aVqgCvMiCgznJShvjree=adi2xveJr5mtRk+1g__40021.7377625935$1550716035$gmane$org@mail.gmail.com>
References: <CADcCL0hnLNyzOvfpBRW=TzDR9Ekckei5NGOqpAQ=rMUpGnRLEQ@mail.gmail.com>
 <CAJyWpKEgHDa2gPte2eTVg9UCo6RBOBKfPLg9XFUyVcVxMoj8tA@mail.gmail.com>
 <CADcCL0gt=kQop0miSLD3edcKLNERgg+XEjmgkvzdX=A4t_MzuQ@mail.gmail.com>
 <CAJyWpKGEC5dXZXWTupdJA6BVUQhzp5dT-jDX6iX_EE=JrvU4KA@mail.gmail.com>
 <CADcCL0ieGaTA4_=rxaLT2=LAuhQdJGfjM7HYg34eTo-Oo_JDYg@mail.gmail.com>
 <CAJyWpKG2mJJ-DnHLr1gRhrPw5Qsj=TT0j_5FCaQKv7t0qkqcdA@mail.gmail.com>
 <1429830431.1895.1550674017298.JavaMail.zimbra@efficios.com>
 <CAJyWpKHVzmnJp5Mjc9ddQncHM54=b5Ecr2GcpdLLx_8hXojdEw@mail.gmail.com>
 <20190220185310.GC4583@joraj-alpa> <1550689701.3075.142.camel@impinj.com>
 <20190220200558.GD4583@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4639058810360468517=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x12c.google.com (mail-it1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 by lists.lttng.org (Postfix) with ESMTPS id 444ddw1HsHzh3F
 for <lttng-dev@lists.lttng.org>; Wed, 20 Feb 2019 21:26:59 -0500 (EST)
Received: by mail-it1-x12c.google.com with SMTP id d125so8108735ith.1
 for <lttng-dev@lists.lttng.org>; Wed, 20 Feb 2019 18:26:59 -0800 (PST)
In-Reply-To: <20190220200558.GD4583@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4639058810360468517==
Content-Type: multipart/alternative; boundary="0000000000007b902805825e3590"

--0000000000007b902805825e3590
Content-Type: text/plain; charset="UTF-8"

Hello,

Thank you everyone for the assistance and quick response. Thankfully adding
the Environment with LD_PRELOAD in the systemd service file was enough to
get everything running smoothly.

Regards,
Mosleh

On Wed, Feb 20, 2019 at 3:06 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> > One should be able to add LD_PRELOAD to an Environment line in a
> > systemd unit file.  But beware, from ld.so docs:
> >
> > In secure-execution mode, preload pathnames containing slashes are
> > ignored.  Furthermore, shared objects are preloaded only from the
> > standard search directories and only if they have set-user-ID mode bit
> > enabled (which is not typical).
>
> Those are all valid constraints and if I'm not mistaken can be controlled
> by a
> system administrator. Thanks for bringing it up.
>
> >
> > Another way that setting ld_preload can be hard is when the program
> > that needs it is started by another process that does not need it.
> > Like say "mount" will fork and exec "losetup".  How do you set
> > LD_PRELOAD for just losetup without getting mount too?  Modify the code
> > of mount to inject an environment variable?
>
> Unfortunately, for now, yes, if you know that the application that you
> exec is
> instrumented with lttng and will perform either a fork call not followed
> by an
> exec (family) call and/or close all FDs.
>
> > Make a wrapper script
> > named losetup that sets LD_PRELOAD and runs the real losetup binary?
>
> This is valid option.
>
> We do have a potential solution to eliminate the need of preloading the
> fork
> wrapper but we did not yet have time to work on it.
>
> As for the FD lib utility (liblttng-ust-fd) we are open to opinion on how
> to
> solve the problem and make liblttng-ust-fd obsolete.
>
> Cheers
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000007b902805825e3590
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>Thank you everyone fo=
r the assistance and quick response. Thankfully adding the Environment with=
 LD_PRELOAD in the systemd service file was enough to get everything runnin=
g smoothly.=C2=A0<br></div><div><br></div><div>Regards,</div><div>Mosleh</d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Wed, Feb 20, 2019 at 3:06 PM Jonathan Rajotte-Julien &lt;<a href=3D"m=
ailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficio=
s.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">&gt; One should be able to add LD_PRELOAD to an Environment line in a<=
br>
&gt; systemd unit file.=C2=A0 But beware, from ld.so docs:<br>
&gt; <br>
&gt; In secure-execution mode, preload pathnames containing slashes are<br>
&gt; ignored.=C2=A0 Furthermore, shared objects are preloaded only from the=
<br>
&gt; standard search directories and only if they have set-user-ID mode bit=
<br>
&gt; enabled (which is not typical).<br>
<br>
Those are all valid constraints and if I&#39;m not mistaken can be controll=
ed by a<br>
system administrator. Thanks for bringing it up.<br>
<br>
&gt; <br>
&gt; Another way that setting ld_preload can be hard is when the program<br=
>
&gt; that needs it is started by another process that does not need it. <br=
>
&gt; Like say &quot;mount&quot; will fork and exec &quot;losetup&quot;.=C2=
=A0 How do you set<br>
&gt; LD_PRELOAD for just losetup without getting mount too?=C2=A0 Modify th=
e code<br>
&gt; of mount to inject an environment variable?<br>
<br>
Unfortunately, for now, yes, if you know that the application that you exec=
 is<br>
instrumented with lttng and will perform either a fork call not followed by=
 an<br>
exec (family) call and/or close all FDs.<br>
<br>
&gt; Make a wrapper script<br>
&gt; named losetup that sets LD_PRELOAD and runs the real losetup binary?<b=
r>
<br>
This is valid option.<br>
<br>
We do have a potential solution to eliminate the need of preloading the for=
k<br>
wrapper but we did not yet have time to work on it.<br>
<br>
As for the FD lib utility (liblttng-ust-fd) we are open to opinion on how t=
o<br>
solve the problem and make liblttng-ust-fd obsolete.<br>
<br>
Cheers<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--0000000000007b902805825e3590--

--===============4639058810360468517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4639058810360468517==--
