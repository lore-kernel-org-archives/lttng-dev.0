From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: ctf writer tests were moved to
	test_python_babeltrace
Date: Mon, 18 Sep 2017 17:25:37 -0400
Message-ID: <1505769937-22584-1-git-send-email-mjeanson__8017.30313473872$1505769960$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xwzZS0SyhzDNJ
 for <lttng-dev@lists.lttng.org>; Mon, 18 Sep 2017 21:25:51 +0000 (UTC)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0t
LQogdGVzdHMvTWFrZWZpbGUuYW0gfCA2IC0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvTWFrZWZpbGUuYW0gYi90ZXN0cy9NYWtlZmlsZS5h
bQppbmRleCBmOWMyMDdmLi5lZTBkNzA2IDEwMDY0NAotLS0gYS90ZXN0cy9NYWtlZmlsZS5hbQor
KysgYi90ZXN0cy9NYWtlZmlsZS5hbQpAQCAtMzgsMTIgKzM4LDYgQEAgVEVTVFNfTElCID0gXAog
CWxpYi90ZXN0X2NjX3ByaW9fbWFwIFwKIAlsaWIvdGVzdF9idF9ub3RpZmljYXRpb25faXRlcmF0
b3IKIAotaWYgRU5BQkxFX1BZVEhPTl9CSU5ESU5HUwotVEVTVFNfTElCICs9IFwKLQlsaWIvd3Jp
dGVyL3Rlc3RfY3RmX3dyaXRlcl9ub19wYWNrZXRfY29udGV4dC5weSBcCi0JbGliL3dyaXRlci90
ZXN0X2N0Zl93cml0ZXJfZW1wdHlfcGFja2V0LnB5Ci1lbmRpZgotCiBpZiAhRU5BQkxFX0JVSUxU
X0lOX1BMVUdJTlMKIFRFU1RTX0xJQiArPSBsaWIvdGVzdF9wbHVnaW5fY29tcGxldGUKIGVuZGlm
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
