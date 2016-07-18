From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: URCU C++ wrapper?
Date: Mon, 18 Jul 2016 15:17:09 +0000 (UTC)
Message-ID: <1617651200.73768.1468855029639.JavaMail.zimbra__18.2940777905927$1468855063$gmane$org@efficios.com>
References: <CACNseid7w-nSAOJvGph1P6_nGroMPHqUT_oJAp+x_Y5_MCmmgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2988377068449407645=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 64848A3BFA
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2016 15:17:14 +0000 (UTC)
In-Reply-To: <CACNseid7w-nSAOJvGph1P6_nGroMPHqUT_oJAp+x_Y5_MCmmgA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: noam cohen <noam1023@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2988377068449407645==
Content-Type: multipart/alternative;
	boundary="----=_Part_73767_1145114918.1468855029638"

------=_Part_73767_1145114918.1468855029638
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 17, 2016, at 2:25 AM, noam cohen <noam1023@gmail.com> wrote: 

> Hi
> Has anyone created a c++ wrapper to the hashtable?
> If not, I will try to roll my own and give back as a pull request.

There are extern "C" guards around the rculfhash.h header. This should 
allow you to use rculfhash from C++ code. Do you have something else 
in mind ? 

Thanks, 

Mathieu 

> Thanks
> Noam C

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_73767_1145114918.1468855029638
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><span id=3D"zwchr" data-mark=
er=3D"__DIVIDER__">----- On Jul 17, 2016, at 2:25 AM, noam cohen &lt;noam10=
23@gmail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__=
"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddin=
g-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:=
none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"lt=
r">Hi<div>Has anyone created a c++ wrapper to the hashtable?</div><div>If n=
ot, I will try to roll my own and give back as a pull request.</div></div><=
/blockquote><div><br></div><div>There are extern "C" guards around the rcul=
fhash.h header. This should<br data-mce-bogus=3D"1"></div><div>allow you to=
 use rculfhash from C++ code. Do you have something else<br data-mce-bogus=
=3D"1"></div><div>in mind ?<br data-mce-bogus=3D"1"></div><div><br data-mce=
-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data=
-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010=
FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;"><div dir=3D"ltr"><br><div>Thanks</div><div>Noam C</div></div><br=
>_______________________________________________<br>lttng-dev mailing list<=
br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__=
SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://=
www.efficios.com</div></div></body></html>
------=_Part_73767_1145114918.1468855029638--

--===============2988377068449407645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2988377068449407645==--
