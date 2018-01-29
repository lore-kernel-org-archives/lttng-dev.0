From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: statically linking liblttng
Date: Mon, 29 Jan 2018 17:00:36 +0000 (UTC)
Message-ID: <1988871731.11498.1517245236733.JavaMail.zimbra__41616.2237096161$1517245121$gmane$org@efficios.com>
References: <CAKOJUhQSk9YZsSvUiGV_u0C0YT43KvFVTBNwAR861m4-=LWa9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1861478224189859333=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zVbNY5yhKzC5q
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jan 2018 17:00:13 +0000 (UTC)
In-Reply-To: <CAKOJUhQSk9YZsSvUiGV_u0C0YT43KvFVTBNwAR861m4-=LWa9Q@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: pedro e pinto <pedro.e.pinto@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1861478224189859333==
Content-Type: multipart/alternative;
	boundary="=_976cb2d1-4620-456d-bf1e-a432fa7ad31d"

--=_976cb2d1-4620-456d-bf1e-a432fa7ad31d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jan 29, 2018, at 8:56 AM, pedro pinto <pedro.e.pinto@gmail.com> wrote: 

> Hi there. I would like to instrument a C++ statically linked application using
> the lttng static libraries (i.e. libllttng-ust.a, etc). To try to get this
> working I took the quick start example and changed it to use the following link
> command line:

> gcc -o hello hello.o hello-tp.o -Wl,-Bstatic -llttng-ust -llttng-ust-tracepoint
> -lurcu-bp -lurcu-cds -Wl,-Bdynamic -lrt -ldl -pthread

> This does not return any errors but the resulting trace is empty. I was able to
> get a trace using the liblttng shared object though.

> Is it possible to statically link liblttng ? I am using v2.9.5 of lttng

Static linking of lttng-ust is not supported. For a start, the library constructors are not 
executed in a statically linked library. 

Thanks, 

Mathieu 

> Thanks in advance!

> -pp

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_976cb2d1-4620-456d-bf1e-a432fa7ad31d
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jan 29, 2018, at 8:56 AM, pedro pinto &lt;pedro.e.pinto@gmail.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div>H=
i there. I would like to instrument a C++ statically linked application usi=
ng the lttng static libraries (i.e. libllttng-ust.a, etc). To try to get th=
is working I took the quick start example and changed it to use the followi=
ng link command line:&nbsp;</div><br><div>gcc -o hello hello.o hello-tp.o -=
Wl,-Bstatic -llttng-ust -llttng-ust-tracepoint -lurcu-bp -lurcu-cds -Wl,-Bd=
ynamic -lrt -ldl -pthread&nbsp;</div><br><div><div>This does not return any=
 errors but the resulting trace is empty. I was able to get a trace using t=
he liblttng shared object though.<br></div></div><br><div>Is it possible to=
 statically link liblttng ? I am using v2.9.5 of lttng</div></div></blockqu=
ote><div>Static linking of lttng-ust is not supported. For a start, the lib=
rary constructors are not<br></div><div>executed in a statically linked lib=
rary.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddin=
g-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:=
none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"lt=
r"><br><div>Thanks in advance!</div><br><div>-pp</div><br><br><br><br></div=
><br>_______________________________________________<br>lttng-dev mailing l=
ist<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=
=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>h=
ttp://www.efficios.com</div></div></body></html>
--=_976cb2d1-4620-456d-bf1e-a432fa7ad31d--

--===============1861478224189859333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1861478224189859333==--
