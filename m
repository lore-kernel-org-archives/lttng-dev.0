From: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Subject: Removing timing overhead via tracepoint()
Date: Mon, 26 Sep 2016 18:32:50 +0000 (UTC)
Message-ID: <44700566.4933962.1474914770059__27253.3365911388$1474914786$gmane$org@mail.yahoo.com>
References: <44700566.4933962.1474914770059.ref@mail.yahoo.com>
Reply-To: "Mark E. Dawson, Jr." <medawsonjr@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7778857950874802476=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm34-vm8.bullet.mail.bf1.yahoo.com
 (nm34-vm8.bullet.mail.bf1.yahoo.com [72.30.239.6])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id ADE73A2B81
 for <lttng-dev@lists.lttng.org>; Mon, 26 Sep 2016 18:34:11 +0000 (UTC)
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

--===============7778857950874802476==
Content-Type: multipart/alternative;
	boundary="----=_Part_4933961_1319111101.1474914770057"

------=_Part_4933961_1319111101.1474914770057
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All,
Simple question alert!
If I want to remove a ton of compiled-in calls to an "rdtscp-based" C timing function and replace them with conditionally-enabled timing based on whether or not I enable a tracing session, I can do so by adding the aforementioned call as one of the arguments to tracepoint() with our defined provider and event name, correct?
------=_Part_4933961_1319111101.1474914770057
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head></head><body><div style="color:#000; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px"><div id="yui_3_16_0_ym19_1_1474914422310_4680">All,</div><div id="yui_3_16_0_ym19_1_1474914422310_4680"><br></div><div id="yui_3_16_0_ym19_1_1474914422310_4680" dir="ltr">Simple question alert!</div><div id="yui_3_16_0_ym19_1_1474914422310_4680" dir="ltr"><br></div><div id="yui_3_16_0_ym19_1_1474914422310_4680" dir="ltr">If I want to remove a ton of compiled-in calls to an "rdtscp-based" C timing function and replace them with conditionally-enabled timing based on whether or not I enable a tracing session, I can do so by adding the aforementioned call as one of the arguments to tracepoint() with our defined provider a
 nd event name, correct?</div></div></body></html>
------=_Part_4933961_1319111101.1474914770057--

--===============7778857950874802476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7778857950874802476==--
