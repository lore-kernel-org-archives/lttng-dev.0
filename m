From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Update kvm instrumentation for
	debian kernel 4.14.0-3
Date: Tue, 30 Jan 2018 16:48:36 -0500
Message-ID: <1517348916-5875-1-git-send-email-mjeanson__29704.6282481917$1517348846$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3zWKl068NXzCmq
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jan 2018 21:48:44 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6E8B234034E
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jan 2018 21:49:17 +0000 (UTC)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmggfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9l
dmVudHMvbHR0bmctbW9kdWxlL2t2bS5oIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1t
b2R1bGUva3ZtLmgKaW5kZXggZmJkNjAzYi4uOWJiZjk1ZiAxMDA2NDQKLS0tIGEvaW5zdHJ1bWVu
dGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2
ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKQEAgLTg2LDYgKzg2LDcgQEAgTFRUTkdfVFJBQ0VQT0lO
VF9FVkVOVChrdm1fYWNrX2lycSwKIAogI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVM
X1ZFUlNJT04oNCwxNSwwKSBcCiAJfHwgTFRUTkdfS0VSTkVMX1JBTkdFKDQsMTQsMTQsIDQsMTUs
MCkgXAorCXx8IExUVE5HX0RFQklBTl9LRVJORUxfUkFOR0UoNCwxNCwxMywwLDEsMCwgNCwxNSww
LDAsMCwwKSBcCiAJfHwgTFRUTkdfS0VSTkVMX1JBTkdFKDQsOSw3NywgNCwxMCwwKSBcCiAJfHwg
TFRUTkdfS0VSTkVMX1JBTkdFKDQsNCwxMTIsIDQsNSwwKSBcCiAJfHwgTFRUTkdfS0VSTkVMX1JB
TkdFKDMsMTYsNTIsIDMsMTcsMCkgXAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
