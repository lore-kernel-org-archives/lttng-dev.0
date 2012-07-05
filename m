From: Diego Dompe <ddompe@gmail.com>
Subject: Re: Questions about CTF format
Date: Thu, 5 Jul 2012 08:49:57 -0600
Message-ID: <CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw__39132.4649718173$1341500264$gmane$org@mail.gmail.com>
References: <CAEBwSh_OkCZiWJXQrUO3fnLnka3MfTJpa8z0HqxxVFd7CtPqOg@mail.gmail.com>
	<20120705142052.GA23162@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1602702357=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ddompe@gmail.com>) id 1SmnTZ-0006CI-Hv
	for lttng-dev@lists.lttng.org; Thu, 05 Jul 2012 10:56:14 -0400
Received: by wgbfg15 with SMTP id fg15so7078848wgb.23
	for <lttng-dev@lists.lttng.org>; Thu, 05 Jul 2012 07:56:07 -0700 (PDT)
In-Reply-To: <20120705142052.GA23162@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, tiwg@multicore-association.org
List-Id: lttng-dev@lists.lttng.org

--===============1602702357==
Content-Type: multipart/alternative; boundary=0016e6db7dd5dfd9f704c4164284

--0016e6db7dd5dfd9f704c4164284
Content-Type: text/plain; charset=ISO-8859-1

Hi Mathieu,

Thanks for the help. Here is my list of details:

- Clocks: the spec doesn't explain properly that timestamps are an offset
from the base time of the clock they refer to. Since I was using 64bit
timestamps I somehow assumed that I was using absolute timestamps from the
epoch (although the spec doesn't says it either).

- I saw that the lttng-generated traces for metadata are always a multiple
of 4k in size (at least the ones I generate for either kernel or user
space). I can't find where in the spec it mentions requirements regarding
metadata packet padding. I was generating metadata packets that ended up
right after my TSDL and eclipse wasn't happy about it (although I didn't
try babeltrace). Also I found that the lttng-generated traces have a
"empty" metadata packet after the metadata containing the TSDL, I didn't
find either any documentation regarding this.

Regards,

Diego

On Thu, Jul 5, 2012 at 8:20 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> * Diego Dompe (ddompe@gmail.com) wrote:
> > Hi,
> >
> > I'm developing a custom tracer for an embedded product that will generate
> > CTF format. I was able to generate generic traces that can be interpreted
> > properly with babeltrace (but not with eclipse, I already file a bug for
> > that), but I found the CTF specification lacking in some aspects (I had
> to
> > peek into lttng-generated CTF traces to figure out some details). I was
> > wondering what is the proper mailing list to clear my questions and
> provide
> > feedback on the CTF specification for improvement in the areas where the
> > documentation is not detailed yet. I don't see any CTF-specific mailing
> > list, it's OK to discuss it here? Or maybe directly with a developer(s)?
>
> Hi Diego,
>
> Yes, this mailing list would be the proper place, along maybe with
> adding the MCA tiwg mailing list in CC, which I'm doing here.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--0016e6db7dd5dfd9f704c4164284
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,<div><br></div><div>Thanks for the help. Here is my list of deta=
ils:</div><div><br></div><div>- Clocks: the spec doesn&#39;t explain proper=
ly that timestamps are an offset from the base time of the clock they refer=
 to. Since I was using 64bit timestamps I somehow assumed that I was using =
absolute timestamps from the epoch (although the spec doesn&#39;t says it e=
ither).</div>
<div><br></div><div>- I saw that the lttng-generated traces for metadata ar=
e always a multiple of 4k in size (at least the ones I generate for either =
kernel or user space). I can&#39;t find where in the spec it mentions requi=
rements regarding metadata packet padding. I was generating metadata packet=
s that ended up right after my TSDL and eclipse wasn&#39;t happy about it (=
although I didn&#39;t try babeltrace). Also I found that the lttng-generate=
d traces have a &quot;empty&quot; metadata packet after the metadata contai=
ning the TSDL, I didn&#39;t find either any documentation regarding this.</=
div>
<div><br></div><div>Regards,</div><div><br></div><div>Diego</div><div><br><=
/div><div><div class=3D"gmail_quote">On Thu, Jul 5, 2012 at 8:20 AM, Mathie=
u Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@effic=
ios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">* Di=
ego Dompe (<a href=3D"mailto:ddompe@gmail.com">ddompe@gmail.com</a>) wrote:=
<br>
&gt; Hi,<br>
&gt;<br>
&gt; I&#39;m developing a custom tracer for an embedded product that will g=
enerate<br>
&gt; CTF format. I was able to generate generic traces that can be interpre=
ted<br>
&gt; properly with babeltrace (but not with eclipse, I already file a bug f=
or<br>
&gt; that), but I found the CTF specification lacking in some aspects (I ha=
d to<br>
&gt; peek into lttng-generated CTF traces to figure out some details). I wa=
s<br>
&gt; wondering what is the proper mailing list to clear my questions and pr=
ovide<br>
&gt; feedback on the CTF specification for improvement in the areas where t=
he<br>
&gt; documentation is not detailed yet. I don&#39;t see any CTF-specific ma=
iling<br>
&gt; list, it&#39;s OK to discuss it here? Or maybe directly with a develop=
er(s)?<br>
<br>
</div></div>Hi Diego,<br>
<br>
Yes, this mailing list would be the proper place, along maybe with<br>
adding the MCA tiwg mailing list in CC, which I&#39;m doing here.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--0016e6db7dd5dfd9f704c4164284--


--===============1602702357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1602702357==--
