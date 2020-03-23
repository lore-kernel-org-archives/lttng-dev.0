From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace2 - compilation error with intel18
Date: Mon, 23 Mar 2020 10:05:07 -0600
Message-ID: <CADtyBo54YfVYCc6-ODNTxGWBs4HgHZwDED93Z_GVF8APaafYFw@mail.gmail.com>
References: <CADtyBo7jFiv-E-DCp4kYfY7WRSLsN3Oos6iRr35Sy9o=iNZKOg@mail.gmail.com>
 <b2e4fcfb-eb65-5205-1de3-0e0dbfb7fb48@simark.ca>
 <CADtyBo7Qjjb_f=45oTaSw4d=dQd5YVt6A2r7z7R5WYrxZ4eVTg@mail.gmail.com>
 <60fcd0f0-e89c-5e04-8185-8cf34a92fe04@simark.ca>
 <CADtyBo44MW0=jBnrhh-aqfnrS8RtLAk9zbBZp3ktEhKACWPXdg@mail.gmail.com>
 <4bc0ec69-7587-fe58-691f-5cb23a11cd43@simark.ca>
 <1c4447ea-b67a-eaf0-c9dd-d2c10106b5a7@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2962902454815784269=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 48mK3S1Y7Qz1R2g
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2020 12:05:23 -0400 (EDT)
Received: by mail-oi1-x22c.google.com with SMTP id d63so15233150oig.6
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2020 09:05:23 -0700 (PDT)
In-Reply-To: <1c4447ea-b67a-eaf0-c9dd-d2c10106b5a7@simark.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simark@simark.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2962902454815784269==
Content-Type: multipart/alternative; boundary="0000000000007225b405a187cd78"

--0000000000007225b405a187cd78
Content-Type: text/plain; charset="UTF-8"

Simon,

Yes, I will be happy to give this a try.  What's the easiest way to get
this patch?  (Sorry, I'm less familiar with Gerrit...)

Rocky

On Mon, Mar 23, 2020 at 9:44 AM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-20 11:12 p.m., Simon Marchi via lttng-dev wrote:
> > So since distutils really wants to compile the Python native modules
> using all the same
> > flags as the Python interpreter was built with, I presume that they
> really assume that
> > you'll be using the exact same toolchain to build your module as was
> used to build the
> > interpreter.  Maybe we could just not pass CC/CFLAGS when building the
> Python module,
> > so it will simply be built with the same compiler/linker as Python was
> built with, and
> > we'll avoid all these problems...
>
> If we want to go this route, here's a patch that implements it.
>
>   https://review.lttng.org/c/babeltrace/+/3257
>
> This makes it so we don't override the compiler or flags (other than
> necessary includes
> flags) when building the native module.  So when configuring with
> CC=clang, the Python
> native module gets built with the Python distribution's default compiler,
> with just the
> flags it wants.
>
> Could you check if that works with CC=icc as well?
>
> Simon
>

--0000000000007225b405a187cd78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Simon,<div><br></div><div>Yes, I will be happy to give thi=
s a try.=C2=A0 What&#39;s the easiest way to get this patch?=C2=A0 (Sorry, =
I&#39;m less familiar with Gerrit...)</div><div><br></div><div>Rocky</div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Mar 23, 2020 at 9:44 AM Simon Marchi &lt;<a href=3D"mailto:simark@si=
mark.ca">simark@simark.ca</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 2020-03-20 11:12 p.m., Simon Marchi via lttng-d=
ev wrote:<br>
&gt; So since distutils really wants to compile the Python native modules u=
sing all the same<br>
&gt; flags as the Python interpreter was built with, I presume that they re=
ally assume that<br>
&gt; you&#39;ll be using the exact same toolchain to build your module as w=
as used to build the<br>
&gt; interpreter.=C2=A0 Maybe we could just not pass CC/CFLAGS when buildin=
g the Python module,<br>
&gt; so it will simply be built with the same compiler/linker as Python was=
 built with, and<br>
&gt; we&#39;ll avoid all these problems...<br>
<br>
If we want to go this route, here&#39;s a patch that implements it.<br>
<br>
=C2=A0 <a href=3D"https://review.lttng.org/c/babeltrace/+/3257" rel=3D"nore=
ferrer" target=3D"_blank">https://review.lttng.org/c/babeltrace/+/3257</a><=
br>
<br>
This makes it so we don&#39;t override the compiler or flags (other than ne=
cessary includes<br>
flags) when building the native module.=C2=A0 So when configuring with CC=
=3Dclang, the Python<br>
native module gets built with the Python distribution&#39;s default compile=
r, with just the<br>
flags it wants.<br>
<br>
Could you check if that works with CC=3Dicc as well?<br>
<br>
Simon<br>
</blockquote></div>

--0000000000007225b405a187cd78--

--===============2962902454815784269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2962902454815784269==--
