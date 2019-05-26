From: Zvi Vered <veredz72@gmail.com>
Subject: Re: lttng trace" Read trace under windows
Date: Sun, 26 May 2019 05:40:51 +0300
Message-ID: <CABRndgyEo1g+x1=DmTFqWwvZzXVmJUrVCg6kD+=QQfciksLwEw__36245.5251671904$1558838620$gmane$org@mail.gmail.com>
References: <CABRndgx7zGtAR_7eM8Vb7AorGkS4-2b8z8P5n9rv45-SMhuL0Q@mail.gmail.com>
 <20190521144811.GA1071@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9126338829506961154=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw1-xc2b.google.com (mail-yw1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by lists.lttng.org (Postfix) with ESMTPS id 45BPYS432Lzyhy
 for <lttng-dev@lists.lttng.org>; Sat, 25 May 2019 22:43:24 -0400 (EDT)
Received: by mail-yw1-xc2b.google.com with SMTP id t140so2609856ywe.8
 for <lttng-dev@lists.lttng.org>; Sat, 25 May 2019 19:43:24 -0700 (PDT)
In-Reply-To: <20190521144811.GA1071@joraj-alpa>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============9126338829506961154==
Content-Type: multipart/alternative; boundary="000000000000358b800589c1650f"

--000000000000358b800589c1650f
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thank you very much for your repy.

Each trace contains also idx files (channel0_0.idx ... channel0_7.idx).
Are those also CTF files ?

Is "metadata" a CTF file also ?

Best regards,
Zvika

On Tue, May 21, 2019 at 5:48 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On Mon, May 20, 2019 at 10:49:49PM -0700, Zvi Vered wrote:
> > Hello,
> >
> > I'm looking for a windows library that can read a trace ?
>
> Babeltrace 1.5 can be build on cygwin.
>
> > Or - detailed instructions on the structure of each file in the trace.
>
> https://diamon.org/ctf/
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000358b800589c1650f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>Thank you very much for yo=
ur repy.</div><div><br></div><div>Each trace contains also idx files (chann=
el0_0.idx ... channel0_7.idx).=C2=A0</div><div>Are those also CTF files ?</=
div><div><br></div><div>Is &quot;metadata&quot; a CTF file also ?</div><div=
><br></div><div>Best regards,</div><div>Zvika=C2=A0</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 21, 20=
19 at 5:48 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajott=
e-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, May 20, 2019 at 10:49:49PM -0700, Zvi Vered wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I&#39;m looking for a windows library that can read a trace ?<br>
<br>
Babeltrace 1.5 can be build on cygwin.<br>
<br>
&gt; Or - detailed instructions on the structure of each file in the trace.=
<br>
<br>
<a href=3D"https://diamon.org/ctf/" rel=3D"noreferrer" target=3D"_blank">ht=
tps://diamon.org/ctf/</a><br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--000000000000358b800589c1650f--

--===============9126338829506961154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9126338829506961154==--
