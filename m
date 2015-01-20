From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: c/c++ wrappers for lttng commands
Date: Tue, 20 Jan 2015 17:55:30 +0530
Message-ID: <CAM5kDqxMireO=eTo9soCqBgw2t0b0ohafczjF7Tm4a0x4F1Eng__12966.1039136865$1421756782$gmane$org@mail.gmail.com>
References: <CAM5kDqy6L5nSvs=GYwmXTgHSE+uH5p0d8YPYGeR-_E61mr4TqA@mail.gmail.com>
 <CAFXXi0mntrDSz7j5CZKzm6o0KqU6hw1dF6E9HHEXyanYrHnsHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1435703031=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YDXsG-00021K-EX
 for lttng-dev@lists.lttng.org; Tue, 20 Jan 2015 07:25:39 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so2323954wiv.1
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jan 2015 04:25:30 -0800 (PST)
In-Reply-To: <CAFXXi0mntrDSz7j5CZKzm6o0KqU6hw1dF6E9HHEXyanYrHnsHA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1435703031==
Content-Type: multipart/alternative; boundary=047d7b624dfee49d56050d148863

--047d7b624dfee49d56050d148863
Content-Type: text/plain; charset=UTF-8

Hi All,
i'm writing a wrapper code to start and stop tracing sessions. And i am
using lttng-ctl library for this.
I have setup session using lttng commands and using the wrapper to
start/stop session.
in the wrapper i'm calling lttng_start_tracing(char* session_name), i see
that that the program gets stuck and doesnt return from lttng_start_tracing.
Does anyone know what is the issue i'm seeing. (before i can start
debugger). I see that lttng-ctl connects checks for sessiond and send some
data to it, suspect something here.

Thanks,
Anand Neeli


On Thu, Jan 15, 2015 at 12:54 AM, Simon Marchi <simon.marchi@polymtl.ca>
wrote:

> On 14 January 2015 at 14:02, Anand Neeli <anand.neeli@gmail.com> wrote:
> > Hi All,
> >
> > Is there any code (or did anyone implement) c/c++ wrappers API's to
> > create,delete, add event to lttng session.
> > The conventional way to create, add event, delete lttng sessions is
> through
> > lttng shell commands, i'm looking to do this using a c/c++ API's.
> >
> > Thanks,
> > Anand Neeli
>
> Hi Arnand,
>
> I think you are looking for the liblttng-ctl library.
>
> http://git.lttng.org/?p=lttng-tools.git;a=tree;f=src/lib/lttng-ctl;hb=HEAD
>
> It is the library that the lttng command is based on, but you can also
> use it in your program. I don't know if there is an official
> documentation, but if you want to know how to do something using the
> API, you can always look up the lttng command code and see what it
> does.
>
> It is in C, however. If you want to make an wrapper that is more C++
> oriented, I am sure it would be a very appreciated contribution :).
>
> Simon
>

--047d7b624dfee49d56050d148863
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>i&#39;m writing a wrapper code to start and st=
op tracing sessions. And i am using lttng-ctl library for this.</div><div>I=
 have setup session using lttng commands and using the wrapper to start/sto=
p session.</div><div>in the wrapper i&#39;m calling lttng_start_tracing(cha=
r* session_name), i see that that the program gets stuck and doesnt return =
from lttng_start_tracing.<br></div><div>Does anyone know what is the issue =
i&#39;m seeing. (before i can start debugger). I see that lttng-ctl connect=
s checks for sessiond and send some data to it, suspect something here.</di=
v><div><br></div><div>Thanks,</div><div>Anand Neeli</div><div><br></div></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jan 15=
, 2015 at 12:54 AM, Simon Marchi <span dir=3D"ltr">&lt;<a href=3D"mailto:si=
mon.marchi@polymtl.ca" target=3D"_blank">simon.marchi@polymtl.ca</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div cl=
ass=3D"h5">On 14 January 2015 at 14:02, Anand Neeli &lt;<a href=3D"mailto:a=
nand.neeli@gmail.com">anand.neeli@gmail.com</a>&gt; wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; Is there any code (or did anyone implement) c/c++ wrappers API&#39;s t=
o<br>
&gt; create,delete, add event to lttng session.<br>
&gt; The conventional way to create, add event, delete lttng sessions is th=
rough<br>
&gt; lttng shell commands, i&#39;m looking to do this using a c/c++ API&#39=
;s.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Anand Neeli<br>
<br>
</div></div>Hi Arnand,<br>
<br>
I think you are looking for the liblttng-ctl library.<br>
<br>
<a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dtree;f=3Dsrc/lib/l=
ttng-ctl;hb=3DHEAD" target=3D"_blank">http://git.lttng.org/?p=3Dlttng-tools=
.git;a=3Dtree;f=3Dsrc/lib/lttng-ctl;hb=3DHEAD</a><br>
<br>
It is the library that the lttng command is based on, but you can also<br>
use it in your program. I don&#39;t know if there is an official<br>
documentation, but if you want to know how to do something using the<br>
API, you can always look up the lttng command code and see what it<br>
does.<br>
<br>
It is in C, however. If you want to make an wrapper that is more C++<br>
oriented, I am sure it would be a very appreciated contribution :).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Simon<br>
</font></span></blockquote></div><br></div>

--047d7b624dfee49d56050d148863--


--===============1435703031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1435703031==--
