From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: sched for v4.11.5-rt1
Date: Mon, 10 Jul 2017 18:13:11 -0400
Message-ID: <1499724791-17165-1-git-send-email-mjeanson__1166.39172561026$1499724813$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3x5zzb389bz141D
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 22:15:06 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E42DB3401B0
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 22:14:31 +0000 (UTC)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaCB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQuaCBiL2luc3RydW1l
bnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL3NjaGVkLmgKaW5kZXggZTZmMzZiMS4uY2I1YjVi
MiAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvc2NoZWQu
aAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9zY2hlZC5oCkBAIC01
NDEsNyArNTQxLDggQEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVOVChzY2hlZF9zdGF0X3J1bnRpbWUs
CiAjZW5kaWYKIAogI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwx
MiwwKSB8fCBcCi0JTFRUTkdfUlRfS0VSTkVMX1JBTkdFKDQsOSwyNywxOCwgNCwxMCwwLDApKQor
CUxUVE5HX1JUX0tFUk5FTF9SQU5HRSg0LDksMjcsMTgsIDQsMTAsMCwwKSB8fCBcCisJTFRUTkdf
UlRfS0VSTkVMX1JBTkdFKDQsMTEsNSwxLCA0LDEyLDAsMCkpCiAvKgogICogVHJhY2Vwb2ludCBm
b3Igc2hvd2luZyBwcmlvcml0eSBpbmhlcml0YW5jZSBtb2RpZnlpbmcgYSB0YXNrcwogICogcHJp
b3JpdHkuCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
