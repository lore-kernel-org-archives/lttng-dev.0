From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: version check error in btrfs
	instrumentation
Date: Fri, 29 Sep 2017 16:40:36 -0400
Message-ID: <1506717636-1429-1-git-send-email-mjeanson__40289.9283719764$1506717650$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y3k3H2H2szsfv
 for <lttng-dev@lists.lttng.org>; Fri, 29 Sep 2017 20:40:42 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BF9C63403DA
 for <lttng-dev@lists.lttng.org>; Fri, 29 Sep 2017 20:41:58 +0000 (UTC)
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
LQogaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYnRyZnMuaCB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2J0cmZzLmggYi9pbnN0cnVtZW50
YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9idHJmcy5oCmluZGV4IDQ4YjdjYWUuLmI1MjllOGUg
MTAwNjQ0Ci0tLSBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2J0cmZzLmgK
KysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvYnRyZnMuaApAQCAtOTgw
LDcgKzk4MCw3IEBAIExUVE5HX1RSQUNFUE9JTlRfRVZFTlRfSU5TVEFOQ0UoYnRyZnNfX3Jlc2Vy
dmVkX2V4dGVudCwgIGJ0cmZzX3Jlc2VydmVkX2V4dGVudF9mCiAKICNlbmRpZiAvKiAjZWxzZSAj
aWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEwLDApKSAqLwogCi0j
aWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig0LDEwLDApKQorI2lmIChM
SU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxNCwwKSkKIAogTFRUTkdfVFJB
Q0VQT0lOVF9FVkVOVF9NQVAoZmluZF9mcmVlX2V4dGVudCwKIAotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
