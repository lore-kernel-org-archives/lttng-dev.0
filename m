From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 1/2] Fix: update block
	instrumentation for SuSE 4.4.73-5
Date: Tue, 23 Jan 2018 16:03:24 -0500
Message-ID: <1516741405-21961-1-git-send-email-mjeanson__22072.2807957374$1516741307$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zR14564d3zsL2
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jan 2018 21:03:33 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AFF0C340237
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jan 2018 21:03:55 +0000 (UTC)
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

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYmxvY2suaCB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYmxvY2suaCBiL2luc3RydW1l
bnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2Jsb2NrLmgKaW5kZXggNzY5MmNjYi4uNTYyMDg3
YiAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYmxvY2su
aAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9ibG9jay5oCkBAIC0z
Myw3ICszMyw4IEBAIGVudW0gewogCiAjZW5kaWYgLyogX1RSQUNFX0JMT0NLX0RFRl8gKi8KIAot
I2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCw4LDApKQorI2lmIChM
SU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCw4LDApIHx8IFwKKwlMVFROR19T
TEVfS0VSTkVMX1JBTkdFKDQsNCw3Myw1LDAsMCwgNCw1LDAsMCwwLDApKQogCiAjZGVmaW5lIGx0
dG5nX3JlcV9vcChycSkJcmVxX29wKHJxKQogI2RlZmluZSBsdHRuZ19yZXFfcncocnEpCSgocnEp
LT5jbWRfZmxhZ3MpCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
