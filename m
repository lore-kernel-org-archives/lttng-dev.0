From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: thread context for call_rcu?
Date: Thu, 15 Dec 2016 10:27:35 +0000 (UTC)
Message-ID: <1428765952.41379.1481797655865.JavaMail.zimbra__42119.1901820295$1481797545$gmane$org@efficios.com>
References: <CACMVCQ17W5fitJdChAO3vTdRBNvTW1tfhEL4Pha62UAXSn-0MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1601311347964483331=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3tfV4z5Rcbzv6H
 for <lttng-dev@lists.lttng.org>; Thu, 15 Dec 2016 10:27:47 +0000 (UTC)
In-Reply-To: <CACMVCQ17W5fitJdChAO3vTdRBNvTW1tfhEL4Pha62UAXSn-0MA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Peter Morreale <pwmorreale@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============1601311347964483331==
Content-Type: multipart/alternative;
	boundary="=_0e217b8a-10d3-4c33-89c5-71538344a6c7"

--=_0e217b8a-10d3-4c33-89c5-71538344a6c7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Dec 14, 2016, at 7:47 PM, Peter Morreale <pwmorreale@gmail.com> wrote: 

> Is there anyway for a routine to determine whether it is executing in a call_rcu
> thread context?
> (ao as to avoid nested call_rcu() calls?)

Not currently. Can you tell us more about your intended use-case ? 

Thanks, 

Mathieu 

> Thx
> -PWM

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_0e217b8a-10d3-4c33-89c5-71538344a6c7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Dec 14, 2016, at 7:47 PM, Peter Morreale &lt;pwmorreale@gmail.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><=
div><div><br>Is there anyway for a routine to determine whether it is execu=
ting in a call_rcu thread context?<br></div>(ao as to avoid nested call_rcu=
() calls?)</div></div></div></blockquote><div><br></div><div>Not currently.=
 Can you tell us more about your intended use-case ?<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"b=
order-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div><br><br></d=
iv>Thx<br></div>-PWM<br></div><br>_________________________________________=
______<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div=
><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desn=
oyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_0e217b8a-10d3-4c33-89c5-71538344a6c7--

--===============1601311347964483331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1601311347964483331==--
