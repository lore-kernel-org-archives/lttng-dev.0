From: Peter Morreale <pwmorreale@gmail.com>
Subject: thread context for call_rcu?
Date: Wed, 14 Dec 2016 11:47:54 -0700
Message-ID: <CACMVCQ17W5fitJdChAO3vTdRBNvTW1tfhEL4Pha62UAXSn-0MA__34483.6953365759$1481741288$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3989497609199476291=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 3tf5H24FLDztWF
 for <lttng-dev@lists.lttng.org>; Wed, 14 Dec 2016 18:50:06 +0000 (UTC)
Received: by mail-oi0-x22b.google.com with SMTP id y198so29650465oia.1
 for <lttng-dev@lists.lttng.org>; Wed, 14 Dec 2016 10:47:56 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3989497609199476291==
Content-Type: multipart/alternative; boundary=94eb2c1920a658654a0543a2c6a9

--94eb2c1920a658654a0543a2c6a9
Content-Type: text/plain; charset=UTF-8

Is there anyway for a routine to determine whether it is executing in a
call_rcu thread context?
(ao as to avoid nested call_rcu() calls?)

Thx
-PWM

--94eb2c1920a658654a0543a2c6a9
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><div><div><div><div><br></div>Is there anyway for a routine to determine whether it is executing in a call_rcu thread context?<br></div>(ao as to avoid nested call_rcu() calls?)<br><br></div>Thx<br></div>-PWM<br></div>

--94eb2c1920a658654a0543a2c6a9--

--===============3989497609199476291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3989497609199476291==--
