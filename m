From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Is lttng reliable enough to use it for billing
 component
Date: Thu, 13 Sep 2018 14:30:59 -0400 (EDT)
Message-ID: <1420145716.3048.1536863459551.JavaMail.zimbra__8809.20250569961$1536863351$gmane$org@efficios.com>
References: <CAD6O9aofSMdi6FpgUCKuVmQpsk=Ymu+skoWaae3T5XWa-SaR2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4167283443890908285=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42B6fg2XzCzxTy
 for <lttng-dev@lists.lttng.org>; Thu, 13 Sep 2018 14:31:07 -0400 (EDT)
In-Reply-To: <CAD6O9aofSMdi6FpgUCKuVmQpsk=Ymu+skoWaae3T5XWa-SaR2g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: syed zaidi <zaidi1039@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mhatre abhay <Mhatre.abhay@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============4167283443890908285==
Content-Type: multipart/alternative;
	boundary="=_5a746519-3711-483b-8181-c47b044ab7c6"

--=_5a746519-3711-483b-8181-c47b044ab7c6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

----- On Sep 11, 2018, at 8:59 PM, syed zaidi <zaidi1039@gmail.com> wrote: 

> Hey guys,
> I am trying to evaluate if lttng is reliable enough to be used as a source for
> billing component? The main demand here is to make sure that we don't lose any
> traces and have a way to recover from failures for example the session dying
> unexpectedly.
> Please guide me if its a good idea or not to use lttng in this scenario.

LTTng has not been designed with those use-cases in mind, so chances are that it will 
not provide the kind of recovery from failures and "don't lose any data" types of 
guarantees you are looking for. 

Buffering tracing data for system monitoring/debugging has a different set of 
requirements compared to your use-case. 

Thanks, 

Mathieu 

> Thanks
> Ammar

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_5a746519-3711-483b-8181-c47b044ab7c6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Sep 11, =
2018, at 8:59 PM, syed zaidi &lt;zaidi1039@gmail.com&gt; wrote:<br></span><=
/div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt;"><div dir=3D"ltr">Hey guys,<div>I am trying to eva=
luate if lttng is reliable enough to be used as a source for billing compon=
ent? The main demand here is to make sure that we don't lose any traces and=
 have a way to recover from failures for example the session dying unexpect=
edly.</div><div>Please guide me if its a good idea or not to use lttng in t=
his scenario.</div></div></blockquote><div><div><br data-mce-bogus=3D"1"></=
div><div>LTTng has not been designed with those use-cases in mind, so chanc=
es are that it will</div><div>not provide the kind of recovery from failure=
s and "don't lose any data" types of</div><div>guarantees you are looking f=
or.</div></div><div><br data-mce-bogus=3D"1"></div><div>Buffering tracing d=
ata for system monitoring/debugging has a different set of<br data-mce-bogu=
s=3D"1"></div><div>requirements compared to your use-case.<br data-mce-bogu=
s=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>Thanks<=
/div><div>Ammar</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_5a746519-3711-483b-8181-c47b044ab7c6--

--===============4167283443890908285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4167283443890908285==--
