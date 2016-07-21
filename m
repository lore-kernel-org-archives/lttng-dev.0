From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Subject: Practical recommendation for max update rate with QSBR
Date: Thu, 21 Jul 2016 20:47:41 +0000 (UTC)
Message-ID: <208245300.3358603.1469134061370.JavaMail.yahoo__24491.2670380019$1469134106$gmane$org@mail.yahoo.com>
References: <1733955808.5920250.1465238884157.JavaMail.yahoo.ref@mail.yahoo.com>
 <1733955808.5920250.1465238884157.JavaMail.yahoo@mail.yahoo.com>
 <188943617.29620.1465243726034.JavaMail.zimbra@efficios.com>
 <897997834.5701164.1465244342476.JavaMail.yahoo@mail.yahoo.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3642239947226065849=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm9-vm0.bullet.mail.bf1.yahoo.com
 (nm9-vm0.bullet.mail.bf1.yahoo.com [98.139.213.154])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 223B2A2B5B
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jul 2016 20:47:57 +0000 (UTC)
In-Reply-To: <897997834.5701164.1465244342476.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3642239947226065849==
Content-Type: multipart/alternative;
	boundary="----=_Part_3358602_1614967075.1469134061368"

------=_Part_3358602_1614967075.1469134061368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All,
I've read the documentation regarding reader throughput drop-offs with high update rates due to the pointer exchanging between readers-writers, and the general admonition of using URCU only for mostly-read workloads with relatively infrequent updates.
However, is there a general rule-of-thumb suggestion for highest recommended update rate sustainable for optimal performance with URCU (in particular, the QSBR flavor) for highly threaded applications deployed on high core count machines (Intel)? The example case would be a single updater and 20 - 30 reader threads.
------=_Part_3358602_1614967075.1469134061368
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_ym19_1_1469131414329_10925=
">All,</div><div id=3D"yui_3_16_0_ym19_1_1469131414329_10925"><br></div><di=
v id=3D"yui_3_16_0_ym19_1_1469131414329_10925">I've read the documentation =
regarding reader throughput drop-offs with high update rates due to the poi=
nter exchanging between readers-writers, and the general admonition of usin=
g URCU only for mostly-read workloads with relatively infrequent updates.</=
div><div id=3D"yui_3_16_0_ym19_1_1469131414329_10925"><br></div><div id=3D"=
yui_3_16_0_ym19_1_1469131414329_10925">However, is there a general rule-of-=
thumb suggestion for highest recommended update rate sustainable for optima=
l performance with URCU (in particular, the QSBR flavor) for highly threade=
d applications deployed on high core count machines (Intel)? The example ca=
se would be a single updater and 20 - 30 reader threads.</div></div></body>=
</html>
------=_Part_3358602_1614967075.1469134061368--

--===============3642239947226065849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3642239947226065849==--
