From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: null dereference on error path
	for create_ctx_type
Date: Tue, 17 Jan 2017 10:08:47 -0500
Message-ID: <1484665727-24204-1-git-send-email-jonathan.rajotte-julien__21664.768344681$1484665764$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3v2tpF1cbWzk4N
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jan 2017 15:10:45 +0000 (UTC)
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

V2hlbiB6bWFsbG9jIG9mIHR5cGUtPm9wdCBmYWlsIHRoZSBkZXN0cm95X2N0eF90eXBlIHdvdWxk
IHJlc3VsdCBpbiBhCm51bGwgZGVyZWZlcmVuY2UuCgpTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBS
YWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+Ci0tLQogc3JjL2Jp
bi9sdHRuZy9jb21tYW5kcy9hZGRfY29udGV4dC5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRu
Zy9jb21tYW5kcy9hZGRfY29udGV4dC5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9hZGRfY29u
dGV4dC5jCmluZGV4IDVmYzY1YmYuLmRmNzIyYmIgMTAwNjQ0Ci0tLSBhL3NyYy9iaW4vbHR0bmcv
Y29tbWFuZHMvYWRkX2NvbnRleHQuYworKysgYi9zcmMvYmluL2x0dG5nL2NvbW1hbmRzL2FkZF9j
b250ZXh0LmMKQEAgLTY2Miw3ICs2NjIsOSBAQCB2b2lkIGRlc3Ryb3lfY3R4X3R5cGUoc3RydWN0
IGN0eF90eXBlICp0eXBlKQogCWlmICghdHlwZSkgewogCQlyZXR1cm47CiAJfQotCWZyZWUodHlw
ZS0+b3B0LT5zeW1ib2wpOworCWlmICh0eXBlLT5vcHQpIHsKKwkJZnJlZSh0eXBlLT5vcHQtPnN5
bWJvbCk7CisJfQogCWZyZWUodHlwZS0+b3B0KTsKIAlmcmVlKHR5cGUpOwogfQotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
