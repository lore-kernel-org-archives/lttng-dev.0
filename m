From: Rocky Dunlap <rsdunlapiv@gmail.com>
Subject: Re: Explicit setting of UUID with ctf writer
Date: Fri, 7 Apr 2017 14:15:50 -0600
Message-ID: <CAK-w0DfawxkijMiUCZzLSApkTHCLH06N6QayjaSh_OSJQwEQjQ__43080.5516698912$1491596165$gmane$org@mail.gmail.com>
References: <CAK-w0DdKCrHuGakFkWM1z4sXW10oyxmxdGXezyXb+DutEieeMA@mail.gmail.com>
 <CAB4xu_2fHsZa-LqHA-VVdDN1X8ej2_W6-JvjHk2E0C83ftKLYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3700002634517437230=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x22f.google.com (mail-ua0-x22f.google.com
 [IPv6:2607:f8b0:400c:c08::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 3w09ns22VjzkTk
 for <lttng-dev@lists.lttng.org>; Fri,  7 Apr 2017 20:16:17 +0000 (UTC)
Received: by mail-ua0-x22f.google.com with SMTP id c28so1182546uaf.3
 for <lttng-dev@lists.lttng.org>; Fri, 07 Apr 2017 13:15:52 -0700 (PDT)
In-Reply-To: <CAB4xu_2fHsZa-LqHA-VVdDN1X8ej2_W6-JvjHk2E0C83ftKLYQ@mail.gmail.com>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3700002634517437230==
Content-Type: multipart/alternative; boundary=f403045df056bf970e054c994abf

--f403045df056bf970e054c994abf
Content-Type: text/plain; charset=UTF-8

Phil,

This relates to my previous question about multi-process tracing. The
workaround I am attempting is to have each process write its own trace with
a single stream, but then to pull all the stream files together into a
single trace with one metadata file. For this reason the uuids would need
to match.

Do you think this will work?

Rocky

On Apr 7, 2017 1:57 PM, "Philippe Proulx" <eeppeliteloop@gmail.com> wrote:

> On Fri, Apr 7, 2017 at 3:18 PM, Rocky Dunlap <rsdunlapiv@gmail.com> wrote:
> > Is it possible to explicitly set a uuid for a trace using the Babeltrace
> CTF
> > writer?  I did not see a straightforward way to do it with the API.
>
> It's not possible as of Babeltrace 1. We'll add trace UUID accessors to
> the upcoming Babeltrace 2 API.
>
> That said, may I ask you why you need this? Two different CTF traces
> should not share the same UUID.
>
> Phil
>
> >
> > Rocky
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--f403045df056bf970e054c994abf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Phil,<div dir=3D"auto"><br></div><div dir=3D"auto">This r=
elates to my previous question about multi-process tracing. The workaround =
I am attempting is to have each process write its own trace with a single s=
tream, but then to pull all the stream files together into a single trace w=
ith one metadata file. For this reason the uuids would need to match.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Do you think this will work?<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Rocky</div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Apr 7, 2017 1:57 PM, =
&quot;Philippe Proulx&quot; &lt;<a href=3D"mailto:eeppeliteloop@gmail.com">=
eeppeliteloop@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On Fri, Apr 7, 2017 at 3:18 PM, Rocky Dunlap &lt;<a href=
=3D"mailto:rsdunlapiv@gmail.com">rsdunlapiv@gmail.com</a>&gt; wrote:<br>
&gt; Is it possible to explicitly set a uuid for a trace using the Babeltra=
ce CTF<br>
&gt; writer?=C2=A0 I did not see a straightforward way to do it with the AP=
I.<br>
<br>
It&#39;s not possible as of Babeltrace 1. We&#39;ll add trace UUID accessor=
s to<br>
the upcoming Babeltrace 2 API.<br>
<br>
That said, may I ask you why you need this? Two different CTF traces<br>
should not share the same UUID.<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt; Rocky<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
&gt;<br>
</blockquote></div></div>

--f403045df056bf970e054c994abf--

--===============3700002634517437230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3700002634517437230==--
