From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: update ringbuffer for kernel
	4.12
Date: Tue, 23 May 2017 15:45:47 -0400
Message-ID: <1495568747-29103-1-git-send-email-mjeanson__33153.0941337862$1495568793$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXQyw6K5pzyh8
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 19:47:04 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 54A8A340263
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 19:47:04 +0000 (UTC)
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

ZmxhZ3MgcmVtb3ZlZCBmcm9tIHNwbGljZV9waXBlX2Rlc2MgaW4gNC4xMi4KClNlZSB1cHN0cmVh
bSBjb21taXQgZjgxZGM3ZDdkNWEyNTI4Zjk4ZjI2YTBiOTQwNmU4MjJkMGIzNTAxMQoKU2lnbmVk
LW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+Ci0tLQogbGli
L3JpbmdidWZmZXIvcmluZ19idWZmZXJfc3BsaWNlLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGliL3JpbmdidWZmZXIvcmluZ19idWZmZXJf
c3BsaWNlLmMgYi9saWIvcmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9zcGxpY2UuYwppbmRleCAwNjEw
Y2FhLi44ZDE0NjY2IDEwMDY0NAotLS0gYS9saWIvcmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9zcGxp
Y2UuYworKysgYi9saWIvcmluZ2J1ZmZlci9yaW5nX2J1ZmZlcl9zcGxpY2UuYwpAQCAtOTUsNyAr
OTUsOSBAQCBzdGF0aWMgaW50IHN1YmJ1Zl9zcGxpY2VfYWN0b3Ioc3RydWN0IGZpbGUgKmluLAog
CQkucGFnZXMgPSBwYWdlcywKIAkJLm5yX3BhZ2VzID0gMCwKIAkJLnBhcnRpYWwgPSBwYXJ0aWFs
LAorI2lmIChMSU5VWF9WRVJTSU9OX0NPREUgPCBLRVJORUxfVkVSU0lPTig0LDEyLDApKQogCQku
ZmxhZ3MgPSBmbGFncywKKyNlbmRpZgogCQkub3BzID0gJnJpbmdfYnVmZmVyX3BpcGVfYnVmX29w
cywKIAkJLnNwZF9yZWxlYXNlID0gbGliX3JpbmdfYnVmZmVyX3BhZ2VfcmVsZWFzZSwKIAl9Owot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczov
L2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
