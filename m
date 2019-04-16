From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: SIG33 message
Date: Tue, 16 Apr 2019 13:40:29 -0400 (EDT)
Message-ID: <194380388.2153.1555436429530.JavaMail.zimbra__33089.9098351196$1555436482$gmane$org@efficios.com>
References: <CAJyWpKFdOV6uiwWUicD5GNSSjWsD1TXjn=p45p_g6xu7F3HJbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0803688709099391639=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44kCM245Lmz1Kc5
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 13:40:30 -0400 (EDT)
In-Reply-To: <CAJyWpKFdOV6uiwWUicD5GNSSjWsD1TXjn=p45p_g6xu7F3HJbQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mosleh Uddin <mosleh1235@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0803688709099391639==
Content-Type: multipart/alternative;
	boundary="=_1d38b1a7-21e2-42da-89b8-902419fe989f"

--=_1d38b1a7-21e2-42da-89b8-902419fe989f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 4, 2019, at 3:26 PM, Mosleh Uddin <mosleh1235@gmail.com> wrote: 

> Hello,
> I am building an application which I am compiling with the 'lttng-ust' flag.
> When I try to debug the application using gdb, I get a 'Suspended: Signal:
> SIG33:Real-time event 33' message. This only happens when I compile with the
> 'lttng-ust' flag, if I remove it I no longer have this issue. Any insight?

Hi, 

Based on the signal(7) man page, it appears that real-time signal 33 is used by the NPTL 
threading library from glibc. 

Indeed, lttng-ust creates 2 threads within the processes it's linked into, so 
your application needs to appropriately interact with glibc NPTL in order to link 
lttng-ust into it. 

Can you provide more details on the nature of your application ? What version 
of gdb do you use ? On which architecture ? 

Thanks, 

Mathieu 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_1d38b1a7-21e2-42da-89b8-902419fe989f
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Apr 4, 2019, at 3:26 PM, Mosleh Uddin &lt;mosleh1235@gmail.com=
&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hello,<br=
><div>I am building an application which I am compiling with the 'lttng-ust=
' flag. When I try to debug the application using gdb, I get a 'Suspended: =
Signal: SIG33:Real-time event 33' message. This only happens when I compile=
 with the 'lttng-ust' flag, if I remove it I no longer have this issue. Any=
 insight?</div><br></div></blockquote></div><div>Hi,<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>Based on the signal(7) man=
 page, it appears that real-time signal 33 is used by the NPTL<br data-mce-=
bogus=3D"1"></div><div>threading library from glibc.<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>Indeed, lttng-ust creates =
2 threads within the processes it's linked into, so<br data-mce-bogus=3D"1"=
></div><div>your application needs to appropriately interact with glibc NPT=
L in order to link<br data-mce-bogus=3D"1"></div><div>lttng-ust into it.<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Can yo=
u provide more details on the nature of your application ? What version<br =
data-mce-bogus=3D"1"></div><div>of gdb do you use ? On which architecture ?=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Tha=
nks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div=
>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><div data-marker=3D"__SIG_POST__">-- <b=
r></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<=
/div></div></body></html>
--=_1d38b1a7-21e2-42da-89b8-902419fe989f--

--===============0803688709099391639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0803688709099391639==--
