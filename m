From: Zvi Vered <veredz72@gmail.com>
Subject: Re: (no subject)
Date: Fri, 14 Jun 2019 07:30:08 +0300
Message-ID: <CABRndgz4GtnhKE3g+GgCAmQD=6U-6PzfKPJL1cUgo2dM8Vcwqw__343.156924803623$1560486887$gmane$org@mail.gmail.com>
References: <CABRndgyzXQaYpefcMEMt1ShbqVKaf9vLJOXaL2cgUZMik4=xxw@mail.gmail.com>
 <CAB4xu_0h-q6En3_hDODbKuXd1=4_e0car73pP8Cf=LNWMKjh_g@mail.gmail.com>
 <CABRndgwEg3wYLbyfobjxdEKd8O1dAu+B+PwS-0A5gxURjKj_WA@mail.gmail.com>
 <20190613153823.GC972@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9102997432094379024=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw1-xc34.google.com (mail-yw1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by lists.lttng.org (Postfix) with ESMTPS id 45Q76q1PHFz18Pq
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jun 2019 00:34:27 -0400 (EDT)
Received: by mail-yw1-xc34.google.com with SMTP id t126so541538ywf.3
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 21:34:27 -0700 (PDT)
In-Reply-To: <20190613153823.GC972@joraj-alpa>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============9102997432094379024==
Content-Type: multipart/alternative; boundary="00000000000057963a058b412905"

--00000000000057963a058b412905
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

I need a windows library (+ sample code that uses it) that can read events
from a pre-recorded CTF file created by ltt-ng (metadata, channels)
I think (not sure) that compiling babeltrace (e.g 1.5.23) with Mingw is not
simple.
As a start, the bootstrap, cannot run under windows.

Thank you,
Zvika




On Thu, Jun 13, 2019 at 6:38 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> > Can you please estimate when version 2 will be released ?
>
> When it is ready. A lot of work was done on that side in the last 6 month,
> the
> list of bugs and stuff to get done is shrinking everyday.
>
> > Can you please provide sample code that uses Babeltrace to read metadata,
> > channel ?
>
> The source code for decoding the metadata TSDL is available here [1] if
> I'm not
> mistaken. The header is only the tip of the iceberg.
>
> [1]
> https://github.com/efficios/babeltrace/tree/stable-1.5/formats/ctf/metadata
>
> I'm not sure if we expose the metadata information directly to the API.
>
> See [2] for the API documentation of babeltrace 1.5
>
> [2]
> http://git.efficios.com/?p=babeltrace.git;a=blob;f=doc/API.txt;h=e13e6adf3545d306e36c2496dd2feb50479d1eea
>
> > > >
> > > > I want to write a simple babeltrace for windows.
> > >
>
> I'm not convinced that rewriting an open source project is the right way
> to go
> about that. Even more when there is already efforts being conducted for
> supporting
> Windows.
>
> What is the end goal here? What are you trying to achieve?
>
> Do you want a basic cli that can read traces and output text trace?
> Do you want to build a tool around ctf and need a reader/writer lib?
>
> Please provide context so that we can help you achieve your goal.
>
> Cheers
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--00000000000057963a058b412905
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>I need a windows library (=
+ sample code that uses it) that can read events from a pre-recorded CTF fi=
le created by ltt-ng (metadata, channels)=C2=A0</div><div>I think (not sure=
) that compiling babeltrace (e.g 1.5.23) with Mingw is not simple.=C2=A0</d=
iv><div>As a start, the bootstrap, cannot run under windows.</div><div><br>=
</div><div>Thank you,</div><div>Zvika=C2=A0</div><div>=C2=A0=C2=A0<br></div=
><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2019 at 6:38 PM Jonathan Raj=
otte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jon=
athan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi,<br>
<br>
&gt; Can you please estimate when version 2 will be released ?<br>
<br>
When it is ready. A lot of work was done on that side in the last 6 month, =
the<br>
list of bugs and stuff to get done is shrinking everyday.<br>
<br>
&gt; Can you please provide sample code that uses Babeltrace to read metada=
ta,<br>
&gt; channel ?<br>
<br>
The source code for decoding the metadata TSDL is available here [1] if I&#=
39;m not<br>
mistaken. The header is only the tip of the iceberg.<br>
<br>
[1] <a href=3D"https://github.com/efficios/babeltrace/tree/stable-1.5/forma=
ts/ctf/metadata" rel=3D"noreferrer" target=3D"_blank">https://github.com/ef=
ficios/babeltrace/tree/stable-1.5/formats/ctf/metadata</a><br>
<br>
I&#39;m not sure if we expose the metadata information directly to the API.=
<br>
<br>
See [2] for the API documentation of babeltrace 1.5<br>
<br>
[2] <a href=3D"http://git.efficios.com/?p=3Dbabeltrace.git;a=3Dblob;f=3Ddoc=
/API.txt;h=3De13e6adf3545d306e36c2496dd2feb50479d1eea" rel=3D"noreferrer" t=
arget=3D"_blank">http://git.efficios.com/?p=3Dbabeltrace.git;a=3Dblob;f=3Dd=
oc/API.txt;h=3De13e6adf3545d306e36c2496dd2feb50479d1eea</a><br>
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I want to write a simple babeltrace for windows.<br>
&gt; &gt;<br>
<br>
I&#39;m not convinced that rewriting an open source project is the right wa=
y to go<br>
about that. Even more when there is already efforts being conducted for sup=
porting<br>
Windows.<br>
<br>
What is the end goal here? What are you trying to achieve?<br>
<br>
Do you want a basic cli that can read traces and output text trace?<br>
Do you want to build a tool around ctf and need a reader/writer lib?<br>
<br>
Please provide context so that we can help you achieve your goal.<br>
<br>
Cheers<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--00000000000057963a058b412905--

--===============9102997432094379024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9102997432094379024==--
