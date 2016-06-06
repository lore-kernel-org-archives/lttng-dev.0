From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Subject: SPMC Queue in URCU
Date: Mon, 6 Jun 2016 18:48:04 +0000 (UTC)
Message-ID: <1733955808.5920250.1465238884157.JavaMail.yahoo__23520.4952689402$1465238913$gmane$org@mail.yahoo.com>
References: <1733955808.5920250.1465238884157.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1351713567363934858=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm50.bullet.mail.bf1.yahoo.com (nm50.bullet.mail.bf1.yahoo.com
 [216.109.114.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 35FA1A36D0
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 18:48:06 +0000 (UTC)
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

--===============1351713567363934858==
Content-Type: multipart/alternative;
	boundary="----=_Part_5920249_30267351.1465238884154"

------=_Part_5920249_30267351.1465238884154
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All,
Is there a data structure offered by Userspace RCU that provides a bounded single producer multiple consumer queue? Or are we better off just using the linked list URCU data structure despite the cpu cache implications?
------=_Part_5920249_30267351.1465238884154
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head></head><body><div style="color:#000; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px"><div id="yui_3_16_0_ym19_1_1465238402299_6084">All,</div><div id="yui_3_16_0_ym19_1_1465238402299_6084"><br></div><div id="yui_3_16_0_ym19_1_1465238402299_6084">Is there a data structure offered by Userspace RCU that provides a bounded single producer multiple consumer queue? Or are we better off just using the linked list URCU data structure despite the cpu cache implications?</div></div></body></html>
------=_Part_5920249_30267351.1465238884154--

--===============1351713567363934858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1351713567363934858==--
