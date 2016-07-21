From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Practical recommendation for max update rate with
 QSBR
Date: Thu, 21 Jul 2016 21:58:29 +0000 (UTC)
Message-ID: <1787099143.77815.1469138309989.JavaMail.zimbra__10414.0601157726$1469138344$gmane$org@efficios.com>
References: <1733955808.5920250.1465238884157.JavaMail.yahoo.ref@mail.yahoo.com>
 <1733955808.5920250.1465238884157.JavaMail.yahoo@mail.yahoo.com>
 <188943617.29620.1465243726034.JavaMail.zimbra@efficios.com>
 <897997834.5701164.1465244342476.JavaMail.yahoo@mail.yahoo.com>
 <208245300.3358603.1469134061370.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6461805774360265799=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C30DBA2B52
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jul 2016 21:58:35 +0000 (UTC)
In-Reply-To: <208245300.3358603.1469134061370.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Mark E. Dawson" <medawsonjr@yahoo.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6461805774360265799==
Content-Type: multipart/alternative;
	boundary="----=_Part_77814_410983378.1469138309988"

------=_Part_77814_410983378.1469138309988
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jul 21, 2016, at 4:47 PM, Mark E. Dawson <medawsonjr@yahoo.com> wrote: 

> All,

> I've read the documentation regarding reader throughput drop-offs with high
> update rates due to the pointer exchanging between readers-writers, and the
> general admonition of using URCU only for mostly-read workloads with relatively
> infrequent updates.

> However, is there a general rule-of-thumb suggestion for highest recommended
> update rate sustainable for optimal performance with URCU (in particular, the
> QSBR flavor) for highly threaded applications deployed on high core count
> machines (Intel)? The example case would be a single updater and 20 - 30 reader
> threads.

Hi Mark, 

We have some relevant measurements in the supplementary material of: 

Desnoyers, Mathieu, McKenney, Paul. E., Stern, Alan S., Dagenais, Michel R. and Walpole, Jonathan, User-Level Implementations of Read-Copy Update . IEEE Transaction on Parallel and Distributed Systems , 23 (2): 375-382 (2012). 

A copy can be found at http://www.efficios.com/publications 

See p. 10 of supplementary material, Fig. 14: 

"Comparison of Pointer Exchange and Ideal RCU Update Overhead, 8-core Intel Xeon, Logarithmic Scale" 

Since you are doing pointer exchange, you will want to look at the "QSBR" 
line, which stays at 1000M reads/s up to 100000 updates/s, and then starts 
dropping. 

On the 64-core POWER5+ (Fig. 15), read speed starts dropping near 100000 
updates/s too. 

Thanks, 

Mathieu 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_77814_410983378.1469138309988
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 21, 2016, at 4:47 PM, Mark E. Dawson &lt;medawsonjr@yahoo.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"color:#00=
0; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvet=
ica, Arial, Lucida Grande, sans-serif;font-size:16px"><div id=3D"yui_3_16_0=
_ym19_1_1469131414329_10925">All,</div><div id=3D"yui_3_16_0_ym19_1_1469131=
414329_10925"><br></div><div id=3D"yui_3_16_0_ym19_1_1469131414329_10925">I=
've read the documentation regarding reader throughput drop-offs with high =
update rates due to the pointer exchanging between readers-writers, and the=
 general admonition of using URCU only for mostly-read workloads with relat=
ively infrequent updates.</div><div id=3D"yui_3_16_0_ym19_1_1469131414329_1=
0925"><br></div><div id=3D"yui_3_16_0_ym19_1_1469131414329_10925">However, =
is there a general rule-of-thumb suggestion for highest recommended update =
rate sustainable for optimal performance with URCU (in particular, the QSBR=
 flavor) for highly threaded applications deployed on high core count machi=
nes (Intel)? The example case would be a single updater and 20 - 30 reader =
threads.</div></div></blockquote><div><br></div><div>Hi Mark,<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>We have some rele=
vant measurements in the supplementary material of:<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>Desnoyers, Mathieu, McKenne=
y, Paul. E., Stern, Alan S., Dagenais, Michel R. and Walpole, Jonathan, <em=
>User-Level Implementations of Read-Copy Update</em>. <a href=3D"http://www=
.computer.org/portal/web/tpds/" data-mce-href=3D"http://www.computer.org/po=
rtal/web/tpds/">IEEE Transaction on Parallel and Distributed Systems</a>, 2=
3 (2): 375-382 (2012).</div><div><br data-mce-bogus=3D"1"></div><div>A copy=
 can be found at http://www.efficios.com/publications<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>See p. 10 of supplementar=
y material,&nbsp; Fig. 14:<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><div>"Comparison of Pointer Exchange and Ideal RCU Update=
 Overhead, 8-core Intel Xeon, Logarithmic Scale"<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div>Since you are doing pointer exchang=
e, you will want to look at the "QSBR"</div><div data-marker=3D"__QUOTED_TE=
XT__">line, which stays at 1000M reads/s up to 100000 updates/s, and then s=
tarts</div><div data-marker=3D"__QUOTED_TEXT__">dropping.</div><div data-ma=
rker=3D"__QUOTED_TEXT__"><br data-mce-bogus=3D"1"></div><div data-marker=3D=
"__QUOTED_TEXT__">On the 64-core POWER5+ (Fig. 15), read speed starts dropp=
ing near 100000</div><div data-marker=3D"__QUOTED_TEXT__">updates/s too.<br=
 data-mce-bogus=3D"1"></div><div data-marker=3D"__QUOTED_TEXT__"><br data-m=
ce-bogus=3D"1"></div><div data-marker=3D"__QUOTED_TEXT__">Thanks,</div><div=
 data-marker=3D"__QUOTED_TEXT__"><br data-mce-bogus=3D"1"></div><div data-m=
arker=3D"__QUOTED_TEXT__">Mathieu<br><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;">_______________________________________________<br>ltt=
ng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><d=
iv data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Effi=
ciOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_77814_410983378.1469138309988--

--===============6461805774360265799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6461805774360265799==--
